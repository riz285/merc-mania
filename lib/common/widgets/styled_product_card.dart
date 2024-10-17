import 'package:flutter/material.dart';

import '../../services/models/product.dart';

class StyledProductCard extends StatelessWidget {
  final Product product;
  const StyledProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.grey[700],
        image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: NetworkImage(product.image))
      ),
      child: Stack(
        children: [
          // Discount percentage
          Visibility(
            visible: (product.discountPercentage != 0) ,
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
              onPressed: () {}, 
              icon: Icon(
                Icons.favorite_border_outlined,
              ), 
              selectedIcon: Icon(
                Icons.favorite_rounded, 
                color: Colors.redAccent,
              )
            ),
          ),
          // Product price
          Positioned(
            bottom: 0.0,
            child: Container(
              height: 35,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(54, 54, 54, 95),
                  borderRadius: BorderRadius.only(topRight: Radius.circular(15), bottomRight: Radius.circular(15)),
                  ),
              child: Row(
                children: [
                  Text(' ${product.price} VND ',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  ),
                ]
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class _discountBanner(int? discountPercentage) extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//   if (discountPercentage != '')
//   return Positioned(
//             top: 0.0,
//             child: Container(
//               height: 30,
//               width: 40,
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
//               color: Colors.red,
//               ),
//               child: Text(
//                 '$discountPercentage%', 
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white
//                 ),
//               ),
//             ),
//           )
//           };
