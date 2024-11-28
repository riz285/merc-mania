import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:merc_mania/services/database/product_service.dart';

import '../../core/configs/assets/app_format.dart';
import '../../services/models/product.dart';
import '../../screens/product_display/cubit/product_cubit.dart';
import '../../screens/product_display/view/product_detail.dart';

class ProductSearchDelegate extends SearchDelegate<String> {
  final productService = ProductService();
  final minController = TextEditingController();
  final maxController = TextEditingController();
  int? min;
  int? max;
  
  @override
  List<Widget>? buildActions(BuildContext context) {
    if (query.isNotEmpty) {
      return [IconButton(onPressed: () => query = '', icon: Icon(Icons.clear_outlined)),
      Padding(
        padding: const EdgeInsets.only(right: 20),
        child: PopupMenuButton(icon: Icon(FontAwesomeIcons.filterCircleDollar),
        itemBuilder: (context) => [
          PopupMenuItem(child: Text('Price Range (đ)')),
          PopupMenuItem(child: Row(children: [
            Expanded(
              child: TextField(textAlign: TextAlign.center, controller: minController,
                decoration: InputDecoration(border: OutlineInputBorder(),
                  hintText: 'MIN'
                ),
              ),
            ),
            const Text('   —   '),
            Expanded(
              child: TextField(textAlign: TextAlign.center, controller: maxController,
                decoration: InputDecoration(border: OutlineInputBorder(),
                  hintText: 'MAX',
                ),
              ),
            ),
            ])
          ),
          PopupMenuItem(child: Row(children: [
            Expanded(
              child: TextButton(onPressed: () {
                minController.text = '0'; maxController.text = AppFormat.thousand.format(100000);
              }, child: Text('0 - 100k'))
            ),
            Expanded(
              child: TextButton(onPressed: () {
                minController.text = AppFormat.thousand.format(100000); maxController.text = AppFormat.thousand.format(500000);
              }, child: Text('100k - 500k'))
            ),
            ])
          ),
          PopupMenuItem(child: Row(children: [
            Expanded(
              child: TextButton(onPressed: () {
                minController.text = AppFormat.thousand.format(500000); maxController.text = AppFormat.thousand.format(1000000);
              }, child: Text('500k - 1tr'))
            ),
            Expanded(
              child: TextButton(onPressed: () {
                minController.text = AppFormat.thousand.format(1000000); maxController.text = '';
              }, child: Text('> 1tr'))
            ),
            ])
          ),
          PopupMenuItem(child: Row(children: [
            Expanded(
              child: TextButton(onPressed: () {
                minController.text = ''; maxController.text = '';
                min=null; max=null;
              }, child: Text('Reset'))
            ),
            Expanded(
              child: ElevatedButton(onPressed: () {
                if (minController.text.isNotEmpty) min = AppFormat.thousand.parse(minController.text).toInt();
                if (maxController.text.isNotEmpty) max = AppFormat.thousand.parse(maxController.text).toInt();
                Navigator.pop(context);
              }, child: Text('Apply'))
            ),
            ])
          ),
        ]
            ),
      )];
    }
    return [Padding(
      padding: const EdgeInsets.only(right: 20),
      child: PopupMenuButton(icon: Icon(FontAwesomeIcons.filterCircleDollar),
        itemBuilder: (context) => [
          PopupMenuItem(child: Text('Price Range (đ)')),
          PopupMenuItem(child: Row(children: [
            Expanded(
              child: TextField(textAlign: TextAlign.center, controller: minController,
                decoration: InputDecoration(border: OutlineInputBorder(),
                  hintText: 'MIN'
                ),
              ),
            ),
            const Text('   —   '),
            Expanded(
              child: TextField(textAlign: TextAlign.center, controller: maxController,
                decoration: InputDecoration(border: OutlineInputBorder(),
                  hintText: 'MAX',
                ),
              ),
            ),
            ])
          ),
          PopupMenuItem(child: Row(children: [
            Expanded(
              child: TextButton(onPressed: () {
                minController.text = '0'; maxController.text = AppFormat.thousand.format(100000);
              }, child: Text('0 - 100k'))
            ),
            Expanded(
              child: TextButton(onPressed: () {
                minController.text = AppFormat.thousand.format(100000); maxController.text = AppFormat.thousand.format(500000);
              }, child: Text('100k - 500k'))
            ),
            ])
          ),
          PopupMenuItem(child: Row(children: [
            Expanded(
              child: TextButton(onPressed: () {
                minController.text = AppFormat.thousand.format(500000); maxController.text = AppFormat.thousand.format(1000000);
              }, child: Text('500k - 1tr'))
            ),
            Expanded(
              child: TextButton(onPressed: () {
                minController.text = AppFormat.thousand.format(1000000); maxController.text = '';
              }, child: Text('> 1tr'))
            ),
            ])
          ),
          PopupMenuItem(child: Row(children: [
            Expanded(
              child: TextButton(onPressed: () {
                minController.text = ''; maxController.text = '';
                min=null; max=null;
              }, child: Text('Reset'))
            ),
            Expanded(
              child: ElevatedButton(onPressed: () {
                if (minController.text.isNotEmpty) min = AppFormat.thousand.parse(minController.text).toInt();
                if (maxController.text.isNotEmpty) max = AppFormat.thousand.parse(maxController.text).toInt();
                Navigator.pop(context);
              }, child: Text('Apply'))
            ),
            ])
          ),
        ]
      ),
    )];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: () => close(context, ''), icon: Icon(Icons.navigate_before));
  }

  @override
  Widget buildResults(BuildContext context) {
    StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: productService.getProducts(), 
          builder: (builder, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            if (snapshot.hasData) {
              final products = snapshot.data!.docs.map((doc) => result(doc.data(), query, min, max)).toList();
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
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: productService.getProducts(), 
          builder: (builder, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            if (snapshot.hasData) {
              final products = snapshot.data!.docs.map((doc) => result(doc.data(), query, min, max)).toList();
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

Product result (Map<String, dynamic> data, String query, int? min, int? max) {
  final name = normalizeText(data['name'].toLowerCase()).split(' ').toSet(); // Product name
  final franchise = normalizeText(data['franchise'].toLowerCase()).split(' ').toSet();
  final price = data['price'];
  final querySplit = query.toLowerCase().split(' '); // Search Query
  final querySet = querySplit.toSet(); 
  if (min!=null) {
    if (max!=null) {
      if (price>=min && price <=max) {
        if (name.containsAll(querySet)) {
          return Product.fromJson(data);
        }
        if (franchise.containsAll(querySet)) {
          return Product.fromJson(data);
        }
      }
    } else if (price >= min) {
      if (name.containsAll(querySet)) {
        return Product.fromJson(data);
      }
      if (franchise.containsAll(querySet)) {
        return Product.fromJson(data);
      }
    }
  } else {
    if (name.containsAll(querySet)) {
      return Product.fromJson(data);
    }
    if (franchise.containsAll(querySet)) {
      return Product.fromJson(data);
    }
  }
  return Product.empty;
}

String normalizeText(String text) {
    // Replace common special characters
    text = text.replaceAll('ä', 'a')
              .replaceAll('ö', 'o')
              .replaceAll('ü', 'u')
              .replaceAll('ß', 'ss')
              .replaceAll('é', 'e')
              .replaceAll('è', 'e')
              .replaceAll('à', 'a')
              .replaceAll('â', 'a')
              .replaceAll('ç', 'c')
              .replaceAll('î', 'i')
              .replaceAll('ô', 'o')
              .replaceAll('û', 'u')
              .replaceAll('ñ', 'n')
              .replaceAll('Á', 'A')
              .replaceAll('É', 'E')
              .replaceAll('Í', 'I')
              .replaceAll('Ó', 'O')
              .replaceAll('Ú', 'U')
              .replaceAll('Ñ', 'N');

    // Use a more general approach with regular expressions for other characters
    text = text.replaceAll(RegExp(r'[^\w\s]'), ''); // Remove non-word and non-whitespace characters

    return text;
  }