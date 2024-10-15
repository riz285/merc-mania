import 'package:flutter/material.dart';
import 'package:merc_mania/core/configs/assets/app_images.dart';
import 'package:merc_mania/home/home_page.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    redirect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          //Splash Art
          child: Image.asset(AppImages.logoImage,
          height: 50,
          width: 50),
          ),
    );
  }

  //Keep user wait for 2 secs
  Future<void> redirect() async {
    await Future.delayed(const Duration(seconds: 2));
    //Get to start page (remove Splash)
    Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
            builder: (context) => const HomePage()));
  }
}
