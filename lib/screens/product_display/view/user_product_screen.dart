import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/bloc/app_bloc.dart';
import '../../../common/widgets/styled_app_bar.dart';
import '../../../core/configs/assets/app_format.dart';
import '../cubit/product_cubit.dart';
import '../../../services/database/product_service.dart';
import '../../../services/models/product.dart';
import 'product_detail.dart';

class UserProductScreen extends StatefulWidget {
  final String id;
  const UserProductScreen({super.key, required this.id});

  @override
  State<UserProductScreen> createState() => _UserProductScreenState();
}

class _UserProductScreenState extends State<UserProductScreen> {
  final productService = ProductService();
  
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  // Fetch recent Product list
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchData() {
    return productService.getUserProducts(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final userId = context.select((AppBloc bloc) => bloc.state.user.id);

    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) => Scaffold(
        appBar: StyledAppBar(
          title: userId==widget.id ? Text('My Products') : Text('Shop\'s Products'),
        ),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream:  fetchData(), 
          builder: (builder, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            if (snapshot.hasData) {
              final products = snapshot.data!.docs.map((doc) => Product.fromJson(doc.data())).toList();
              return ListView.separated(
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
                      child: Column(mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile( // Product Image
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
              );
            }                        
            return Text('No product data found');    
          }
        ),
      )
    );
  }
}