// ignore_for_file: avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/product.dart';

class ProductService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final productCollectionRef = FirebaseFirestore.instance.collection('products');
  final favoriteProductRelationRef = FirebaseFirestore.instance.collection('user_favorite_item_relationships');
  
// CRUD
  /// Add New Product
  Future<void> addProduct(Map<String, dynamic> data) async {
    try {
      await productCollectionRef.add(data);
      print('Data added successfully');
    } catch (e) {
      print('$e');
    }
  }

  /// Get Products from List
  Future<List<Product>> getProductsFromList(List<String> ids) async {
    List<Product> products = [];
    for (String id in ids) {
      final docRef = productCollectionRef.doc(id);
      final doc = await docRef.get();

      if (doc.exists) { products.add(Product.fromJson(doc.data()!)); }
      } 
    return products;
  }

  // Get all Products
  Stream<QuerySnapshot<Map<String, dynamic>>> getProducts() {
    return productCollectionRef.snapshots();
  }

  // Get popular Products
  Future<QuerySnapshot<Map<String, dynamic>>> getPopularProducts() async {
    return productCollectionRef.orderBy('view_count', descending: true).limit(8).get();
  }

  // Products from chosen Franchise
  Stream<QuerySnapshot<Map<String, dynamic>>> getProductsFromFranchise(String id) {
    return productCollectionRef.where('franchise', isEqualTo: id).snapshots();
  }

  // Get Recommended Products
  Stream<QuerySnapshot<Map<String, dynamic>>> getRecommendedProducts() {
    return productCollectionRef.where('discount_percentage', isGreaterThan: 0).snapshots();
  }

  // Update product data
  Future<void> updateProduct(String id, Map<String, dynamic> data) async {
    try {
      await productCollectionRef.doc(id).update(data);
      print('Data updated successfully');
    } catch (e) {
      print('$e');
    }
  }

  // Delete product
  Future<void> deleteProduct(String id) async {
    try {
      await productCollectionRef.doc(id).delete();
      print('Data deleted successfully');
    } catch (e) {
      print('$e');
    }
  }

  // Increase view
  Future<void> increaseView(String id, Map<String, dynamic> data) async {
    try {
      await productCollectionRef.doc(id).update(data);
      print('Update view count successfully.');
    } catch (e) { print('$e'); }
  } 

  // Check if product is in User's Wishlist
  Future<bool> isFavoriteByUser(String productId, String userId) async {
    try {
      final querySnapshot = await productCollectionRef.where('product_id', isEqualTo: productId).where('user_id', isEqualTo: userId).get();
      return querySnapshot.docs.isNotEmpty;
    } catch (e) { 
      print(e); 
      return false;
    }
  }
  
  // Favorite products
  Future<void> addToFavorite(String productId, String userId) async {
    try {
      await favoriteProductRelationRef.add(
        {
          'productId' : productId,
          'userId' : userId
        }
      );
      print('Data added successfully');
    } catch (e) {
      print('$e');
    }
  }

  Future<void> deleteFromFavorite(String productId, String userId) async {
    try {
      final querySnapshot = await favoriteProductRelationRef.where('product_id', isEqualTo: productId,)
                                                            .where('user_id', isEqualTo: userId)
                                                            .get();
      DocumentSnapshot doc = querySnapshot.docs.first;
      await doc.reference.delete();
      print('Data deleted successfully');
    } catch (e) {
      print('$e');
    }
  }

  // Cart Items
  Future<void> addToCart(Map<String, dynamic> data) async {
    try {
      await productCollectionRef.add(data);
      print('Data added successfully');
    } catch (e) {
      print('$e');
    }
  }
}