import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:merc_mania/core/configs/assets/avatar.dart';

import '../../services/database/user_service.dart';

class ChatSearchDelegate extends SearchDelegate<String> {
  final userService = UserService();
  
  @override
  List<Widget>? buildActions(BuildContext context) {
    if (query.isNotEmpty) {
      return [IconButton(onPressed: () => query = '', icon: Icon(Icons.clear_outlined))];
    }
    return null;
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: () => close(context, ''), icon: Icon(Icons.navigate_before));
  }

  @override
  Widget buildResults(BuildContext context) {
    final searchedWord = query.toLowerCase().split(' ');
    StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: userService.getUsers(), 
          builder: (builder, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            if (snapshot.hasData) {
              final users = snapshot.data!.docs.map((doc) => result(doc.data(), searchedWord)).toList();
            return ListView.separated(
              itemCount: users.length,
              itemBuilder: (context, index) => users[index] == User.empty ? Container() : InkWell(
                onTap: () {
                    // Navigator.of(context).push(
                    //     MaterialPageRoute(
                    //       builder: (context) => ChatBox(user: users[index]),
                    //     ),
                    // );
                  },
                  child: SizedBox(
                    height: 100,
                    child: Row(children: [
                      SizedBox(width: 10),
                      Avatar(photo: users[index].photo),
                      SizedBox(width: 8),
                      Text('${users[index].firstName??''} ${users[index].lastName??''}'),
                    ],),
                  )
              ),
              separatorBuilder: (context, index) => SizedBox(width: 10),
              );
            }                                    
            return Text('No user data found');    
          }
        );
        return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final searchedWord = query.toLowerCase().split(' ');
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: userService.getUsers(), 
          builder: (builder, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            if (snapshot.hasData) {
              final users = snapshot.data!.docs.map((doc) => result(doc.data(), searchedWord)).toList();
            return query.isEmpty ? Container() : ListView.separated(
              itemCount: users.length,
              itemBuilder: (context, index) => users[index]==User.empty ? Container() : InkWell(
                onTap: () {
                    // Navigator.of(context).push(
                    //     MaterialPageRoute(
                    //       builder: (context) => ChatBox(user: users[index]),
                    //     ),
                    // );
                  },
                  child: SizedBox(
                    height: 100,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Row(children: [
                        SizedBox(width: 10),
                        Avatar(photo: users[index].photo),
                        SizedBox(width: 8),
                        Text('${users[index].firstName??''} ${users[index].lastName??''}'),
                      ],),
                    ),
                  )
              ),
              separatorBuilder: (context, index) => SizedBox(width: 10),
              );
            }                                                    
            return Text('No user data found');    
          }
        );
  }
  
  @override
  String get searchFieldLabel => 'Search for any user?';
  

}

User result (Map<String, dynamic> data, List<String> query) {
  final name = data['first_name'].toLowerCase().split(' ').toSet(); // Chat name
  final querySet = query.toSet(); // Search Query
    if (name.containsAll(querySet)) {
      return User.fromJson(data);
    }
  return User.empty;
}

