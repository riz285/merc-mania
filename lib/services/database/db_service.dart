// ignore_for_file: avoid_print
import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DbService {
FirebaseFirestore firestore = FirebaseFirestore.instance;
final usersCollectionRef = FirebaseFirestore.instance.collection('users');
final authenticationRepository = AuthenticationRepository();

// CRUD
  // Add data
  Future<void> addData(String collectionName, Map<String, dynamic> data) async {
    try {
      await firestore.collection(collectionName).add(data);
      print('Data added successfully');
    } catch (e) {
      print('$e');
    }
  }

  // Retrieve data
  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getData(String collectionName) async {
    try {
      return firestore.collection(collectionName).snapshots();
    } catch (e) {
      print('$e');
      return Stream.empty();
    }
  }

  // Update data


  // Deleta data
  Future<void> deleteData(String collectionName, String id) async {
    try {
      await firestore.collection(collectionName).doc(id).delete();
      print('Data deleted successfully');
    } catch (e) {
      print('$e');
    }
  }

// User CRUD
  // Create user
  Future<void> createUser(String id, User user) async {
    try {
      await usersCollectionRef.doc(id).set(user.toJson());
      print('User created successfully');
    } catch (e) {
      print('$e');
    }
  }
  // Get user info
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserInfo() async {
    final currentUser = authenticationRepository.currentUser;
    print(currentUser.id);
    return await usersCollectionRef.doc(currentUser.id).get();
  }

  // Update user info
  Future<void> updateUserData(String id, User user) async {
    try {
      await usersCollectionRef.doc(id).update(user.toJson());
    } catch (e) { print('$e'); }
  } 

  // Delete user
  Future<void> deleteUser(String id, User user) async {
    try {
      await usersCollectionRef.doc(id).delete();
    } catch (e) { print('$e'); }
  } 
}
