import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';
import 'package:merc_mania/app/view/app.dart';
import 'package:merc_mania/screens/product_display/view/product_detail.dart';
import 'package:merc_mania/services/models/product.dart';

import '../../../../common/widgets/styled_app_bar.dart';
import '../../../../core/configs/themes/app_colors.dart';
import '../../cubit/product_cubit.dart';

class EditProductScreen extends StatefulWidget {
  final Product product;
  const EditProductScreen({super.key, required this.product});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  @override
  void initState() {
    super.initState();
    fetchProductData();
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
    return Scaffold(
      appBar: StyledAppBar(
        title: Text('Edit Product Details'),
        leading: Container(),
        actions: [ IconButton(onPressed: () {
          showDialog(context: context, builder: (context) => AlertDialog(
            title: Text('Do you want this item to be deleted? This action can\'t be undone.', style: TextStyle(fontSize: 16), textAlign: TextAlign.center),
            content: ElevatedButton(onPressed: () {
              context.read<ProductCubit>().deleteProduct(widget.product.id);
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AppView()));
            }, child: Text('Confirm')),
          ));
        }, icon: Icon(FontAwesomeIcons.trash), iconSize: 15) ],
        ),
      body: BlocListener<ProductCubit, ProductState>(
        listener: (context, state) { 
          if (state.status.isSuccess) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ProductDetail(product: widget.product)));
          } else if (state.status.isFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text('Edit Product Failure'),
                ),
              );
          }
        },
        child: FutureBuilder(
          future: fetchProductData(), 
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            if (snapshot.hasData) {
              final product = Product.fromJson(snapshot.data!.data()!);
              return ListView(padding: EdgeInsets.all(30),
                children: [
                Padding(padding: EdgeInsets.all(8),
                  child: GestureDetector(
                    child: Stack(alignment: Alignment.center,
                      children: [
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey[700],
                            image: DecorationImage(image: NetworkImage(context.read<ProductCubit>().state.image ?? product.image))
                          ),
                        ),
                        Positioned(
                          child: Icon(FontAwesomeIcons.image, color: AppColors.lightCardBackground,)
                        )
                      ]
                    ),
                    onTap: () { 
                      context.read<ProductCubit>().productImageChanged(); 
                      setState(() {});
                    },
                  ),
                ),
                // Product Name
                _NameInput(name: product.name),
                // Brand Name
                _BrandNameInput(brand: product.brandName),
                // Franchise
                _FranchiseInput(franchise: product.franchise),
                // Price
                _PriceInput(price: product.price),
                // Quantity
                _QuantityInput(quantity: product.quantity),
                // Description
                _DescriptionInput(description: product.description),
                SizedBox(height: 16),
                // Add New Product Button
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _CancelButton(onPressed: () => Navigator.pop(context)),
                    SizedBox(width: 60),
                    _UpdateProductButton(id: product.id, product: product),
                  ],
                )]
              );
            }
          return Container();
        }
      )
    ));
  }
}

class _NameInput extends StatelessWidget {
  final String? name;
  const _NameInput({required this.name});

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('addNewProductForm_productNameInput_textField'),
      onChanged: (text) => context.read<ProductCubit>().productNameChanged(text),
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: name,
        labelText: 'product name', 
      ),
    );
  }
}

class _BrandNameInput extends StatelessWidget {
  final String? brand;
  const _BrandNameInput({required this.brand});

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('addNewProductForm_brandNameInput_textField'),
      onChanged: (text) => context.read<ProductCubit>().brandNameChanged(text),
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: 'brand name', 
        hintText: brand??'Bandai, Disney, Good Smile Company...',
      ),
    );
  }
}

class _FranchiseInput extends StatelessWidget {
  final String? franchise;
  const _FranchiseInput({required this.franchise});

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('addNewProductForm_franchiseNameInput_textField'),
      onChanged: (text) => context.read<ProductCubit>().franchiseChanged(text),
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: 'franchise', 
        hintText: franchise??'Naruto, Bleach, Hello Kitty...',
      ),
    );
  }
}

class _PriceInput extends StatelessWidget {
  final int? price;
  const _PriceInput({required this.price});

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('addNewProductForm_priceInput_textField'),
      onChanged: (number) => context.read<ProductCubit>().priceChanged(number),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: 'price', 
        hintText: '${price??'1,000'}',
        suffixText: 'VND'
      ),
    );
  }
}

class _QuantityInput extends StatelessWidget {
  final int? quantity;
  const _QuantityInput({required this.quantity});

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('addNewProductForm_quantityInput_textField'),
      onChanged: (number) => context.read<ProductCubit>().quantityChanged(number),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: 'quantity', 
        hintText: '${quantity??1}',
      ),
    );
  }
}

class _DescriptionInput extends StatelessWidget {
  final String? description;
  const _DescriptionInput({required this.description});

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('addNewProductForm_descriptionInput_textField'),
      onChanged: (text) => context.read<ProductCubit>().descriptionChanged(text),
      keyboardType: TextInputType.multiline,
      maxLines: 3,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: 'product descrption', 
        hintText: description
      ),
    );
  }
}

class _UpdateProductButton extends StatelessWidget {
  final String id;
  final Product product;
  const _UpdateProductButton({required this.id, required this.product});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: const Key('updateProductForm_confirm_raisedButton'),
      onPressed: () { 
        context.read<ProductCubit>().updateProductFormSubmitted(id, product);
        Navigator.of(context).pop(); 
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ProductDetail(product: product))); 
      },
      child: const Text('UPDATE', style: TextStyle(color: AppColors.title)),
    );
  }
}

class _CancelButton extends StatelessWidget {
  final Function() onPressed;
  const _CancelButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed, 
      child: Text('CANCEL')
    );
  }
}