part of sizer;

extension SizerExt on num {

  /// Use these for % wise design
  double get h => this * SizerUtil.height / 100;
  double get w => this * SizerUtil.width / 100;

  /// Use these for figma pixel perfect UI
  // double get h => ( this / SizerUtil.figmaHeight ) * SizerUtil.height;
  // double get w => ( this / SizerUtil.figmaWidth ) * SizerUtil.width;

  /// Calculates the sp (Scalable Pixel) depending on the device's screen size
  double get sp => this * (SizerUtil.width / 3) / 100;
}
