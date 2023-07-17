import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:projexity/models/message.dart';

Future<String> getNameFromUID(String uid) async {
  final collection = FirebaseFirestore.instance.collection('users');
  final document = await collection.doc(uid).get();

  if (document.exists) {
    final data = document.data();
    final name = data?['name'];
    return name;
  } else {
    return '';
  }
}

class ChatService extends ChangeNotifier {
  // Instance of auth and firestore
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Send message
  Future<void> sendMessage(String receiverId, String message) async {
    //get current user info
    final String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    final String currentUsername = await getNameFromUID(currentUserId);
    final Timestamp timestamp = Timestamp.now();

    //create new message
    Message newMessage = Message(
        senderId: currentUserId,
        senderName: currentUsername,
        receiverId: receiverId,
        message: message,
        timestamp: timestamp);

    //construct chat room id from current user id and receiver id
    List<String> ids = [currentUserId, receiverId];
    ids.sort(); //sort ids
    String chatRoomId = ids.join("_");
    print(chatRoomId);
    //add new message to database
    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .add(newMessage.toMap());
  }

  //get messages
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");
    print("get " + chatRoomId);
    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
