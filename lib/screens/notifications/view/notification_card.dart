import 'package:flutter/material.dart';

import '../../../services/models/notification.dart';

class NotificationCard extends StatelessWidget {
  final AppNotification notification;
  const NotificationCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        leading: _NotificationIcon(category: notification.category),
        title: Text('${notification.name}'),
        subtitle: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${notification.description}'),
            Align(
              alignment: Alignment.bottomRight,
              child: Text('${notification.timestamp}'),
            )
          ],
        ),
        onTap: () {},
      )
    );
  }
}

class _NotificationIcon extends StatelessWidget {
  final String? category;
  const _NotificationIcon({required this.category});

  @override
  Widget build(BuildContext context) {
    switch(category) {
      case 'update': return Icon(Icons.update);
      case 'survey': return Icon(Icons.supervised_user_circle);
    }
    return SizedBox(height: 10, width: 10);
  }
}