import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';
import 'package:merc_mania/common/widgets/styled_app_bar.dart';
import 'package:merc_mania/screens/product_display/view/add_product/add_product_success_noti_screen.dart';

import '../../../../core/configs/assets/app_images.dart';
import '../../../../core/configs/themes/app_colors.dart';
import '../../cubit/product_cubit.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyledAppBar(
        title: Text('Add new product'),
        ),
        body: BlocListener<ProductCubit, ProductState>(
        listener: (context, state) {
          if (state.status.isSuccess) {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddProductSuccessScreen()));
          } else if (state.status.isFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text('Add Product Failure'),
                ),
              );
          }
        },
        child: ListView(padding: EdgeInsets.all(30),
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
                      image: DecorationImage(image: NetworkImage(context.read<ProductCubit>().state.image ?? AppImages.noImage))
                    ),
                  ),
                  Positioned(
                    child: Icon(FontAwesomeIcons.image, color: AppColors.lightCardBackground,))
                ]
              ),
              onTap: () { 
                context.read<ProductCubit>().productImageChanged(); 
                setState(() {});
              },
            ),
          ),
          // Product Name
          _NameInput(),
          // Brand Name
          _BrandNameInput(),
          // Franchise
          _FranchiseInput(),
          // Price
          _PriceInput(),
          // Quantity
          _QuantityInput(),
          // Description
          _DescriptionInput(),
          SizedBox(height: 16),
          // Add New Product Button
          Center(
            child: _AddProductButton()
          )
        ]),
      )
    );
  }
}

class _NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('addNewProductForm_productNameInput_textField'),
      onChanged: (text) => context.read<ProductCubit>().productNameChanged(text),
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: 'product name', 
      ),
    );
  }
}

class _BrandNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('addNewProductForm_brandNameInput_textField'),
      onChanged: (text) => context.read<ProductCubit>().brandNameChanged(text),
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: 'brand name', 
        hintText: 'Bandai, Disney, Good Smile Company...',
      ),
    );
  }
}

class _FranchiseInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('addNewProductForm_franchiseNameInput_textField'),
      onChanged: (text) => context.read<ProductCubit>().franchiseChanged(text),
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: 'franchise', 
        hintText: 'Naruto, Bleach, Hello Kitty...',
      ),
    );
  }
}

class _PriceInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('addNewProductForm_priceInput_textField'),
      onChanged: (number) => context.read<ProductCubit>().priceChanged(number),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: 'price', 
        hintText: '1,000',
        suffixText: 'VND'
      ),
    );
  }
}

class _QuantityInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('addNewProductForm_quantityInput_textField'),
      onChanged: (number) => context.read<ProductCubit>().quantityChanged(number),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: 'quantity', 
        hintText: '1',
      ),
    );
  }
}

class _DescriptionInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('addNewProductForm_descriptionInput_textField'),
      onChanged: (text) => context.read<ProductCubit>().descriptionChanged(text),
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: 'product descrption', 
      ),
    );
  }
}

class _AddProductButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isInProgress = context.select(
      (ProductCubit cubit) => cubit.state.status.isInProgress,
    );

    if (isInProgress) return const CircularProgressIndicator();

    final isValid = context.select(
      (ProductCubit cubit) => cubit.state.isValid,
    );

    return ElevatedButton(
      key: const Key('addNewProductForm_confirm_raisedButton'),
      onPressed: isValid
          ? () => context.read<ProductCubit>().addProductFormSubmitted()
          : null,
      child: const Text('ADD', style: TextStyle(color: AppColors.title)),
    );
  }
}