import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:global_groove/sizer/sizer.dart';
import 'package:lottie/lottie.dart';

Widget customButtonCard(String text, String asset, String destination, BuildContext context){
  return NeumorphicButton(
    style: NeumorphicStyle(
      depth: 10,
      intensity: 1,
      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(5.sp)),
    ),
    child: SizedBox(
      width: 70.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
              width: 16.h,
              child: Lottie.asset(asset)),
          Text(text, style: TextStyle(fontSize: 12.sp, ), textAlign: TextAlign.center,),
        ],
      ),
    ),
    onPressed: (){
      Navigator.of(context).pushNamed(destination);
    },
  );
}

class NavigationInfo{
 String text = "";
 String asset = "";
 String destination = "";

 NavigationInfo(this.text, this.asset, this.destination);
}

List <NavigationInfo> navigationCardList = [
  NavigationInfo('Explore All Radio Channels', 'assets/all-radios.json', 'all-radios-screen'),
  NavigationInfo('Listen to Country Channels', 'assets/all-countries.json', 'all-countries-screen'),
  NavigationInfo('My Favourite Channels', 'assets/favourites.json', 'favourite-radios-screen'),
  NavigationInfo('My Custom Channels', 'assets/custom-radios.json', 'custom-radios-screen'),
  NavigationInfo('Random Quotes', 'assets/quotes.json', 'quotes-screen'),
];