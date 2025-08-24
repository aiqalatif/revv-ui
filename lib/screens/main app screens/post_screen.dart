import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tiktok/screens/main%20app%20screens/post-detail-screen.dart';
import 'package:video_player/video_player.dart';
import 'package:google_fonts/google_fonts.dart';

class PostScreen extends StatefulWidget {
  final List<File> files;
  final bool isVideo;
  final String? category;
  final bool isBusinessMode;

  const PostScreen({
    super.key, 
    required this.files, 
    this.isVideo = false,
    this.category,
    this.isBusinessMode = false,
  });

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  late TextEditingController captionController;
  late TextEditingController hashtagController;
  VideoPlayerController? videoController;
  
  // Business features
  bool isScheduled = false;
  DateTime scheduledDate = DateTime.now().add(const Duration(hours: 1));
  String selectedCategory = 'General';
  bool isPublic = true;
  bool isCommentsEnabled = true;
  bool isAnalyticsEnabled = false;
  
  final List<String> categories = [
    'General', 'Business', 'Technology', 'Lifestyle', 
    'Food', 'Travel', 'Fitness', 'Education', 'Entertainment'
  ];

  @override
  void initState() {
    super.initState();
    captionController = TextEditingController();
    hashtagController = TextEditingController();
    
    if (widget.category != null) {
      selectedCategory = widget.category!;
    }

    if (widget.isVideo && widget.files.isNotEmpty) {
      _initializeVideo();
    }
  }

