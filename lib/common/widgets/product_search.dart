import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merc_mania/services/database/product_service.dart';

import '../../core/configs/assets/app_format.dart';
import '../../services/models/product.dart';
import '../../screens/product_display/cubit/product_cubit.dart';
import '../../screens/product_display/view/product_detail.dart';

class ProductSearchDelegate extends SearchDelegate<String> {
  final productService = ProductService();
  
  @override
  List<Widget>? buildActions(BuildContext context) {
    if (query.isNotEmpty) {
      return [IconButton(onPressed: () => query = '', icon: Icon(Icons.clear_outlined))];
    }
    return null;
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: () => close(context, ''), icon: Icon(Icons.navigate_before));
  }

  @override
  Widget buildResults(BuildContext context) {
    final searchedWord = query.toLowerCase().split(' ');
    StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: productService.getProducts(), 
          builder: (builder, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            if (snapshot.hasData) {
              final products = snapshot.data!.docs.map((doc) => result(doc.data(), searchedWord)).toList();
            return ListView.separated(
              itemCount: products.length,
              itemBuilder: (context, index) => products[index]==Product.empty ? Container() : InkWell(
                onTap: () {
                    context.read<ProductCubit>().addToRecentList(products[index].id);
                    context.read<ProductCubit>().increaseView(products[index]);
                    Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProductDetail(product: products[index]),
                        ),
                    );
                  },
                  child: SizedBox(
                    height: 100,
                    child: Row(children: [
                      SizedBox(width: 10),
                      Container(
                        width: 90,
                        decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                                fit: BoxFit.contain,
                                image: NetworkImage(products[index].image))
                      )),
                      SizedBox(width: 8),
                      Padding(padding: EdgeInsets.all(8),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          SizedOverflowBox(
                            alignment: Alignment.centerLeft,
                            size: Size(50, 50),
                            child: Text(products[index].name, maxLines: 2, overflow: TextOverflow.clip)),
                          Text(AppFormat.currency.format(products[index].price)),
                        ]),
                      )
                    ],),
                  )
              ),
              separatorBuilder: (context, index) => SizedBox(width: 10),
              );
            }                                    
            return Text('No product data found');    
          }
        );
        return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final searchedWord = query.toLowerCase().split(' ');
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: productService.getProducts(), 
          builder: (builder, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            if (snapshot.hasData) {
              final products = snapshot.data!.docs.map((doc) => result(doc.data(), searchedWord)).toList();
            return query.isEmpty ? Container() : ListView.separated(
              itemCount: products.length,
              itemBuilder: (context, index) => products[index]==Product.empty ? Container() : InkWell(
                onTap: () {
                    context.read<ProductCubit>().addToRecentList(products[index].id);
                    context.read<ProductCubit>().increaseView(products[index]);
                    Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProductDetail(product: products[index]),
                        ),
                    );
                  },
                  child: SizedBox(
                    height: 100,
                    child: Row(children: [
                      SizedBox(width: 10),
                      Container(
                        width: 50,
                        decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                                fit: BoxFit.contain,
                                image: NetworkImage(products[index].image))
                      )),
                      SizedBox(width: 8),
                      Padding(padding: EdgeInsets.all(8),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          SizedOverflowBox(
                            alignment: Alignment.centerLeft,
                            size: Size(50, 50),
                            child: Text(products[index].name, maxLines: 2, overflow: TextOverflow.clip)),
                          Text(AppFormat.currency.format(products[index].price)),
                        ]),
                      )
                    ],),
                  )
              ),
              separatorBuilder: (context, index) => SizedBox(width: 10),
              );
            }                                                    
            return Text('No product data found');    
          }
        );
  }
  
  @override
  String get searchFieldLabel => 'Search for any product?';
  

}

Product result (Map<String, dynamic> data, List<String> query) {
  final name = data['name'].toLowerCase().split(' ').toSet(); // Product name
  final querySet = query.toSet(); // Search Query
    if (name.containsAll(querySet)) {
      return Product.fromJson(data);
    }
  return Product.empty;
}

