import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merc_mania/common/widgets/styled_discount_banner.dart';
import 'package:merc_mania/screens/product_display/cubit/product_cubit.dart';
import '../../../core/configs/assets/app_format.dart';
import 'product_detail.dart';
import '../../../services/models/product.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<ProductCubit>().addToRecentList(widget.product.id);
        context.read<ProductCubit>().increaseView(widget.product);
        Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ProductDetail(product: widget.product),
            ),
        );
      },
      child: Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.grey[700],
          image: DecorationImage(
                  fit: BoxFit.contain,
                  image: NetworkImage(widget.product.image))
        ),
        child: Stack(
          children: [
            // Discount percentage
            Visibility(
              visible: (widget.product.discountPercentage != null) ,
              child: StyledDiscountBanner(discountPercentage: widget.product.discountPercentage??0)
            ),
            // Favorite IconButton
            // Positioned(
            //   top: 0.0,
            //   right: 0.0,
            //   child: IconButton(
            //     onPressed: () {       
            //       context.read<ProductCubit>().toggleFavorite(widget.product.id);
            //       setState(() {});         
            //     }, 
            //     icon: ! context.read<ProductCubit>().isFavorite(widget.product.id)
            //           ? Icon(Icons.favorite_border_outlined)
            //           : Icon(Icons.favorite, color: Colors.red,)
            //   )
            // ),
            // Product price
            Positioned(
              bottom: 0.0,
              child: Container(
                height: 25,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(54, 54, 54, 95),
                    borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20), bottomLeft: Radius.circular(10)),
                    ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(AppFormat.currency.format(widget.product.price),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      ),
                    ),
                  ]
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}