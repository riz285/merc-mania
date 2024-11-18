import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merc_mania/common/widgets/styled_app_bar.dart';
import 'package:merc_mania/core/configs/assets/app_format.dart';
import 'package:merc_mania/screens/cart/cubit/cart_cubit.dart';
import 'package:merc_mania/services/models/product.dart';

import '../../address/view/address_selection/choose_address_page.dart';
import '../cubit/product_cubit.dart';

// import '../cubit/product_item_cubit.dart';

class ProductDetail extends StatefulWidget {
  final Product product;
  const ProductDetail({super.key, required this.product});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {

  double discountedPrice(int price, int discountPercentage) {
    return (price*(100-discountPercentage)/100);
  }

  @override
  Widget build(BuildContext context) {
    final cart = BlocProvider.of<CartCubit>(context);
    return Scaffold(
                appBar: StyledAppBar(
                  title: Text('Product Details'),
                ),
                body: ListView(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  children: [
                    // Product image
                    Container(
                      alignment: Alignment.topCenter,
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: NetworkImage(widget.product.image))
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.product.name, 
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                            )
                          ),
                          SizedBox(
                            child: Text('Brand: ${widget.product.brandName ?? 'unknown'}')
                          ),
                          widget.product.discountPercentage == null ?
                          SizedBox(
                            child: Text('Price: ${AppFormat.currency.format(widget.product.price)}')
                          ) 
                          : Row(children: [
                            SizedBox(
                              child: Text('Price: ')
                            ),
                            SizedBox(
                              child: Text(AppFormat.currency.format(widget.product.price), style: TextStyle(decoration: TextDecoration.lineThrough))
                            ),
                            SizedBox(width: 4),
                            SizedBox(
                              child: Text(AppFormat.currency.format(discountedPrice(widget.product.price, widget.product.discountPercentage??1)), style: TextStyle(color: Colors.red),)
                            ),
                          ]),
                          SizedBox(width: 10),
                          //
                          Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Add to favorite
                                  Container(
                                    height: 40,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        context.read<ProductCubit>().toggleFavorite(widget.product.id);
                                        setState(() {
                                          
                                        });
                                      }, 
                                      icon: 
                                            ! context.read<ProductCubit>().isFavorite(widget.product.id)
                                            ? Icon(Icons.favorite_border_outlined)
                                            : Icon(Icons.favorite, color: Colors.red,)
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  // Add to cart 
                                  Container(
                                    height: 40,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        cart.addToCart(widget.product);
                                        ScaffoldMessenger.of(context)
                                          ..hideCurrentSnackBar()
                                          ..showSnackBar(
                                            SnackBar(
                                              content: Text('Product added to cart'),
                                              duration: Duration(seconds: 1),
                                            ),
                                          );
                                      }, 
                                      icon: Icon(Icons.shopping_cart_checkout_outlined)),
                                  ),
                                  SizedBox(width: 10),
                                  // Report product
                                  Container(
                                    height: 40,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                    ),
                                    child: IconButton(
                                      onPressed: () {}, 
                                      icon: Icon(Icons.report)),
                                  ),
                                ],
                              ),
                          
                          //
                          Text(
                              'Description',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                              )
                            ),
                          Text(
                            widget.product.description  ?? '[There is no product description.]', 
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(height: 20),
                          Center(child: _PurchaseButton(onPressed: () {
                            cart.addToPurchase(widget.product);
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChooseAddressPage()));
                          })),
                        ],
                      ),
                    )
                  ],
                ),
    );
  }
}

class _PurchaseButton extends StatelessWidget {
  final Function() onPressed;
  const _PurchaseButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: const Key('productDetail_purchase_raisedButton'),
      onPressed: onPressed,
      child: Text('PURCHASE'),
    );
  }
}