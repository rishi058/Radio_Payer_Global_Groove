part of sizer;

class SizerUtil {
  /// Device's Height
  static late double height;
  static late double width;

  static double figmaWidth = 375;
  static double figmaHeight = 812;
  
  static void setScreenSize(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = width * 2;
  }
}
