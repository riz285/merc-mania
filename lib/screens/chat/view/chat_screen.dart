import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:merc_mania/services/database/user_service.dart';

import 'user_list_view.dart';
import '../cubit/chat_cubit.dart';

class ChatScreen extends StatefulWidget {
  
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final userService = UserService();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatCubit, ChatState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Chat Failure'),
              ),
            );
    
        }
      },
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream:  userService.getUsers(), 
        builder: (builder, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          if (snapshot.hasData) {
            final users = snapshot.data!.docs.map((doc) => User.fromJson(doc.data())).toList();
            return UserListView(users: users);
          }                                    
          return Text('No product data found');    
        },
      )
    );
  }
}