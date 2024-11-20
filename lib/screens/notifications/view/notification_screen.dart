import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merc_mania/common/widgets/styled_drawer.dart';
import 'package:merc_mania/screens/notifications/cubit/notifications_cubit.dart';

import 'notification_list_view.dart';
import '../../../services/models/notification.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> with SingleTickerProviderStateMixin{
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notification = context.select((NotificationCubit cubit) => cubit);
    return BlocListener<NotificationCubit, NotificationState>(
      listener: (context, state) => setState(() {}),
      child: Scaffold(
        appBar: AppBar(
            title: const Text('Notifications'),
            leading: Builder(builder: (BuildContext context) => IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              }, 
              icon: Icon(Icons.menu))),
            bottom: TabBar(
              controller: tabController,
              tabs: [
                Tab(text: 'General'),
                Tab(text: 'Important')
              ])
          ),
        drawer: StyledDrawer(),
        body: TabBarView(
          controller: tabController,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream:  notification.getGeneralNotifications(), 
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream:  notification.getImportantNotifications(), 
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
          ])
      ),
    );
  }
}

 