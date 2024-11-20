import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merc_mania/screens/product_display/view/add_product/add_product_screen.dart';
import 'package:merc_mania/services/database/franchise_service.dart';
import 'package:merc_mania/services/database/product_service.dart';
import 'package:merc_mania/services/models/franchise.dart';

import '../../../core/configs/themes/app_colors.dart';
import 'franchise_view/franchise_list_view.dart';
import 'product_view/product_grid_view.dart';
import '../../product_display/cubit/product_cubit.dart';
import '../../../services/models/product.dart';
import 'product_view/product_list_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
      return Stack(
        children:[ ListView(
          children: [
            // Popular franchise
            _Classification(classification: 'Popular Franchise'),
            _FranchiseListView(),
            // Popular products
            _Classification(classification: 'Popular Items'),
            _PopularProductListView(),
            // Recently viewed items
            _Classification(classification: 'Recently Viewed'),
            _RecentlyViewedListView(),
            // Recommended products
            _Classification(classification: 'Recommended'),
            _RecommendedProductGridView(),
            ]
          ),
          // Floating button add to sell
            Positioned(
              bottom: 20,
              right: 20,
              child: _AddNewProduct())
          ]
        );
      }
    );
  }
}

class _Classification extends StatelessWidget {
  final String classification;
  const _Classification({required this.classification});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: SizedBox(
        child: Text(
          classification, 
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _FranchiseListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final franchiseService = FranchiseService();

    return SizedBox(
      height: 100,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream:  franchiseService.getFranchise(), 
          builder: (builder, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            if (snapshot.hasData) {
              final franchise = snapshot.data!.docs.map((doc) => Franchise.fromJson(doc.data())).toList();
              return FranchiseListView(franchise: franchise);
            }                                    
            return Text('No product data found');    
          }
        ),
      ),
    );
  }
}

class _PopularProductListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productService = ProductService();

    return SizedBox(
      height: 150,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future:  productService.getPopularProducts(), 
          builder: (builder, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            if (snapshot.hasData) {
              final products = snapshot.data!.docs.map((doc) => Product.fromJson(doc.data())).toList();
              return ProductListView(products: products);
            }                                    
            return Text('No product data found');    
          }
        ),
      ),
    );
  }
}

class _RecentlyViewedListView extends StatefulWidget {
  @override
  State<_RecentlyViewedListView> createState() => _RecentlyViewedListViewState();
}

class _RecentlyViewedListViewState extends State<_RecentlyViewedListView> {
  final productService = ProductService();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  // Fetch recent Product list
  Future<List<Product>> fetchData() async {
    List<String> ids = context.read<ProductCubit>().state.recentlyViewedProducts;
    return productService.getProductsFromList(ids);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductCubit, ProductState>(
      listener: (context, state) => setState(() {}),
      child: SizedBox(
          height: 150,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: FutureBuilder<List<Product>>(
              future: fetchData(), 
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
                if (snapshot.hasError) return Text('Error: ${snapshot.error}');
                if (snapshot.hasData) {
                  final products = snapshot.data!;
                  return ProductListView(products: products);
                }    
                return Text('No product data found');
              }),
          ),
        ),
    );
  }
}

class _RecommendedProductGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productService = ProductService();

    return SizedBox(
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream:  productService.getRecommendedProducts(), 
        builder: (builder, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          if (snapshot.hasData) {
            final products = snapshot.data!.docs.map((doc) => Product.fromJson(doc.data())).toList();
            return ProductGridView(products: products);
          }                                    
          return Text('No product data found');    
        }
      ),
    );
  }
}

class _AddNewProduct extends StatelessWidget {
  const _AddNewProduct();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => AddProductScreen())
                      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
      child: const Icon(Icons.add, color: AppColors.title,),
    );
  }
} 