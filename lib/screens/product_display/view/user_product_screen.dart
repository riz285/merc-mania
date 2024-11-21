import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/widgets/styled_app_bar.dart';
import '../../../core/configs/assets/app_format.dart';
import '../cubit/product_cubit.dart';
import '../../../services/database/product_service.dart';
import '../../../services/models/product.dart';
import 'product_detail.dart';

class UserProductScreen extends StatelessWidget {
  final String id;
  const UserProductScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final productService = ProductService();
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) =>
        Scaffold(
          appBar: StyledAppBar(
            title: Text('Shop\'s Products'),
          ),
          body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream:  productService.getUserProducts(id), 
            builder: (builder, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
              if (snapshot.hasError) return Text('Error: ${snapshot.error}');
              if (snapshot.hasData) {
                final products = snapshot.data!.docs.map((doc) => Product.fromJson(doc.data())).toList();
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
                    ));
                  }                        
              return Text('No product data found');    
            }
          ),
        )
    );
  }
}