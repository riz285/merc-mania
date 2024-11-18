import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merc_mania/common/widgets/styled_app_bar.dart';
import 'package:merc_mania/screens/product_display/cubit/product_cubit.dart';

import '../../core/configs/assets/app_format.dart';
import '../../services/database/product_service.dart';
import '../../services/models/product.dart';
import '../product_display/view/product_detail.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final productService = ProductService();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  // Fetch recent Product list
  Future<List<Product>> fetchData() async {
    List<String> ids = context.read<ProductCubit>().state.favoriteProducts;
    return productService.getProductsFromList(ids);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyledAppBar(
        title: Text('My Wishlist'),
      ),
      body: Padding(padding: EdgeInsets.all(8),
        child: BlocListener<ProductCubit, ProductState>(
      listener: (context, state) => setState(() {}),
      child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: FutureBuilder<List<Product>>(
              future: fetchData(), 
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
                if (snapshot.hasError) return Text('Error: ${snapshot.error}');
                if (snapshot.hasData) {
                  final products = snapshot.data!;
                  return Expanded(
                    child: ListView.separated(
                      itemCount: products.length,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ProductDetail(product: products[index]),
                              ),
                          );
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  // Product Image
                                  leading: Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      color: Colors.grey[700],
                                      image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(products[index].image))
                                    ),
                                  ),
                                  title: Text(products[index].name),
                                  subtitle: Text(AppFormat.currency.format(products[index].price)),
                                ),
                              ],
                            ),
                          ),
                        )
                      ), 
                      separatorBuilder: (context, index) => SizedBox(width: 5),
                    ),
                  );
                }    
                return Text('No product data found');
              }),
          ),
        ),
    ));
  }
}