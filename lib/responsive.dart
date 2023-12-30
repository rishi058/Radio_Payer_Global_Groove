import 'package:flutter/material.dart';

double getWidth(BuildContext context){
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  double aspectRatio = width/height;
  if(aspectRatio>0.6){
    return height*0.6;
  }
  return width;
}