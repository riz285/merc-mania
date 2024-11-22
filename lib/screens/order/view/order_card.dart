import 'package:flutter/material.dart';
import 'package:merc_mania/core/configs/assets/app_format.dart';
import 'package:merc_mania/services/database/product_service.dart';
import 'package:merc_mania/services/models/order.dart';

import '../../../services/models/product.dart';
import 'order_item_list_view.dart';

class OrderCard extends StatelessWidget {
  final AppOrder order;
  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.of(context).push(
        //     MaterialPageRoute(
        //       builder: (context) => OrderDetail(order: order),
        //     ),
        // );
      }, 
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Order: ${order.id}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text('Created at: ${AppFormat.vnDate.format(AppFormat.euDate.parse(order.createdAt))}')),
                  Divider(),
                    SizedBox(
                      height: 300,
                      child: _ItemListView(productIds: order.productIds)),
                  Divider(),
                  Row(
                    children: [
                      Text('Number of items: ${order.quantity}'),
                      Spacer(),
                      Column(children: [
                        Text('Total: ${AppFormat.currency.format(order.total)}'),
                        Text('Paid with: ${order.paymentMethod.toUpperCase()}')
                      ])
                    ],
                  ),
                ],
              ),
          ),
        ),
    );
  }
}

class _ItemListView extends StatelessWidget {
  final List<String> productIds;
  const _ItemListView({required this.productIds});

  @override
  Widget build(BuildContext context) {
    final productService = ProductService();
    return FutureBuilder<List<Product>>(
      future:  productService.getProductsFromList(productIds), 
      builder: (builder, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        if (snapshot.hasData) {
        final products = snapshot.data!;
          return OrderItemListView(products: products);
        }                               
        return Text('No product data found');    
      }
    );
  }
}