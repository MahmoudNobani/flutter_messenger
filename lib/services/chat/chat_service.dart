import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messenger/model/message.dart';

class ChatService extends ChangeNotifier {
  // instance of auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // instance of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Send messages
  Future<void> sendMessage(String receiverId, String message) async {
    // get user info
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    // create new msg
    Message newMsg = Message(senderId: currentUserId, senderEmail: currentUserEmail, receiverId: receiverId, message: message, timestamp: timestamp);

    // construct room ID
    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    // add new message
    await _firestore.collection('chat_room').doc(chatRoomId).collection('messages').add(newMsg.toMap());
  }


  // get messages
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _firestore.collection('chat_room').doc(chatRoomId).collection('messages').orderBy('timestamp', descending: false).snapshots();
  }


}