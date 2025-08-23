import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tiktok/widgets/custom-bottam.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentPostIndex = 0;

  final List<Map<String, dynamic>> posts = [
    {
      'username': 'CarEnthusiast',
      'caption': 'Just got my dream car! 🚗✨ #DreamCar #Luxury',
      'likes': '2.4K',
      'comments': '156',
      'shares': '89',
      'isLiked': false,
      'isFollowing': false,
    },
    {
      'username': 'SpeedDemon',
      'caption': 'Weekend drive through the mountains 🏔️ #WeekendVibes #CarLife',
      'likes': '1.8K',
      'comments': '234',
      'shares': '67',
      'isLiked': false,
      'isFollowing': true,
    },
    {
      'username': 'AutoCollector',
      'caption': 'My vintage collection is growing! 🚙 #VintageCars #Collection',
      'likes': '3.2K',
      'comments': '445',
      'shares': '123',
      'isLiked': false,
      'isFollowing': false,
    },
  ];
bool _showDetails = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: posts.length,
        onPageChanged: (index) {
          setState(() {
            _currentPostIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return _buildPostCard(posts[index], index);
        },
      ),
    );
  }

  Widget _buildPostCard(Map<String, dynamic> post, int index) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      color: Colors.black,
      child: Stack(
        children: [
          // Placeholder for video/image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
             image: DecorationImage(image: AssetImage('assets/images/carIcon.png',),
             fit: BoxFit.cover)
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.play_circle_outline,
                    size: 80,
                    color: Colors.white.withOpacity(0.7),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Post ${index + 1}',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Right side action buttons
          Positioned(
            right: 20,
            bottom: 120,
            child: Column(
              children: [
                _buildActionButton(
                  'assets/images/Likes.png',
                  post['likes'],
                  post['isLiked'],
                  () => _toggleLike(index),
                ),
                const SizedBox(height: 20),
               _buildActionButton(
  'assets/images/comment.png',
  post['comments'].length.toString(), // comment count dikhane ke liye
  false,
  () {
    _showComments(post); // yahan call hoga jab button press hoga
  },
),


                const SizedBox(height: 20),
                _buildActionButton(
                  'assets/images/Share.png',
                  post['shares'],
                  false,
                  () => _sharePost(post),
                ),
              ],
            ),
          ),
          
          // Bottom content area
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.8),
                    Colors.black,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '@${post['username']}',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 12),
                      if (!post['isFollowing'])
                        GestureDetector(
                          onTap: () => _toggleFollow(index),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Follow',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        )
                      else
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                            ),
                          ),
                          child: Text(
                            'Following',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                   const SizedBox(height: 5),
            Text(
                    'Caption of the post 😉 \n#fyp',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                      height: 1.4,
                    ),
                  ),
                   GestureDetector(
              onTap: () {
                setState(() {
                  _showDetails = !_showDetails;
                });
              },
              child: Icon(
                _showDetails ? Icons.close : Icons.more_horiz,
                color: Colors.white,
                size: 24,
              ),
            ),
            
          if (_showDetails) ...[
                  const SizedBox(height: 12),
                  Text(
                    post['caption'],
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 5,),
                   GestureDetector(
                          onTap: () => _toggleFollow(index),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'For Sale',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
          ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    String icon,
    String count,
    bool isActive,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(
            icon,
            color: isActive ? Colors.red : Colors.white,
            scale: 5,
          ),
          const SizedBox(height: 4),
          Text(
            count,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _toggleLike(int index) {
    setState(() {
      posts[index]['isLiked'] = !posts[index]['isLiked'];
    });
  }

  void _toggleFollow(int index) {
    setState(() {
      posts[index]['isFollowing'] = !posts[index]['isFollowing'];
    });
  }

void _showComments(Map<String, dynamic> post) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent, // sheet rounded lagay
    builder: (context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.55, // 👈 yahan control hai (55% screen)
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: CustomBottomSheet(
          title: "Comments",
          subtitle: "See what others are saying",
          body: (post['comments'] is List)
              ? ListView.builder(
                  itemCount: post['comments'].length,
                  itemBuilder: (_, index) {
                    final comment = post['comments'][index];
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text(comment['user'][0].toUpperCase()),
                      ),
                      title: Text(comment['text']),
                    );
                  },
                )
              : const Center(
                  child: Text("No comments yet", style: TextStyle(color: Colors.white)),
                ),
          inputField: Row(
            children: [
             Expanded(
  child: TextField(
    decoration: InputDecoration(
      hintText: "Add a comment...",
      filled: true, // background fill enable
      fillColor: Colors.grey.shade200, // halka gray background
      contentPadding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 12,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.grey), // gray border
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.blue), // active border
      ),
    ),
  ),
),
 GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10 ) ,
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                     gradient: LinearGradient(
                colors: 
                  const [Colors.orange, Colors.pink]
                 
                            ), 
                  ),
                  child: IconButton(
                  icon: const Icon(Icons.send, color: Colors.white),
                  onPressed: () {
                    // send logic
                  },
                ),),
              ),
             
            ],
          ),
        ),
      );
    },
  );
}


  void _sharePost(Map<String, dynamic> post) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sharing ${post['username']}\'s post'),
        backgroundColor: Colors.grey[800],
      ),
    );
  }
}
