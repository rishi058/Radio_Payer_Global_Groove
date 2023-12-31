import 'dart:async';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:global_groove/controller/audio_controller/audio_controllers.dart';
import 'package:global_groove/global_widgets/time_widget.dart';
import 'package:global_groove/sizer/sizer.dart';
import 'package:lottie/lottie.dart';
import '../color_scheme/color_scheme.dart';
import '../screens/audio_player_screen/audio_player_screen.dart';
import 'custom_internet_image.dart';

Widget miniPlayer(BuildContext context, String radioId) {
  String imgUrl = "";
  if (AudioController.isPlaying) {
    imgUrl =
        AudioController.channelList[AudioController.channelIndex].radioImage;
    if (imgUrl.isEmpty) {
      imgUrl =
          AudioController.channelList[AudioController.channelIndex].countryFlag;
    }
  }
  return radioId.isEmpty
      ? const SizedBox(width: 0, height: 0)
      : Dismissible(
        key: const Key("mini-player"),
        onDismissed: (direction){
          AudioController.stopAudio();
        },
        child: Padding(
            padding: EdgeInsets.only(left: 7.5.w),
            child: Neumorphic(
              style: const NeumorphicStyle(
                  intensity: 4, depth: 1, shape: NeumorphicShape.concave),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AudioPlayerScreen(
                            channels: AudioController.channelList,
                            index: AudioController.channelIndex)),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 8.h,
                  color: Colors.blue.withOpacity(0.1),
                  padding: EdgeInsets.all(5.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Neumorphic(
                        style: const NeumorphicStyle(
                            depth: 10,
                            intensity: 1,
                            boxShape: NeumorphicBoxShape.circle()),
                        child: Container(
                          width: 10.w,
                          decoration: const BoxDecoration(shape: BoxShape.circle),
                          child: ClipOval(
                            child: internetImage(imgUrl, 10.w, 10.w),
                          ),
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 60.w,
                            child: ShaderMask(
                                blendMode: BlendMode.srcIn,
                                shaderCallback: (bounds) =>
                                    CustomGradient.secondaryGradient.createShader(
                                      Rect.fromLTWH(
                                          0, 0, bounds.width, bounds.height),
                                    ),
                                child: Text(
                                    AudioController
                                        .channelList[AudioController.channelIndex]
                                        .radioName,
                                    style: TextStyle(fontSize: 9.sp),
                                    overflow: TextOverflow.ellipsis)),
                          ),
                          SizedBox(
                            width: 60.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '0:00',
                                  style: TextStyle(fontSize: 7.sp),
                                ),
                                const TimerWidget(textSize: 7),
                              ],
                            ),
                          ),
                          Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 60.w,
                                  height: 0.5.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(5.sp),
                                          topLeft: Radius.circular(5.sp)),
                                      gradient: CustomGradient.primaryGradient2),
                                ),
                                Container(
                                  width: 2.w,
                                  height: 2.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                        CustomLightThemeColor.primaryVividColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 3.w),
                      SizedBox(
                          width: 7.w,
                          child: Lottie.asset('assets/music.json')),
                    ],
                  ),
                ),
              ),
            ),
          ),
      );
}