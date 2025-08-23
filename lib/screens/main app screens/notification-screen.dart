import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> notifications = [
      {"title": "New Message", "subtitle": "You got a reply on your post"},
      {"title": "Offer Received", "subtitle": "Ali offered \$5000 for your car"},
      {"title": "System Update", "subtitle": "App updated to v1.2"},
    ];

    return Scaffold(
 
      appBar: AppBar(
        title: const Text("Notifications"),
        backgroundColor: Colors.black,
        leading:   GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10 ) ,
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                     gradient: LinearGradient(
                colors: 
                  const [Colors.orange, Colors.pink]
                 
                            ), 
                  ),
                  child: Icon(Icons.arrow_forward_ios,size: 25,)),
              ),
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 50,),
            Expanded(
              child: ListView.separated(
                itemCount: notifications.length,
                separatorBuilder: (context, index) => const SizedBox(),
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.notifications, color: Colors.white),
                    title: Text(notifications[index]["title"]!),
                    subtitle: Text(notifications[index]["subtitle"]!),
                    trailing: const Icon(Icons.chevron_right),
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
