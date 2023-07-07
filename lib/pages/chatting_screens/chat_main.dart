// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:projexity/components/user_image.dart';
import 'package:projexity/pages/chatting_screens/chat_page.dart';

class ChatMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromRGBO(249, 200, 6, 1),
          title: Text(
            'Chat',
            style: TextStyle(fontSize: 30.0),
          )),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text(
                  'Your Chats',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: 4, //change to no. of chats user has
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          // Navigator.pushNamed(
                          //   context,
                          //   '/chat',
                          // );
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ChatPage()),
                          );
                        },
                        // onTap: () {
                        // Navigator.pushNamed(context, '/chat',
                        //     arguments: activeMatches[index]);
                        // },
                        child: Row(
                          children: [
                            UserImage.small(
                              margin: const EdgeInsets.only(top: 10, right: 10),
                              height: 70,
                              width: 70,
                              url:
                                  'https://i.scdn.co/image/ab6761610000e5eb1a992102d607e2b48095d5e4',
                              //url: activeMatches[index].matchedUser.imageUrls[0],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    //activeMatches[index].matchedUser.name,
                                    "Mrs piggy",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 5),
                                //last text
                                Text("sup"
                                    // activeMatches[index]
                                    //     .chat![0]
                                    //     .messages[0]
                                    //     .message,
                                    //style: Theme.of(context).textTheme.headline6,
                                    ),
                                SizedBox(height: 5),
                                //time stamp
                                Text("4:30"
                                    // activeMatches[index]
                                    //     .chat![0]
                                    //     .messages[0]
                                    //     .timeString,

                                    ),
                              ],
                            )
                          ],
                        ),
                      );
                    })
              ],
            )),
      ),
      //Center(child: Text("ChatMain")),
    );
  }
}
