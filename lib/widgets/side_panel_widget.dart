import 'package:flutter/material.dart';

class SidePanelWidget extends StatefulWidget {
  const SidePanelWidget({super.key});

  @override
  State<SidePanelWidget> createState() => _SidePanelWidgetState();
}

class _SidePanelWidgetState extends State<SidePanelWidget> {
  bool isLiked = false;
  bool isShared = false;

  int likeCount = 0;
  int commentCount = 0;
  int shareCount = 0;

  List<String> comments = [];

  void _showCommentsBottomSheet() {
    final TextEditingController commentController = TextEditingController();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black87,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    "Comments",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Divider(color: Colors.white24, thickness: 1),

                // List of comments
                Expanded(
                  child: comments.isEmpty
                      ? const Center(
                          child: Text(
                            "No comments yet. Be the first!",
                            style: TextStyle(color: Colors.white54),
                          ),
                        )
                      : ListView.builder(
                          itemCount: comments.length,
                          itemBuilder: (_, index) => ListTile(
                            leading: const CircleAvatar(
                              backgroundColor: Colors.white24,
                              child: Icon(Icons.person, color: Colors.white),
                            ),
                            title: Text(
                              comments[index],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                ),

                // Comment input field
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 6,
                  ),
                  color: Colors.black54,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: commentController,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: "Write a comment...",
                            hintStyle: TextStyle(color: Colors.white54),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send, color: Colors.blue),
                        onPressed: () {
                          if (commentController.text.trim().isNotEmpty) {
                            setState(() {
                              comments.add(commentController.text.trim());
                              commentCount = comments.length;
                            });
                            commentController.clear();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _toggleLike() {
    setState(() {
      isLiked = !isLiked;
      likeCount += isLiked ? 1 : -1;
    });
  }

  void _toggleShare() {
    setState(() {
      isShared = !isShared;
      shareCount += isShared ? 1 : -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ❤️ Like
        GestureDetector(
          onTap: _toggleLike,
          child: Column(
            children: [
              Icon(Icons.favorite, color: isLiked ? Colors.red : Colors.white),
              Text('$likeCount', style: const TextStyle(color: Colors.white)),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // 💬 Comments
        GestureDetector(
          onTap: _showCommentsBottomSheet,
          child: Column(
            children: [
              const Icon(Icons.chat_bubble_outline, color: Colors.white),
              Text(
                '$commentCount',
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // 🔄 Share
        GestureDetector(
          onTap: _toggleShare,
          child: Column(
            children: [
              Icon(Icons.share, color: isShared ? Colors.green : Colors.white),
              Text('$shareCount', style: const TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ],
    );
  }
}
