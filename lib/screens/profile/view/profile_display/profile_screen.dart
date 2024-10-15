import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/configs/assets/avatar.dart';
import '../../cubit/profile_cubit.dart';
import '../edit_profile/update_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<DocumentSnapshot<Map<String, dynamic>>?> data;
  
  @override
  void initState() {
    super.initState();
    data = fetchUserData();
  }

  // Fetch current user data
  Future<DocumentSnapshot<Map<String, dynamic>>?> fetchUserData() async {
    try {
      return await context.read<ProfileCubit>().fetchUserData();
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching user data: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchUserData(), 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return CircularProgressIndicator();
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          if (snapshot.hasData) {
            final userData = snapshot.data!.data()!;
            return Align (
              alignment: const Alignment(0, -1 / 3),
              // User data
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Avatar(photo: '${userData['photo']}'),
              const SizedBox(height: 8),
              Text('Email: ${userData['email']}'),
              const SizedBox(height: 8),
              Text('First name: ${userData['first_name']}'),
              const SizedBox(height: 8),
              Text('Last name: ${userData['last_name']??''}'),
              const SizedBox(height: 8),
              Text('Phone number: ${userData['phone_number']??''}'),
              const SizedBox(height: 8),
              _EditProfileButton()
              ],
            )
          );
        }
        return Text('No user data found');
      }
    );
  }
}

class _EditProfileButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: const Key('profileScreen_editProfile_flatButton'),
      // TODO: update data display
      onPressed: () => Navigator.of(context).push<void>(UpdateProfile.route()),
      child: Text(
        'EDIT PROFILE',
      ),
    );
  }
}