  Future<void> _initializeVideo() async {
    try {
      videoController = VideoPlayerController.file(widget.files.first);
      await videoController!.initialize();
      if (mounted) {
        setState(() {});
        videoController!.play();
      }
    } catch (e) {
      _showErrorDialog('Video Error', 'Failed to load video: $e');
    }
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _selectScheduledDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: scheduledDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(scheduledDate),
      );
      if (time != null) {
        setState(() {
          scheduledDate = DateTime(
            picked.year,
            picked.month,
            picked.day,
            time.hour,
            time.minute,
          );
        });
      }
    }
  }

  String _formatScheduledDate() {
    return '${scheduledDate.day}/${scheduledDate.month}/${scheduledDate.year} at ${scheduledDate.hour.toString().padLeft(2, '0')}:${scheduledDate.minute.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    captionController.dispose();
    hashtagController.dispose();
    videoController?.dispose();
    super.dispose();
  }
  // 🔹 Common pink color define kar lo


  @override
  Widget build(BuildContext context) {
    const appPink = Color(0xFFFF6B81);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'New Post',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: ElevatedButton(
              onPressed: _handlePost,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFF6B81),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: Text(
                'Post',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Media Preview
            _buildMediaPreview(),
            
            const SizedBox(height: 20),
            
            // Business Mode Indicator
            if (widget.isBusinessMode)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.business, color: appPink, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Business Mode Active',
                      style: GoogleFonts.poppins(
                        color: appPink,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            
            const SizedBox(height: 20),
            
            // Caption Input
            _buildInputSection(
              controller: captionController,
              hintText: 'Write a compelling caption...',
              maxLines: 4,
              icon: Icons.edit,
              label: 'Caption',
            ),
            
            const SizedBox(height: 20),
            
            // Hashtags Input
            _buildInputSection(
              controller: hashtagController,
              hintText: '#business #technology #innovation',
              maxLines: 2,
              icon: Icons.tag,
              label: 'Hashtags',
            ),
            
            const SizedBox(height: 20),
            
            // Business Features
            if (widget.isBusinessMode) _buildBusinessFeatures(),
            
            const SizedBox(height: 20),
            
            // Post Settings
            _buildPostSettings(),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildMediaPreview() {
    return Container(
      height: 300,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: widget.isVideo && videoController != null
            ? Stack(
                alignment: Alignment.center,
                children: [
                  VideoPlayer(videoController!),
                  // Video Controls Overlay
                  Positioned(
                    bottom: 16,
                    left: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              videoController!.value.isPlaying 
                                  ? Icons.pause 
                                  : Icons.play_arrow,
                              color: Colors.white,
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() {
                                if (videoController!.value.isPlaying) {
                                  videoController!.pause();
                                } else {
                                  videoController!.play();
                                }
                              });
                            },
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${videoController!.value.position.inSeconds}s / ${videoController!.value.duration.inSeconds}s',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : PageView.builder(
                itemCount: widget.files.length,
                itemBuilder: (context, index) {
                  return Image.file(
                    widget.files[index],
                    fit: BoxFit.cover,
                  );
                },
              ),
      ),
    );
  }

  Widget _buildInputSection({
    required TextEditingController controller,
    required String hintText,
    required int maxLines,
    required IconData icon,
    required String label,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              color: Colors.white70,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 16,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: GoogleFonts.poppins(
                color: Colors.white38,
                fontSize: 16,
              ),
              prefixIcon: Icon(icon, color: Colors.white54),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.white24),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.white24),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xFFFF6B81)),
              ),
              filled: true,
              fillColor: Colors.white.withOpacity(0.05),
            ),
            maxLines: maxLines,
          ),
        ],
      ),
    );
  }

  Widget _buildBusinessFeatures() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Business Features',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          
          // Category Selection
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Category',
                  style: GoogleFonts.poppins(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: selectedCategory,
                  dropdownColor: Colors.black87,
                  style: GoogleFonts.poppins(color: Colors.white),
                  decoration:  InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white30),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color:Color(0xFFFF6B81) ),
                    ),
                  ),
                  items: categories.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() => selectedCategory = value!);
                  },
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Post Scheduling
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white24),
            ),
            child: Row(
              children: [
                Icon(Icons.schedule, color: Colors.blue, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Schedule Post',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        isScheduled ? _formatScheduledDate() : 'Post immediately',
                        style: GoogleFonts.poppins(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: isScheduled,
                  onChanged: (value) {
                    setState(() => isScheduled = value);
                    if (value) {
                      _selectScheduledDate();
                    }
                  },
                  activeColor: Color(0xFFFF6B81),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Analytics Toggle
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white24),
            ),
            child: Row(
              children: [
                Icon(Icons.analytics, color: Color(0xFFFF6B81), size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Enable Analytics',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Track post performance and engagement',
                        style: GoogleFonts.poppins(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: isAnalyticsEnabled,
                  onChanged: (value) {
                    setState(() => isAnalyticsEnabled = value);
                  },
                  activeColor: Colors.green,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostSettings() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Post Settings',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          
          // Privacy Setting
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white24),
            ),
            child: Row(
              children: [
                Icon(
                  isPublic ? Icons.public : Icons.lock,
                  color: isPublic ? Color(0xFFFF6B81) : Colors.orange,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isPublic ? 'Public Post' : 'Private Post',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        isPublic ? 'Visible to everyone' : 'Only you can see this',
                        style: GoogleFonts.poppins(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: isPublic,
                  onChanged: (value) {
                    setState(() => isPublic = value);
                  },
                  activeColor: Color(0xFFFF6B81),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Comments Setting
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white24),
            ),
            child: Row(
              children: [
                Icon(
                  isCommentsEnabled ? Icons.comment : Icons.comment_outlined,
                  color: isCommentsEnabled ? Color(0xFFFF6B81) : Colors.grey,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isCommentsEnabled ? 'Comments Enabled' : 'Comments Disabled',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        isCommentsEnabled ? 'Users can comment on your post' : 'No comments allowed',
                        style: GoogleFonts.poppins(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: isCommentsEnabled,
                  onChanged: (value) {
                    setState(() => isCommentsEnabled = value);
                  },
                  activeColor: Color(0xFFFF6B81),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handlePost() {
  // TODO: Implement actual post upload logic
  // This would include:
  // - File upload to cloud storage
  // - Post metadata creation
  // - Scheduling if enabled
  // - Analytics setup if enabled

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        isScheduled
            ? 'Post scheduled for ${_formatScheduledDate()}'
            : 'Post created successfully!',
        style: GoogleFonts.poppins(),
      ),
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 2),
    ),
  );

  // ✅ Post create hone ke baad PostCardScreen par redirect
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => PostCarScreen()),
  );
}
}


class PostCarScreen extends StatelessWidget {
  final List<Map<String, dynamic>> cars = [
    {'name': 'Toyota Corolla', 'date': 'Aug 1, 2023', 'likes': 123},
    {'name': 'Honda Civic', 'date': 'Aug 5, 2023', 'likes': 98},
    {'name': 'BMW 3 Series', 'date': 'Aug 10, 2023', 'likes': 212},
    {'name': 'Tesla Model 3', 'date': 'Aug 15, 2023', 'likes': 145},
    
    {'name': 'Honda Civic', 'date': 'Aug 5, 2023', 'likes': 98},
    {'name': 'BMW 3 Series', 'date': 'Aug 10, 2023', 'likes': 212},
    {'name': 'Tesla Model 3', 'date': 'Aug 15, 2023', 'likes': 145},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' Market Place '),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
        child: Column(
      
          children: [
            SizedBox(height: 50,),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Two cards per row
                  crossAxisSpacing: 15, // Space between cards horizontally
                  mainAxisSpacing: 15, // Space between cards vertically
                  childAspectRatio: 1, // Adjust the aspect ratio to match the card
                ),
                itemCount: cars.length,
                itemBuilder: (context, index) {
                  final car = cars[index];
                  return GestureDetector(
                    onTap: (){
                       Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>CarDetailPage()
        ),
      );
                    },
                    child: CarCard(
                      name: car['name'],
                      date: car['date'],
                      likes: car['likes'],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class CarCard extends StatelessWidget {
  final String name;
  final String date;
  final int likes;

  const CarCard({
    Key? key,
    required this.name,
    required this.date,
    required this.likes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
   
      width: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          width: 0.6,
          color: Colors.grey.shade300, // Light border
        ),
      ),
      padding: const EdgeInsets.all(5), // thoda compact padding
      child: Column(
        
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Car Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/images/carcard.png',
              height: 80,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 5), // 👈 gap kam kiya

          // Car name + likes
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 16,
                  ),
                  Text(
                    likes.toString(),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 3), // 👈 yahan bhi gap chhota kiya

          // Date
          Text(
            date,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
