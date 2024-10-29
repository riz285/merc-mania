import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/widgets/list_views/extended_product_grid_view.dart';
import '../../../home/cubit/recently_viewed_cubit.dart';
import '../../../services/database/product_service.dart';
import '../../../services/models/franchise.dart';
import '../../../services/models/product.dart';

class ProductScreen extends StatelessWidget {
  final Franchise franchise;
  const ProductScreen({super.key, required this.franchise});

  @override
  Widget build(BuildContext context) {
    final productService = ProductService();
    final String franchiseId = franchise.id;
    return BlocBuilder<RecentlyViewedCubit, RecentlyViewedState>(
      builder: (context, state) =>
        Scaffold(
          appBar: AppBar(
            title: Text(franchise.name),
          ),
          body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          stream:  productService.getProductsFromFranchise(franchiseId), 
                          builder: (builder, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
                            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
                            if (snapshot.hasData) {
                              final products = snapshot.data!.docs.map((doc) => Product.fromFirestore(doc)).toList();
                              return ProductGridView(products: products);
                            }                                    
                            return Text('No product data found');    
                          }
                        ),
        )
    );
  }
}