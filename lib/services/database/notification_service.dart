// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final notificationCollectionRef = FirebaseFirestore.instance.collection('notifications');

// CRUD
  // Add notification
  // Future<void> addNotification(Map<String, dynamic> data) async {
  //   try {
  //     await notificationCollectionRef.add({
  //       'content': data['notification'],
  //       'timestamp': FieldValue.serverTimestamp(),
  //     }).then((doc) {

  //     });
  //     print('Data added successfully');
  //   } catch (e) {
  //     print('$e');
  //   }
  // }

  // Retrieve notification
  Stream<QuerySnapshot<Map<String, dynamic>>> getNotifications() {
    return notificationCollectionRef.orderBy('timestamp', descending: true).snapshots();
  }

  // Deleta notifications
  // void deleteNotifications() {
  //   try {
  //     notificationCollectionRef.get().then((querySnapshot) {
  //       for (var doc in querySnapshot.docs) {
  //         doc.reference.delete();
  //       }
  //     });
  //   } catch (e) {
  //     print('$e');
  //   }
  // }
}