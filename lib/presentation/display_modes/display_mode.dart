import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:merc_mania/core/configs/assets/app_vectors.dart';

class DisplayMode extends StatelessWidget {
  const DisplayMode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
              decoration: const BoxDecoration(color: Colors.white)),
          Container(
            color: Colors.black.withOpacity(0.15),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 40,
                horizontal: 40,
              ),
              child: Column(children: [
                Align(
                  alignment: Alignment.topCenter,
                  child:
                      SvgPicture.asset(AppVectors.logo, width: 50, height: 50),
                ),
                const Spacer(),
                const Text('Select Mode',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18,
                ),),
                const SizedBox(height:  21),
                // Row(children: [
                //   Container(
                //     height: 50,
                //     width: 50,
                //     decoration: BoxDecoration(
                //       color: Colors.white
                //     ),
                //   ),
                //   SizedBox(width: 20),
                //   Container()
                // ],)
              ]))
        ],
      ),
    );
  }
}
