import 'package:flutter/material.dart';
import 'package:merc_mania/services/models/notification.dart';

import 'notification_card.dart';

class NotificationListView extends StatelessWidget {
  final List<AppNotification> notifications;
  const NotificationListView({super.key, required this.notifications});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
              itemCount: notifications.length,
              itemBuilder: (context, index) => NotificationCard(notification: notifications[index]), 
              separatorBuilder: (context, index) => SizedBox(width: 5),
    );
  }
}