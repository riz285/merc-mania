import 'package:flutter/material.dart';
import 'package:merc_mania/screens/product_display/view/product_screen.dart';

import '../../../../services/models/franchise.dart';

class FranchiseCard extends StatelessWidget {
  final Franchise franchise;
  const FranchiseCard({super.key, required this.franchise});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ProductScreen(franchise: franchise),
            )
          );
      },
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.grey[700],
          image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(franchise.image))
        ),
        child: Stack(
          children: [
            // Favorite IconButton
            // Positioned(
            //   top: 0.0,
            //   right: 0.0,
            //   child: IconButton(
            //     onPressed: () {}, 
            //     icon: Icon(
            //       Icons.favorite_border_outlined,
            //     ), 
            //     selectedIcon: Icon(
            //       Icons.favorite_rounded, 
            //       color: Colors.redAccent,
            //     )
            //   ),
            // ),
            // Franchise name
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 35,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(54, 54, 54, 95),
                    ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(franchise.name,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
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