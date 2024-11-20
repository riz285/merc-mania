import 'package:flutter/material.dart';
import 'package:merc_mania/app/view/app.dart';
import 'package:merc_mania/common/widgets/styled_app_bar.dart';
import 'package:merc_mania/screens/order/view/order_page.dart';
import 'package:merc_mania/screens/product_display/view/user_product_screen.dart';

import '../../../../core/configs/themes/app_colors.dart';

class AddProductSuccessScreen extends StatelessWidget {
  const AddProductSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyledAppBar(
        title: Text('Notification'),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AppView()));
          },
          icon: Icon(
            Icons.navigate_before,
            size: 25,
            color: AppColors.title
          ),
      ),
      ),
      body: Padding(
        padding: EdgeInsets.all(50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Center(child: Text('Congratulations!')),
          Center(child: Text('You have successfully added a product to sell.')),
          Row(children: [
            TextButton(
            onPressed: () { 
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => UserProductScreen())
              );
             },
            child: Text('My Products')
          ),
          Spacer(),
          TextButton(
            onPressed: () { 
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => AppView())
              );
             },
            child: Text('Home')
          )
          ])
        ])
      ),
    );
  }
}