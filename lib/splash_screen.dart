import 'dart:async';

import 'package:cat_dog/constant/colors.dart';
import 'package:cat_dog/constant/images.dart';
import 'package:cat_dog/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MySplash extends StatefulWidget {
  const MySplash({super.key});

  @override
  State<MySplash> createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Home(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.color3B,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
          child: Image.asset(AppImages.splash),
        ),
        SizedBox(
          height: 40.h,
        ),
        Text(
          'Cat Or Dag',
          style: TextStyle(
            color: AppColors.color54,
            fontSize: 20.0.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 60.h,
        ),
        CircularProgressIndicator(
          color: AppColors.colorFF,
        ),
      ]),
    );
  }
}
