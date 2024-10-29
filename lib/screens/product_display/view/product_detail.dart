import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merc_mania/core/configs/assets/app_format.dart';
import 'package:merc_mania/home/view/home_page.dart';
import 'package:merc_mania/screens/cart/cubit/cart_cubit.dart';
import 'package:merc_mania/services/models/product.dart';

// import '../../../app/bloc/app_bloc.dart';
// import '../cubit/product_cubit.dart';

class ProductDetail extends StatelessWidget {
  final Product product;
  const ProductDetail({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // final user = context.select((AppBloc bloc) => bloc.state.user);
    final cart = BlocProvider.of<CartCubit>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(product.name),
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
                  image: NetworkImage(product.image))
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name, 
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    )
                  ),
                  SizedBox(
                    child: Text(AppFormat.currency.format(product.price))
                  ),
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
                                // context.read<ProductCubit>().toggleFavorite(product.id, user.id);
                              }, 
                              icon: Icon(Icons.favorite_border_outlined),
                              selectedIcon: Icon(Icons.favorite, color: Colors.red,)),
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
                                cart.addToCart(product);
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
                  SizedBox(height: 20),
                  Text(
                      'Description',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      )
                    ),
                  Text(
                    product.description  ?? '[There is no product description.]', 
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 20),
                  Center(child: _PurchaseButton()),
                ],
              ),
            )
          ],
        ),
    );
  }
}

class _PurchaseButton extends StatelessWidget {
  const _PurchaseButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: const Key('productDetail_purchase_raisedButton'),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: Colors.red,
      ),
      onPressed: () {
        
      }, 
      child: Text('PURCHASE', style: TextStyle( color: Colors.white )),
    );
  }
}