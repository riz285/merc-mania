// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

class MessageService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final messageCollectionRef = FirebaseFirestore.instance.collection('messages');

// CRUD
  // Add message
  Future<void> addMessage(Map<String, dynamic> data) async {
    try {
      await messageCollectionRef.add(data);
      print('Data added successfully');
    } catch (e) {
      print('$e');
    }
  }

  // Retrieve message
  Stream<QuerySnapshot<Map<String, dynamic>>>? getMessages(String id) {
    try {
      return messageCollectionRef.where('chat_id', isEqualTo: id)
                                 .orderBy('timestamp').snapshots();
    } catch (e) {
      return null;
    }
}

  // Delete messages
  // void deleteMessages() {
  //   try {
  //     messageCollectionRef.get().then((querySnapshot) {
  //       for (var doc in querySnapshot.docs) {
  //         doc.reference.delete();
  //       }
  //     });
  //   } catch (e) {
  //     print('$e');
  //   }
  // }
}