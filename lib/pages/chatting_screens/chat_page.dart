// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projexity/components/chat_bubble.dart';
import 'package:projexity/pages/chatting_screens/chat_service.dart';

class ChatPage extends StatefulWidget {
  static const String routeName = '/chat';
  final String receiverUserName;
  final String receieverID;

  const ChatPage(
      {super.key, required this.receiverUserName, required this.receieverID});
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receieverID, _messageController.text);
      _messageController.clear();
    }
  }

  Future<String> _getPfpFromUID(String uid) async {
    final collection = FirebaseFirestore.instance.collection('users');
    final document = await collection.doc(uid).get();

    if (document.exists) {
      final data = document.data();
      final pfp = data?['profileImageUrl'];
      return pfp;
    } else {
      return '';
    }
  }

  Future<String> _setImage() async {
    final receiverPfp = await _getPfpFromUID(widget.receieverID);
    if (receiverPfp.isNotEmpty) {
      return receiverPfp;
    } else {
      return 'lib/images/smiley.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    final receiverPfp = _getPfpFromUID(widget.receieverID);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65),
        child: AppBar(
          //backgroundColor: Color.fromARGB(255, 221, 221, 221),
          backgroundColor: Color.fromRGBO(249, 200, 6, 1),
          elevation: 0,
          // iconTheme: IconThemeData(
          //   color: Theme.of(context).primaryColor,
          // ),
          centerTitle: true,
          title: FutureBuilder<String>(
              future: _getPfpFromUID(widget.receieverID),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                final receiverPfp = snapshot.data ?? 'lib/images/smiley.png';
                return Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundImage: NetworkImage(receiverPfp),
                    ),
                    SizedBox(height: 5),
                    Text(
                      //userMatch.matchedUser.name,
                      widget.receiverUserName,
                      style: TextStyle(fontSize: 15, color: Colors.grey[800]),
                    )
                  ],
                );
              }),
        ),
      ),
      body: Column(children: [
        Expanded(
          child: _buildMessageList(),
        ),
        _buildMessageInput()
      ]),
    );
  }

  //build message list
  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(
          widget.receieverID, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error" + snapshot.error.toString());
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }
        return ListView(
          children: snapshot.data!.docs
              .map((document) => _buildMessageItem(document))
              .toList(),
        );
      },
    );
  }

  //build message item
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    //align messages to right if sender is current user, else left
    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;
    return Container(
      alignment: alignment,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: (data['senderId'] == _firebaseAuth.currentUser!.uid)
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Text(data['senderName']),
          const SizedBox(height: 5),
          ChatBubble(message: data['message']),
        ],
      ),
    );
  }

  //build message input
  Widget _buildMessageInput() {
    return Container(
        padding: const EdgeInsets.all(20.0),
        height: 100,
        child: Row(children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Type here...',
                contentPadding:
                    const EdgeInsets.only(left: 20, bottom: 5, top: 5),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 0),
                    gapPadding: 10,
                    borderRadius: BorderRadius.circular(20)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(width: 15),
          GestureDetector(
            onTap: sendMessage,
            child: Container(
              padding: EdgeInsets.all(7),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 243, 196, 66)),
              child: Icon(Icons.send, color: Colors.white),
            ),
          )
        ]));
  }
}
