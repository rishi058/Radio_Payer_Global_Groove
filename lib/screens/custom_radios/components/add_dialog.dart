import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:global_groove/services/firebase_api/firebase_db/custom_channels.dart';
import 'package:global_groove/services/firebase_api/firebase_db/firebase_database.dart';
import 'package:global_groove/services/firebase_api/firebase_db/small_data_instances.dart';
import 'package:global_groove/sizer/sizer.dart';
import '../../../color_scheme/color_scheme.dart';
import '../../../services/local_storage/get_storage_helper.dart';

Future<void> showAddDialog(BuildContext context, Function refresh) async {
  TextEditingController channelName = TextEditingController();
  TextEditingController channelUrl = TextEditingController();

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: LocalStorage().isDarkMode() ? Colors.black : CustomLightThemeColor.backgroundColor,
        title: Text('Add a custom Channel', style: TextStyle(fontSize: 12.sp),),
        content: SizedBox(
          width: 80.w,
          height: 18.h,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.sp),
                child: TextField(
                  controller: channelName,
                  decoration: const InputDecoration(
                    hintText: 'Type channel name',
                    border:  OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.sp),
                child: TextField(
                  controller: channelUrl,
                  decoration: const InputDecoration(
                    hintText: 'Type stream url',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: ()   {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel')),
          SizedBox(width: 3.w),
          TextButton(
              onPressed: () {
                if(channelName.text.isEmpty || channelUrl.text.isEmpty){return;}
                FirebaseDB().addChannel(channelName: channelName.text, streamUrl: channelUrl.text).then((_) {
                  FirebaseDB().getCustomChannels().then((value) {
                    myCustomChannelList = value;
                  }).then((value){
                    refresh();
                    Navigator.of(context).pop();
                  });
                });
              },
              child: const Text('Add'))
        ],
      );
    },
  );
}
