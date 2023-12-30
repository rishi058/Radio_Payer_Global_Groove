import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:global_groove/services/local_storage/get_storage_helper.dart';
import 'package:global_groove/sizer/sizer.dart';

import '../../../services/firebase_api/authentication/authentication.dart';
import 'logout_dialog.dart';

Widget logOutButton(BuildContext context, Function refresh) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 2.h),
    child: NeumorphicButton(
      onPressed: () {
        if(LocalStorage().isLoggedIn()){
          showLogoutBox(context).then((value) {
            if (value) {
              Authentication.signOut().then((_){
                refresh();
              });
            }
          });
        }
      },
      style: const NeumorphicStyle(
        depth: 10,
        intensity: 1,
        shape: NeumorphicShape.concave,
      ),
      child: SizedBox(
        height: 4.h,
        child: Padding(
          padding: EdgeInsets.all(0.8.h),
          child: Row(
            children: [
              SizedBox(width: 2.h),
              const Icon(Icons.logout),
              SizedBox(width: 2.h),
              const Text('Log Out')
            ],
          ),
        ),
      ),
    ),
  );
}

Widget aboutUsButton(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 2.h),
    child: NeumorphicButton(
      onPressed: (){
        Navigator.of(context).pushNamed('about-screen');
      },
      style: const NeumorphicStyle(
        depth: 10,
        intensity: 1,
        shape: NeumorphicShape.concave,
      ),
      child: SizedBox(
        height: 4.h,
        child: Padding(
          padding: EdgeInsets.all(0.8.h),
          child: Row(
            children: [
              SizedBox(width: 2.h),
              const Icon(Icons.info_outlined),
              SizedBox(width: 2.h),
              const Text('About')
            ],
          ),
        ),
      ),
    ),
  );
}

Widget toggleTheme() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 2.h),
    child: Neumorphic(
      style: const NeumorphicStyle(
        depth: 10,
        intensity: 1,
        shape: NeumorphicShape.concave,
      ),
      child: SizedBox(
        height: 6.h,
        child: Padding(
          padding: EdgeInsets.all(0.8.h),
          child: Row(
            children: [
              SizedBox(width: 3.75.h),
              const Icon(Icons.dark_mode_outlined),
              SizedBox(width: 2.h),
              const Text('Dark Mode'),
              SizedBox(width: 2.h),
              SizedBox(
                width: 15.w,
                height: 3.5.h,
                child: NeumorphicSwitch(
                      value: LocalStorage().isDarkMode(),
                      onChanged: (isDarkModeOn) async {
                        if(isDarkModeOn){
                          LocalStorage().setDarkMode();
                          Get.changeThemeMode(ThemeMode.dark);
                          await Get.forceAppUpdate();
                        }
                        else{
                          LocalStorage().setLightMode();
                          Get.changeThemeMode(ThemeMode.light);
                          await Get.forceAppUpdate();
                        }
                      },
                  style: const NeumorphicSwitchStyle(
                    activeTrackColor: Colors.black,
                    activeThumbColor: Colors.white70,
                    inactiveThumbColor: Colors.black38
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
