import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:global_groove/models/country_model.dart';
import 'package:global_groove/screens/all_countries/country_stations.dart';
import 'package:global_groove/sizer/sizer.dart';

import '../color_scheme/color_scheme.dart';

Widget countryTile(CountryModel country, BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 10.sp),
    child: NeumorphicButton(
      onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  CountryStations(country: country)),
        );
      },
      style: NeumorphicStyle(
        depth: 10,
        intensity: 1,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(5.sp)),
      ),
      child: Container(
        padding: EdgeInsets.all(2.sp),
        height: 7.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Hero(
                  tag: country.countryCode,
                  child: Neumorphic(
                    style: const NeumorphicStyle(
                        depth: 10,
                        intensity: 1,
                        boxShape: NeumorphicBoxShape.circle()
                    ),
                    child: Container(
                      width: 10.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(country.countryFlag),
                          fit: BoxFit.fitHeight,
                          onError:(error, stackTrace) => const AssetImage('assets/not-load.jpg'),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 2.w),
                SizedBox(
                  width: 37.w,
                    child: ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: (bounds) => CustomGradient.secondaryGradient.createShader(
                          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                        ),
                        child: Text(country.countryName, style: TextStyle(fontSize: 10.sp), overflow: TextOverflow.ellipsis,)))
              ],
            ),
            Text('Total Channel : ${country.stationCount}', style: TextStyle(fontSize: 8.sp))
          ],
        ),
      ),
    ),
  );
}
