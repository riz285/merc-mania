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

  Future<List<Product>>? getProduct() async {
    try {
      return ProductService().getProduct();
    } catch (e) {
      // ignore: avoid_print
      print('$e');
      return List.empty();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(future: getProduct(), builder: (builder, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) return CircularProgressIndicator();
      if (snapshot.hasError) return Text('Error: ${snapshot.error}');
      if (snapshot.hasData) {
        final products = snapshot.data!;
        return ProductList(products: products);
      }
      return Text('No user data found');
      
    });
    
    // Align(
    //     alignment: const Alignment(-1.0,-1.0),
    //     child: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: <Widget>[
    //         Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: Text('Popular',
    //           style: TextStyle(
    //             fontSize: 20,
    //             fontWeight: FontWeight.bold
    //           )),
    //         ),
    //         Divider(),
    //         Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: Text('Recently Searched',
    //           style: TextStyle(
    //             fontSize: 20,
    //             fontWeight: FontWeight.bold
    //           )),
    //         ),
    //         Divider(),
    //         Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: Text('Recommended',
    //           style: TextStyle(
    //             fontSize: 20,
    //             fontWeight: FontWeight.bold
    //           )),
    //         ),
    //       ],
    //     ),
    //   );
  }
}