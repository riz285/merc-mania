import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/widgets/styled_app_bar.dart';
import '../../home/view/product_view/extended_product_grid_view.dart';
import '../cubit/product_cubit.dart';
import '../../../services/database/product_service.dart';
import '../../../services/models/franchise.dart';
import '../../../services/models/product.dart';

class ProductScreen extends StatelessWidget {
  final Franchise franchise;
  const ProductScreen({super.key, required this.franchise});

  @override
  Widget build(BuildContext context) {
    final productService = ProductService();
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) =>
        Scaffold(
          appBar: StyledAppBar(
            title: Text(franchise.name),
          ),
          body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream:  productService.getProductsFromFranchise(franchise.name), 
            builder: (builder, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
              if (snapshot.hasError) return Text('Error: ${snapshot.error}');
              if (snapshot.hasData) {
                final products = snapshot.data!.docs.map((doc) => Product.fromJson(doc.data())).toList();
                return products.isNotEmpty ? ProductGridView(products: products) : Align(child: Text('No product data found'));  
              }                                    
              return Text('No product data found');    
            }
          ),
        )
    );
  }
}