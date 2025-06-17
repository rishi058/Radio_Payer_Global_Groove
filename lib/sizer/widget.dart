part of 'sizer.dart';

typedef ResponsiveBuild = Widget Function(
  BuildContext context,
);


class Sizer extends StatefulWidget {
  const Sizer({super.key, required this.builder, required this.context});

  final ResponsiveBuild builder;
  final BuildContext context;

  @override
  State<Sizer> createState() => _SizerState();
}

class _SizerState extends State<Sizer> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
        SizerUtil.setScreenSize(widget.context);
        return widget.builder(widget.context);
    });
  }
}
