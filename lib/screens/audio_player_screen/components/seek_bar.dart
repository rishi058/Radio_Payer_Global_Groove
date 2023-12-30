import 'dart:async';
import 'package:flutter/material.dart';
import 'package:global_groove/global_widgets/time_widget.dart';
import 'package:global_groove/sizer/sizer.dart';
import '../../../color_scheme/color_scheme.dart';
import '../../../controller/audio_controller/audio_controllers.dart';


Widget seekBar(bool isMusicOn){
  return Column(
    children: [
      Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 15.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('0:00'),
            isMusicOn ? const TimerWidget(textSize: 10) :  const Text('0:00'),
          ],
        ),
      ),
      Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 70.w,
              height: 0.75.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5.sp), topLeft: Radius.circular(5.sp)),
                  gradient: CustomGradient.primaryGradient2
              ),
            ),
            Container(
              width: 3.w,
              height: 3.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: CustomLightThemeColor.primaryVividColor,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
