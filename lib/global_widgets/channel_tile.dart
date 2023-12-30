import 'dart:math';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:global_groove/color_scheme/color_scheme.dart';
import 'package:global_groove/models/radio_model.dart';
import 'package:global_groove/screens/audio_player_screen/audio_player_screen.dart';
import 'package:global_groove/sizer/sizer.dart';

Widget channelTile(
    List<RadioChannel> channelList, int index, BuildContext context) {
  RadioChannel channel = channelList[index];

  String imageUrl = channel.radioImage;
  if (imageUrl.isEmpty) {
    imageUrl = channel.countryFlag;
  }

  return Padding(
    padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 10.sp),
    child: NeumorphicButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  AudioPlayerScreen(channels: channelList, index: index)),
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
                  tag: channel.radioId,
                  child: Neumorphic(
                    style: const NeumorphicStyle(
                        depth: 10,
                        intensity: 1,
                        boxShape: NeumorphicBoxShape.circle()),
                    child: Container(
                      width: 10.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(imageUrl),
                          fit: BoxFit.fitHeight,
                          onError: (error, stackTrace) =>
                              const AssetImage('assets/not-load.jpg'),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 1.w),
                SizedBox(
                    width: 37.w,
                    child: ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: (bounds) =>
                            CustomGradient.secondaryGradient.createShader(
                              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                            ),
                        child: Text(channel.radioName,
                            style: TextStyle(fontSize: 10.sp),
                            overflow: TextOverflow.ellipsis)))
              ],
            ),
            SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                      'Country : ${channel.countryName.substring(0, min(16, channel.countryName.length))}',
                      style: TextStyle(fontSize: 7.sp),
                      overflow: TextOverflow.fade),
                  Text(
                      'Genre : ${channel.tags.length > 16 ? '${channel.tags.substring(0, 10)}..' : channel.tags}',
                      style: TextStyle(fontSize: 7.sp)),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
