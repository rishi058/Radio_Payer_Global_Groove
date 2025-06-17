import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:global_groove/color_scheme/color_scheme.dart';
import 'package:global_groove/responsive.dart';
import 'package:global_groove/screens/about_screen/about_screeen.dart';
import 'package:global_groove/screens/all_countries/all_countries_screen.dart';
import 'package:global_groove/screens/all_radios/all_radios_screen.dart';
import 'package:global_groove/screens/custom_radios/custom_radios_screen.dart';
import 'package:global_groove/screens/favourite_radios/favourite_radios_screen.dart';
import 'package:global_groove/screens/home_screen/home_screen.dart';
import 'package:global_groove/screens/quotes_screen/quotes_screen.dart';
import 'package:global_groove/screens/search_screen/search_screen.dart';
import 'package:global_groove/screens/splash_screen/splash_screen.dart';
import 'package:global_groove/services/firebase_api/firebase_db/small_data_instances.dart';
import 'package:global_groove/services/local_storage/get_storage_helper.dart';
import 'package:global_groove/sizer/sizer.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    loadFirebaseDBToCache();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      builder: (context, child) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, child!),
          maxWidth: getWidth(context),
          defaultScale: true,
          background: Container(color: const Color(0xFFE0E0E0))),
      home: const Start(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
        context: context,
        builder: (context) {
          return NeumorphicApp(
            debugShowCheckedModeBanner: false,
            themeMode:
                LocalStorage().isDarkMode() ? ThemeMode.dark : ThemeMode.light,
            theme: NeumorphicThemeData(
              textTheme: GoogleFonts.montserratTextTheme(),
              baseColor: CustomLightThemeColor.backgroundColor,
              shadowDarkColor: CustomLightThemeColor.shadowDarkColor,
              shadowLightColor: CustomLightThemeColor.shadowLightColor,
              lightSource: LightSource.topLeft,
              depth: 10,
            ),
            darkTheme: NeumorphicThemeData(
              textTheme: GoogleFonts.montserratTextTheme(ThemeData(brightness: Brightness.dark).textTheme),
              baseColor: CustomDarkThemeColor.backgroundColor,
              shadowDarkColor: CustomDarkThemeColor.shadowDarkColor,
              shadowLightColor: CustomDarkThemeColor.shadowLightColor,
              lightSource: LightSource.topLeft,
              depth: 10,
            ),
            home: const SplashScreen(),
            routes: {
              'home-screen': (context) => const HomeScreen(),
              'all-countries-screen': (context) => const AllCountriesScreen(),
              'all-radios-screen': (context) => const AllRadiosScreen(),
              'quotes-screen': (context) => const QuotesScreen(),
              'custom-radios-screen': (context) => const CustomRadiosScreen(),
              'favourite-radios-screen': (context) => const FavouriteRadios(),
              'search-radios-screen': (context) => const SearchScreen(),
              'about-screen': (context) => const AboutScreen(),
            },
          );
        });
  }
}
