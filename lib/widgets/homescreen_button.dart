import 'package:cat_dog/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Button extends StatelessWidget {
  VoidCallback onTap;
  String text;

  Button({required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width - 210,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: AppColors.colorFF,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
          vertical: 17.h,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: AppColors.color6F,
          ),
        ),
      ),
    );
  }
}
