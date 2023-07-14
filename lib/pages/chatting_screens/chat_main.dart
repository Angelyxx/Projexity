// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projexity/components/user_image.dart';
import 'package:projexity/pages/chatting_screens/chat_page.dart';

// Retrieve the user data from Firestore

// Retrieve the specific user document from Firestore
Future<DocumentSnapshot<Map<String, dynamic>>> fetchUserDocument(
    String userId) async {
  final snapshot =
      await FirebaseFirestore.instance.collection('users').doc(userId).get();
  return snapshot;
}

class ChatMain extends StatelessWidget {
  final String userId;
  ChatMain({required this.userId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: fetchUserDocument(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final userData = snapshot.data?.data();
            if (userData == null) {
              return Text("not found");
            }

            //access array field of user IDs
            final chatUserIds = userData['matches'] as List<dynamic>;

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
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: chatUserIds
                                .length, //change to no. of chats user has
                            itemBuilder: (context, index) {
                              final chatUserId = chatUserIds[index];
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                return FutureBuilder<
                                        DocumentSnapshot<Map<String, dynamic>>>(
                                    future: fetchUserDocument(chatUserId),
                                    builder: (context, snapshot) {
                                      final chatUser = snapshot.data?.data();
                                      if (chatUser == null) {
                                        return Text("User not found");
                                      }
                                      //print(chatUser);
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ChatPage()),
                                          );
                                        },
                                        // onTap: () {
                                        // Navigator.pushNamed(dcocontext, '/chat',
                                        //     arguments: activeMatches[index]);
                                        // },
                                        child: Row(
                                          children: [
                                            UserImage.small(
                                                margin: const EdgeInsets.only(
                                                    top: 10, right: 10),
                                                height: 70,
                                                width: 70,
                                                url: chatUser["profileImageUrl"]
                                                //url: activeMatches[index].matchedUser.imageUrls[0],
                                                ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    //activeMatches[index].matchedUser.name,
                                                    chatUser["name"],
                                                    // chatUser['name'],
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                SizedBox(height: 5),
                                                //last text
                                                Text(""
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
                                    });
                              }
                            })
                      ],
                    )),
              ),
              //Center(child: Text("ChatMain")),
            );
          }
        });
  }
}
