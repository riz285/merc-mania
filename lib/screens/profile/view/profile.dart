import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:merc_mania/services/database/db_service.dart';
import '../../../core/configs/assets/avatar.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final db = DbService();
  DocumentSnapshot<Map<String, dynamic>>? userData;
  
  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  // Fetch current user data
  Future<void> fetchUser() async {
    try {
      userData = await db.getUserInfo();
      setState(() {});
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching user data: $e');
    }
  }

  //Update user data

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(),
      body: FutureBuilder(
        future: fetchUser(), 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return CircularProgressIndicator();
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          if (!snapshot.hasData) return Text('No user data found');
          return Align (
        alignment: const Alignment(0, -1 / 3),
        // User data
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Avatar(photo: userData?['photo']),
              const SizedBox(height: 8),
              Text('Email: ${userData?['email']}'),
              const SizedBox(height: 8),
              Text('Name: ${userData?['name']}'),
              // const SizedBox(height: 8),
              // Text('Phone number: ${user.phoneNumber ?? ''}'),
            ],
          )
        );
      })
    );
  }
}