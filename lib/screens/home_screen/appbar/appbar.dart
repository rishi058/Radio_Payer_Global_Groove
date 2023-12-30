import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import '../../../color_scheme/color_scheme.dart';

PreferredSizeWidget customAppBar(BuildContext ctx){
  return NeumorphicAppBar(
    leading: Builder(
      builder: (BuildContext context) {
        return NeumorphicButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          style: const NeumorphicStyle(
            depth: 10,
            boxShape: NeumorphicBoxShape.circle(),
          ),
          child: ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) =>
                  CustomGradient.primaryGradient.createShader(
                Rect.fromLTWH(0, 0, bounds.width, bounds.height),
              ),
              child: const Icon(Icons.menu_sharp)),
        );
      },
    ),
    title: const Text('Global Groove'),
    centerTitle: true,
    // leading:
    actions: [
      Hero(
        tag: 'search-button',
        child: NeumorphicButton(
          onPressed: () {
            Navigator.pushNamed(ctx, 'search-radios-screen');
          },
          style: const NeumorphicStyle(
            depth: 10,
            boxShape: NeumorphicBoxShape.circle(),
          ),
          child: ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (bounds) => CustomGradient.primaryGradient.createShader(
              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
            ),
            child: const Icon(Icons.search,),
          ),
        ),
      )
    ],
  );
}