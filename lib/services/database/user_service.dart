// ignore_for_file: avoid_print
import 'dart:io';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
FirebaseFirestore firestore = FirebaseFirestore.instance;
final usersCollectionRef = FirebaseFirestore.instance.collection('users');
final authenticationRepository = AuthenticationRepository();

// User CRUD
  // Check if user exists
  Future<bool> exists(String id) async {
    try {
      final snapShot = await usersCollectionRef.doc(id).get();
      if (snapShot.exists) {
        print('User has already existed.');
        return true;
      } else {
        print('User doesn\'t exist.'); 
        return false;
      }
    } catch (e) {
      print('$e');
      return false;
    }
  }

  // Create user
  Future<void> createUser(String id, User user) async {
    try {
      await usersCollectionRef.doc(id).set(user.toFirestore());
      print('User created successfully');
    } catch (e) {
      print('$e');
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getUsers() {
    return usersCollectionRef.snapshots();
  }

  // Get user info
  Future<DocumentSnapshot<Map<String, dynamic>>?> getUserInfo(String id) async {
    try {
      if (id != '') {
        return await usersCollectionRef.doc(id).get();
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Update user info
  Future<void> updateUserData(String id, User user) async {
    try {
      await usersCollectionRef.doc(id).update(user.toFirestore());
      print('Update user successfully.');
    } catch (e) { print('$e'); }
  } 

  // Delete user
  Future<void> deleteUser(String id, User user) async {
    try {
      await usersCollectionRef.doc(id).delete();
      print('Delete user successfully.');
    } catch (e) { print('$e'); }
  } 

  Future<String> uploadImageToStorage(File image) async {
    Reference storageReference = FirebaseStorage.instance.ref().child('images');
    UploadTask uploadTask = storageReference.putFile(image);

    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    String imgUrl = await taskSnapshot.ref.getDownloadURL(); 
    return imgUrl;
  }

  Future<void> updateAvatar(String id, String imgUrl) async {
     try {
      await usersCollectionRef.doc(id).update({'photo' : imgUrl});
      print('Update user successfully.');
    } catch (e) { print('$e'); }
  }
}
