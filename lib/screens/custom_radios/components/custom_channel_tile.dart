import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:global_groove/color_scheme/color_scheme.dart';
import 'package:global_groove/models/radio_model.dart';
import 'package:global_groove/screens/audio_player_screen/audio_player_screen.dart';
import 'package:global_groove/services/firebase_api/firebase_db/custom_channels.dart';
import 'package:global_groove/services/firebase_api/firebase_db/firebase_database.dart';
import 'package:global_groove/sizer/sizer.dart';

import '../../../global_widgets/custom_internet_image.dart';
import '../../../services/firebase_api/firebase_db/small_data_instances.dart';
import 'delete_dialog.dart';

Widget customChannelTile(List<RadioChannel> channelList, int index, BuildContext context, Function refresh) {

  RadioChannel channel = channelList[index];
  channel.log();

  return Padding(
    padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 10.sp),
    child: NeumorphicButton(
      onPressed: (){
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
                  tag: channel.radioName,
                  child: Neumorphic(
                    style: const NeumorphicStyle(
                        depth: 10,
                        intensity: 1,
                        boxShape: NeumorphicBoxShape.circle()
                    ),
                    child: Container(
                      width: 10.w,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: ClipOval(
                        child: internetImage(channel.radioImage, 10.w, 10.w),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 3.w),
                SizedBox(
                    width: 37.w,
                    child: ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: (bounds) => CustomGradient.secondaryGradient.createShader(
                          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                        ),
                        child: Text(channel.radioName, style: TextStyle(fontSize: 12.sp), overflow: TextOverflow.ellipsis)))
              ],
            ),
            IconButton(
                onPressed: (){
                    showDeleteDialog(context).then((value) {
                      if(value){
                        FirebaseDB().deleteChannel(channel.radioId).then((value) async {
                          await FirebaseDB().getCustomChannels().then((value) {
                            myCustomChannelList = value;
                          }).then((value){
                            refresh();
                          });
                        });
                      }
                    });
                },
                icon: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent)
            )
          ],
        ),
      ),
    ),
  );
}
