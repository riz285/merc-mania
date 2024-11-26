import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merc_mania/screens/product/cubit/product_cubit.dart';
import '../../../core/configs/assets/app_format.dart';
import 'product_detail.dart';
import '../../../services/models/product.dart';

class ProductLongCard extends StatefulWidget {
  final Product product;
  const ProductLongCard({super.key, required this.product});

  @override
  State<ProductLongCard> createState() => _ProductLongCardState();
}

class _ProductLongCardState extends State<ProductLongCard> {
  @override
  Widget build(BuildContext context) {
  final product = widget.product;
    return InkWell(
                onTap: () {
                    context.read<ProductCubit>().addToRecentList(product.id);
                    context.read<ProductCubit>().increaseView(product);
                    Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProductDetail(product: product),
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
                                image: NetworkImage(product.image))
                      )),
                      SizedBox(width: 8),
                      Padding(padding: EdgeInsets.all(8),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          SizedOverflowBox(
                            alignment: Alignment.centerLeft,
                            size: Size(50, 50),
                            child: Text(product.name, maxLines: 2, overflow: TextOverflow.clip)),
                          Text(AppFormat.currency.format(product.price)),
                        ]),
                      )
                    ],),
                  )
              );
  }
}