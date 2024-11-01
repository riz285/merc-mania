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
  
  @override
  void initState() {
    super.initState();
    fetchUserData();
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
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) => setState(() {}),
      child: FutureBuilder(
            future: fetchUserData(), 
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
              if (snapshot.hasError) return Text('Error: ${snapshot.error}');
              if (snapshot.hasData) {
                final userData = snapshot.data!.data()!;
                return Align(
                  alignment: Alignment(0, -1 / 3),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Center(child: Avatar(photo: userData['photo'], size: 40)),
                        const SizedBox(height: 30),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Email', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            Text(userData['email']),
                            const SizedBox(height: 10),
                            Text('Name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            Text('${userData['first_name']??''} ${userData['last_name']??''}'),
                            const SizedBox(height: 10),
                            Text('Phone number', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            Text(userData['phone_number']??''),
                            const SizedBox(height: 10),
                          ],
                        ),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.center,
                          child: _EditProfileButton())
                      ],
                    
                  ),
                );
              }
              return Text('No user data found');
            }
          ),
    );
      
  }
}

class _EditProfileButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: const Key('profileScreen_editProfile_flatButton'),
      onPressed: () {
        context.read<ProfileCubit>().initState();
        Navigator.of(context).push<void>(UpdateProfile.route());
      },
      child: Text(
        'EDIT PROFILE',
      ),
    );
  }
}