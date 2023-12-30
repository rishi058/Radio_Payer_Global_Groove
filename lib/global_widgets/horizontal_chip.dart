import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:global_groove/sizer/sizer.dart';

import '../color_scheme/color_scheme.dart';

Widget customChip(String text, bool isSelected) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 15.sp, horizontal: 10.sp),
    child: Neumorphic(
      style: NeumorphicStyle(
        depth: 10,
        intensity: 1,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(5.sp)),
      ),
      child: Container(
        width: 30.w,
        decoration: BoxDecoration(
          gradient: isSelected ?
          LinearGradient(
            colors: [Colors.blue.shade400, Colors.blue.shade900],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ) : null,
        ),
        child: Center(
          child: isSelected
              ? Text(text,
                  style: TextStyle(fontSize: 11.sp, color: Colors.white))
              : ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (bounds) => CustomGradient.primaryGradient.createShader(
                        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                      ),
                  child: Text(
                    text,
                    style: TextStyle(fontSize: 11.sp),
                  )),
        ),
      ),
    ),
  );
}
