import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merc_mania/home/cubit/recently_viewed_cubit.dart';
// import 'package:merc_mania/screens/product_display/cubit/product_cubit.dart';

// import '../../app/bloc/app_bloc.dart';
import '../../../core/configs/assets/app_format.dart';
import '../../../screens/product_display/view/product_detail.dart';
import '../../../services/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // final user = context.select((AppBloc bloc) => bloc.state.user);
    return InkWell(
            onTap: () {
              context.read<RecentlyViewedCubit>().addToRecentlyViewed(product.id);
              // context.read<ProductCubit>().init(product.id ,user.id);
              Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProductDetail(product: product),
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
                        image: NetworkImage(product.image))
              ),
              child: Stack(
                children: [
                  // Discount percentage
                  Visibility(
                    visible: (product.discountPercentage != null) ,
                    child: Positioned(
                      top: 0.0,
                      child: Container(
                        height: 30,
                        width: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
                          color: Colors.red,  
                        ),
                        child: Text(
                          '${product.discountPercentage}%', 
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        ),
                      ),
                    )
                  ),
                  // Favorite IconButton
                  Positioned(
                    top: 0.0,
                    right: 0.0,
                    child: IconButton(
                      onPressed: () {
                        // context.read<ProductCubit>().toggleFavorite(product.id, user.id);
                      }, 
                      icon: Icon(Icons.favorite_border_outlined)
                            // !context.read<RecentlyViewedCubit>().isFavorite 
                            // ? Icon(Icons.favorite_border_outlined)
                            // : Icon(Icons.favorite_rounded, 
                            //       color: Colors.redAccent)
                    )
                  ),
                  // Product price
                  Positioned(
                    bottom: 0.0,
                    child: Container(
                      height: 25,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(54, 54, 54, 95),
                          borderRadius: BorderRadius.only(topRight: Radius.circular(15), bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15)),
                          ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(AppFormat.currency.format(product.price),
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