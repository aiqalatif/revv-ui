import 'package:flutter/material.dart';
import 'chat_detail_screen.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample chat data
    final chats = [
      {
        "name": "Athalia Putri",
        "message": "Good morning, did you sleep well?",
        "time": "3m ago",
        "isOnline": true,
        "avatar": "assets/images/user1.png",
      },
      {
        "name": "UX Team",
        "message": "How is it going?",
        "time": "15m ago",
        "isOnline": false,
        "avatar": "assets/images/user2.png",
      },
      {
        "name": "Erlan Sodewa",
        "message": "Aight, noted",
        "time": "1h ago",
        "isOnline": false,
        "avatar": "assets/images/user3.png",
      },
      {
        "name": "Athalia Putri",
        "message": "Good morning, did you sleep well?",
        "time": "3m ago",
        "isOnline": true,
        "avatar": "assets/images/user4.png",
      },
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Contacts",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notification_add_rounded, color: Colors.white),
            onPressed: () {},
          ),
          
        ],
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
          itemCount: chats.length,
          itemBuilder: (context, index) {
            final chat = chats[index];
            return ListTile(
              leading: Stack(
                children: [
                 CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, color: Colors.white),
              ),
                  if (chat["isOnline"] == true)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                      ),
                    ),
                ],
              ),
              title: Text(
                'Athalia Putri',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                "How is it going?",
                style: const TextStyle(color: Colors.white70, fontSize: 13),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Text(
                "3m ago",
                style: const TextStyle(color: Colors.white54, fontSize: 12),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatDetailScreen(userName:  'Athalia Putri',),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
