import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merc_mania/common/widgets/styled_app_bar.dart';
import 'package:merc_mania/core/configs/assets/app_format.dart';
import 'package:merc_mania/screens/cart/cubit/cart_cubit.dart';
import 'package:merc_mania/screens/notifications/cubit/notifications_cubit.dart';
import 'package:merc_mania/screens/product_display/view/edit_product/edit_product_screen.dart';
import 'package:merc_mania/screens/product_display/view/user_product_screen.dart';
import 'package:merc_mania/services/models/product.dart';

import '../../../app/bloc/app_bloc.dart';
import '../../../common/widgets/styled_sold_banner.dart';
import '../../../core/configs/assets/avatar.dart';
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
    return (price * (100 - discountPercentage) / 100);
  }

  @override
  initState() {
    super.initState();
    fetchProductData();
    fetchUserData();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>?> fetchUserData() async {
    try {
      return await context.read<ProductCubit>().fetchUserData(widget.product.userId);
    } catch (e) {
      return null;
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>?> fetchProductData() async {
    try {
      return await context.read<ProductCubit>().fetchProductData(widget.product.id);
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = BlocProvider.of<CartCubit>(context);
    final userId = context.select((AppBloc bloc) => bloc.state.user.id);

    return Scaffold(
      appBar: StyledAppBar(
        title: Text('Product Details'),
        actions: [ 
          userId==widget.product.userId 
          ? IconButton(onPressed: () { context.read<ProductCubit>().init();
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditProductScreen(product: widget.product)));
          }, icon: Icon(Icons.edit_note)) 
          : Container() ],
      ),
      body: BlocListener<ProductCubit, ProductState>(
        listener: (context, state) => setState(() {}),
        child: FutureBuilder(
          future: fetchProductData(), 
          builder: (context, snapshot) {
            // if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            if (snapshot.hasData) {
              final product = Product.fromJson(snapshot.data!.data()!);
              return ListView(
                padding: EdgeInsets.symmetric(vertical: 30),
                children: [
                  // Product image
                  Container(padding: EdgeInsets.only(left: 85),
                    alignment: Alignment.topLeft,
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: NetworkImage(product.image))
                    ),
                    child: Stack(children: [
                      // Sold Out banner
                      widget.product.isSold==true ? StyledSoldOutBanner(isSold: widget.product.isSold)
                      : Container()]
                    )
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
                        Text('Brand: ${product.brandName ?? 'unknown'}'),
                        product.discountPercentage == null 
                        ? Text('Price: ${AppFormat.currency.format(product.price)}') 
                        : Row(children: [
                          Text('Price: '),
                          Text(AppFormat.currency.format(product.price), style: TextStyle(decoration: TextDecoration.lineThrough)),
                          SizedBox(width: 4),
                          Text(AppFormat.currency.format(discountedPrice(product.price, product.discountPercentage??1)), style: TextStyle(color: Colors.red))
                        ]),
                        Text('Last updated: ${AppFormat.vnDate.format(AppFormat.euDate.parse(product.timestamp))}'),
                        // Tools
                        Padding(padding: EdgeInsets.all(10),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    context.read<ProductCubit>().toggleFavorite(product.id);
                                    setState(() {});
                                  }, 
                                  icon: ! context.read<ProductCubit>().isFavorite(product.id)
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
                                  onPressed:  widget.product.isSold!=true ? () {
                                    cart.addToCart(product);
                                    ScaffoldMessenger.of(context)
                                      ..hideCurrentSnackBar()
                                      ..showSnackBar(
                                        SnackBar(
                                          content: Text('Product added to cart'),
                                          duration: Duration(seconds: 1),
                                        ),
                                      );
                                  } : null, 
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
                                onPressed: () {
                                  showDialog(context: context, builder: (context) => _ReportDialog(product: product));
                                }, 
                                icon: Icon(Icons.report)),
                              ),
                            ],
                          ),
                        ),
                        FutureBuilder(
                          future: fetchUserData(), 
                          builder: (context, snapshot) {
                            // if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
                            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
                            if (snapshot.hasData) {
                              final user = User.fromJson(snapshot.data!.data()!);
                              return ListTile(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                                title: Row(children: [
                                  Avatar(photo: user.photo),
                                  SizedBox(width: 8),
                                  Text('${user.firstName ?? ''} ${user.lastName ?? ''}'),
                                ]),
                                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserProductScreen(id: user.id))),
                              );
                            }
                            return Container();
                          }
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Description',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                          )
                        ),
                        Text(
                          (product.description==null||product.description=='')  ? '[There is no product description.]' : product.description!, 
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 20),
                        Center(child: 
                        _PurchaseButton(
                          onPressed: widget.product.isSold!=true 
                          ? () { cart.addToPurchase(product);
                                 Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChooseAddressPage()));
                               } 
                          : null,
                    )
                  ),
                ],
              ),
            )
          ],
        );
        }
        return Container();
      }),
    ));
  }
}

class _ReportDialog extends StatefulWidget {
  final Product product;
  const _ReportDialog({required this.product});

  @override
  State<_ReportDialog> createState() => _ReportDialogState();
}

class _ReportDialogState extends State<_ReportDialog> {
  List<String> reasons = ['Scam/Fraud', 'Stolen image/product', 'Fake/Unofficial', 'Others'];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(padding: EdgeInsets.all(20),
        child: Column(mainAxisSize: MainAxisSize.min,
        children: [
          Text('Which is the reason for your report?', style: TextStyle(fontSize: 16)),
          SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            itemCount: reasons.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(reasons[index]),
              focusColor: Colors.purple,
              selected: index == selectedIndex,
              onTap: () => setState(() {
                selectedIndex = index;
              })
            )),
          TextButton(
            onPressed: () { 
              context.read<NotificationCubit>().alertAboutReport(reasons[selectedIndex], widget.product);
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text('Reported a product.'),
                  ),
                );
              Navigator.pop(context); 
            }, 
            child: Text('Report'))
        ]),
      ),
    );
  }
}

class _PurchaseButton extends StatelessWidget {
  final Function()? onPressed;
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