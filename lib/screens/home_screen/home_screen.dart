import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:global_groove/controller/audio_controller/audio_controllers.dart';
import 'package:global_groove/global_widgets/channel_tile.dart';
import 'package:global_groove/global_widgets/country_tile.dart';
import 'package:global_groove/global_widgets/mini_player.dart';
import 'package:global_groove/models/country_model.dart';
import 'package:global_groove/models/home_page_model.dart';
import 'package:global_groove/models/radio_model.dart';
import 'package:global_groove/global_widgets/horizontal_chip.dart';
import 'package:global_groove/sizer/sizer.dart';
import '../../services/radio_api/dio_base.dart';
import '../../services/radio_api/get_home_page.dart';
import '../drawer/drawer.dart';
import 'appbar/appbar.dart';
import 'components/navigation_cards.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> chipData = ['Featured', 'Top Voted', 'Top Countries'];
  int selectedIndex = 0;
  HomePageData? data;
  List<RadioChannel> displayChannel = [];
  List<CountryModel> displayCountry = [];


  void sendDataToWidget() {
    if (selectedIndex == 0) {
      displayChannel = data!.featured;
    } else if (selectedIndex == 1) {
      displayChannel = data!.topVoted;
    } else {
      displayCountry = data!.topCountries;
    }
  }

  void loadData() {
    RadioApi().getHomePage().then((val) {
      data = val;
      sendDataToWidget();
      setState(() {});
    });
  }

  late RadioIdController ctrl;

  @override
  void initState() {
    ctrl = Get.find();
    loadData();
    super.initState();
  }

  refresh() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: customAppBar(context),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            CarouselSlider.builder(
                itemCount: navigationCardList.length,
                itemBuilder: (BuildContext context, int i, int pageViewIndex) =>
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 3.h),
                      child: Hero(
                        tag: navigationCardList[i].text,
                        child: customButtonCard(
                            navigationCardList[i].text,
                            navigationCardList[i].asset,
                            navigationCardList[i].destination,
                            context),
                      ),
                    ),
                options: CarouselOptions(
                  height: 35.h,
                  viewportFraction: 0.5,
                  initialPage: 0,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  scrollDirection: Axis.horizontal,
                )),
            Container(
              padding: EdgeInsets.symmetric(vertical: 15.sp),
              height: 16.h,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: chipData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.sp),
                    child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                            sendDataToWidget();
                          });
                        },
                        child: customChip(
                            chipData[index], selectedIndex == index)),
                  );
                },
              ),
            ),
            data == null
                ? const CircularProgressIndicator()
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: selectedIndex == 2
                        ? displayCountry.length
                        : displayChannel.length,
                    itemBuilder: (BuildContext context, int i) {
                      return selectedIndex == 2
                          ? countryTile(displayCountry[i], context)
                          : channelTile(displayChannel, i, context);
                    },
                  ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
      floatingActionButton: Obx(()=> miniPlayer(context, ctrl.getValue())),
    );
  }
}
