import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merc_mania/screens/home/view/franchise_view/franchise_screen.dart';
import 'package:merc_mania/screens/home/view/product_view/product_screen.dart';
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
  Future<void> refresh() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(onRefresh: refresh,
      child: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
        return Stack(
          children:[ ListView(
            children: [
              // Popular franchise
              _FranchiseListView(),
              // Popular products
              _PopularProductListView(),
              // Recently viewed items
              _RecentlyViewedListView(),
              // Recommended products
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
      )
    );
  }
}

class _FranchiseListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final franchiseService = FranchiseService();

    return ListTile(contentPadding: EdgeInsets.zero,
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(children: [
          Text('Popular Franchise', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          Spacer(),
          TextButton(onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => FranchiseScreen()));
          }, child: Text('See All'))
        ])
      ),
      subtitle: SizedBox(
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
      ),
    );
  }
}

class _PopularProductListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productService = ProductService();

    return ListTile(contentPadding: EdgeInsets.zero,
      title: Padding(
        padding: EdgeInsets.only(left: 16, bottom: 8),
        child: Text('Popular Products', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)
      ),
      subtitle: SizedBox(
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
      )
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
      child: ListTile(contentPadding: EdgeInsets.zero,
      title: Padding(
        padding: EdgeInsets.only(left: 16, bottom: 8),
        child: Text('Recently Viewed', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)
      ),
      subtitle: SizedBox(
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
      )
    );
  }
}

class _RecommendedProductGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productService = ProductService();

    return ListTile(contentPadding: EdgeInsets.zero,
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(children: [
          Text('Recommended', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          Spacer(),
          TextButton(onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductScreen()));
          }, child: Text('See All'))
        ])
      ),
      subtitle: SizedBox(
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
        )
      )
    );
  }
}

class _AddNewProduct extends StatelessWidget {
  const _AddNewProduct();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () { 
        context.read<ProductCubit>().init();
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => AddProductScreen())
        );
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
      child: const Icon(Icons.add, color: AppColors.title,),
    );
  }
} 