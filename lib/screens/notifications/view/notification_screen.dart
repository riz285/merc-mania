import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:merc_mania/common/widgets/styled_drawer.dart';
import 'package:merc_mania/services/database/notification_service.dart';

import 'notification_list_view.dart';
import '../../../services/models/notification.dart';
class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationService = NotificationService();
    return Scaffold(
      appBar: AppBar(
            title: const Text('Notifications'),
          leading: Builder(builder: (BuildContext context) => IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            }, 
            icon: Icon(Icons.menu))),
        ),
      drawer: StyledDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream:  notificationService.getNotifications(), 
          builder: (builder, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            if (snapshot.hasData) {
              final notifications = snapshot.data!.docs.map((doc) => AppNotification.fromJson(doc.data())).toList();
              return notifications.isNotEmpty ? NotificationListView(notifications: notifications) : Align(child: Text('There is no notifications.'));
            }                                    
            return Text('No data found');    
          }
        ),
      ),
    );
  }
}

 