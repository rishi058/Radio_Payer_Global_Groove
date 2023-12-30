import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:global_groove/sizer/sizer.dart';

import '../../color_scheme/color_scheme.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {

  Widget showText(String value) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 12.sp),
      child: Text(
        value,
        style: TextStyle(
          fontSize: 10.sp
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        leading:  NeumorphicButton(
          onPressed: () {
            Navigator.of(context).pop();
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
              child: const Center(child: Icon(Icons.arrow_back_ios_new))),

        ),
        title: const Text('About'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.sp),
          child: Column(
            children: [
                showText('1. Neumorphic UI Design : Explore a modern design with soft shadows, creating a visually pleasing and immersive experience.'),
                showText('2. Light-Dark Mode Support : Customize your visual experience with light and dark modes for enhanced usability day or night.'),
                showText('3. One-Tap Google OAuth Login : Effortlessly sign in with a single tap using your Google account, ensuring a seamless and secure login process.'),
                showText('4. Seamless Navigation: Glide effortlessly between pages with smooth transitions, providing a seamless and fluid experience as you explore the app.'),
                showText('5. Favourite Channels : Effortlessly enhance your listening experience by adding channels to your favorites list with just a single tap.'),
                showText('6. Custom Channels : Craft your own personal playlist by adding your own Stream url\'s.'),
                showText('7. Random Quotes : Enjoy a dose of inspiration with random quotes available on the app, adding a bit of positivity to your day.'),
                showText('8. Radio : This App currently features 43,676 stations with 9,939 distinct tags, spanning 225 countries and supporting 492 languages.'),
                showText('9. Search : Search for Radio Channel on the basis of Channel name, Country, State, Language and Genre.'),
                showText('10. HomePage : Get top voted channels, most clicked channel and some top countries on your home-page.'),
              showText('Contact us at : devwizards01@gmail.com'),
            ],
          ),
        ),
      ),
    );
  }
}
