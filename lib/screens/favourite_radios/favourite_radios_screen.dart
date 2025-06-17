import 'dart:async';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:global_groove/global_widgets/channel_tile.dart';
import 'package:global_groove/services/firebase_api/firebase_db/small_data_instances.dart';
import 'package:global_groove/services/local_storage/get_storage_helper.dart';
import 'package:global_groove/services/radio_api/get_favourite_radio_list.dart';
import 'package:global_groove/sizer/sizer.dart';
import 'package:lottie/lottie.dart';

import '../../color_scheme/color_scheme.dart';
import '../../controller/audio_controller/audio_controllers.dart';
import '../../global_widgets/mini_player.dart';
import '../../models/radio_model.dart';
import '../../services/radio_api/dio_base.dart';

class FavouriteRadios extends StatefulWidget {
  const FavouriteRadios({super.key});

  @override
  State<FavouriteRadios> createState() => _FavouriteRadiosState();
}

class _FavouriteRadiosState extends State<FavouriteRadios> {
  List<RadioChannel>? favourite;

  Future<void> loadData() async {
    await RadioApi().getFavouriteRadioList(myFavouriteChannelList).then((val) {
      setState(() {
        favourite = val;
      });
    });
  }


  late RadioIdController ctrl;

  @override
  void initState() {
    ctrl = Get.find();
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: NeumorphicAppBar(
          leading: NeumorphicButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: const NeumorphicStyle(
                  depth: 10,
                  boxShape: NeumorphicBoxShape.circle(),
                ),
                child: ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (bounds) =>
                        CustomGradient.primaryGradient.createShader(
                          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                        ),
                    child: const Center(child: Icon(Icons.arrow_back_ios_new))),

          ),
          title: const Text('Favourites'),
          centerTitle: true,
        ),
        body: Scrollbar(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Center(
                  child: Hero(
                    tag: 'My Favourite Channels',
                    child: SizedBox(
                        width: 70.w,
                        child: Lottie.asset('assets/favourites.json')),
                  ),
                ),
                LocalStorage().isLoggedIn() == false
                    ? const Center(child: Text('Login to view favourites'))
                    : favourite == null
                        ? const Center(child: CircularProgressIndicator())
                        : favourite!.isEmpty
                            ? const Center(
                                child: Text('You do not have any favourites.'))
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: myFavouriteChannelList.length,
                                itemBuilder: (BuildContext context, int i) {
                                  return channelTile(favourite!, i, context);
                                },
                              ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      floatingActionButton: Obx(()=> miniPlayer(context, ctrl.getValue())),
    );
  }
}
