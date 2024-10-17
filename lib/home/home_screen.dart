import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:merc_mania/services/database/product_service.dart';
import 'package:merc_mania/services/models/product_list.dart';

import '../services/models/product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final productService = ProductService();

  Stream<QuerySnapshot<Map<String, dynamic>>> getProducts() {
      return  productService.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Category #1
        Text(
          'Category #1', 
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 150,
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream:  getProducts(), 
              builder: (builder, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
                if (snapshot.hasError) return Text('Error: ${snapshot.error}');
                if (snapshot.hasData) {
                  final products = snapshot.data!.docs.map((doc) => Product.fromFirestore(doc)).toList();
                  return ProductList(products: products);
                }                                    
                return Text('No product data found');    
              }
            ),
        ),
        Text(
          'Category #2', 
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 150,
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream:  getProducts(), 
              builder: (builder, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
                if (snapshot.hasError) return Text('Error: ${snapshot.error}');
                if (snapshot.hasData) {
                  final products = snapshot.data!.docs.map((doc) => Product.fromFirestore(doc)).toList();
                  return ProductList(products: products);
                }                                    
                return Text('No product data found');    
              }
            ),
        ),
        Text(
          'Category #3', 
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 150,
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream:  getProducts(), 
              builder: (builder, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
                if (snapshot.hasError) return Text('Error: ${snapshot.error}');
                if (snapshot.hasData) {
                  final products = snapshot.data!.docs.map((doc) => Product.fromFirestore(doc)).toList();
                  return ProductList(products: products);
                }                                    
                return Text('No product data found');    
              }
            ),
        ),
        Text(
          'Category #4', 
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 150,
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream:  getProducts(), 
              builder: (builder, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
                if (snapshot.hasError) return Text('Error: ${snapshot.error}');
                if (snapshot.hasData) {
                  final products = snapshot.data!.docs.map((doc) => Product.fromFirestore(doc)).toList();
                  return ProductList(products: products);
                }                                    
                return Text('No product data found');    
              }
            ),
        ),
      ],
    );
  }
}