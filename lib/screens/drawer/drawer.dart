import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:global_groove/services/firebase_api/firebase_db/firebase_database.dart';
import 'package:global_groove/sizer/sizer.dart';
import '../../color_scheme/color_scheme.dart';
import '../../services/firebase_api/authentication/authentication.dart';
import '../../services/local_storage/get_storage_helper.dart';
import 'components/button.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String url = "", name = "", gmail = "";

  void loadData() {
    if (LocalStorage().isLoggedIn()) {
      url = FirebaseDB().userPicture;
      name = FirebaseDB().userName;
      gmail = FirebaseDB().userMail;
    } else {
      url = "https://cdn-icons-png.flaticon.com/512/3135/3135715.png";
      name = "Guest";
      gmail = "Login";
    }
  }

  void refresh() {
    setState(() {});
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    loadData();
    return SafeArea(
      child: Drawer(
        backgroundColor: LocalStorage().isDarkMode()
            ? const Color(0xFF1A1919)
            : CustomLightThemeColor.backgroundColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 7.h),
              Neumorphic(
                style: const NeumorphicStyle(
                    depth: 10,
                    intensity: 1,
                    shape: NeumorphicShape.concave,
                    boxShape: NeumorphicBoxShape.circle()),
                child: Container(
                  height: 15.h,
                  margin: EdgeInsets.all(5.sp),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(url),
                        fit: BoxFit.fitHeight,
                        onError: (error, stackTrace) =>
                            const AssetImage('assets/not-load.jpg'),
                      )),
                ),
              ),
              SizedBox(height: 3.h),
              Neumorphic(
                style: const NeumorphicStyle(depth: 10, intensity: 1),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(name, style: TextStyle(fontSize: 8.sp)),
                ),
              ),
              SizedBox(height: 2.h),
              NeumorphicButton(
                onPressed: () {
                  if(LocalStorage().isLoggedIn()){
                    Authentication.switchAccounts(context).then((_) {
                      setState(() {});
                    });
                  }
                  else{
                    Authentication.signInWithGoogle().then((_){
                      setState(() {});
                    });
                  }
                },
                style: const NeumorphicStyle(depth: 10, intensity: 1),
                child: SizedBox(
                  height: 2.h,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(gmail,  style: TextStyle(fontSize: 8.sp)),
                      SizedBox(width: 1.h),
                      ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (bounds) =>
                              CustomGradient.primaryGradient.createShader(
                                Rect.fromLTWH(
                                    0, 0, bounds.width, bounds.height),
                              ),
                          child: const Icon(Icons.swap_horiz_outlined)),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 6.h),
              logOutButton(context, refresh),
              SizedBox(height: 2.h),
              aboutUsButton(context),
              SizedBox(height: 2.h),
              toggleTheme(),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
    );
  }
}
