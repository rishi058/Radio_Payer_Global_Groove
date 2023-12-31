import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:global_groove/sizer/sizer.dart';

Widget internetImage(String imageUrl, double height, double width) {
  try {
    return Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
        log(error.toString());
        return _buildErrorWidget(height,width);
      },
    );
  } catch (e) {
    log(e.toString());
    return _buildErrorWidget(height,width);
  }
}

Widget _buildErrorWidget(double height, double width) {
  return Image.asset(
      'assets/not-load.png',
    width: width,
    height: height,
    fit: BoxFit.cover,
  );

}