import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:global_groove/sizer/sizer.dart';
import '../../color_scheme/color_scheme.dart';
import '../../controller/audio_controller/audio_controllers.dart';
import '../../global_widgets/channel_tile.dart';
import '../../global_widgets/horizontal_chip.dart';
import '../../global_widgets/mini_player.dart';
import '../../models/radio_model.dart';
import '../../services/radio_api/dio_base.dart';
import '../../services/radio_api/get_radio_by_search.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchKeyword = TextEditingController();
  final List<String> chipData = ['Channel', 'Country', 'State', 'Language', 'Genre'];
  List<RadioChannel> data = [];
  int selectedIndex = 0;

  late RadioIdController ctrl;

  @override
  void initState() {
    ctrl = Get.find();
    super.initState();
  }

  void loadData(String keyword) async {
    if(keyword.isEmpty){
      setState(() {});
      return;
    }

    if(selectedIndex==0){
      await RadioApi().getRadiosByName(keyword).then((value) {
        data = value;
      });
    }
    else if(selectedIndex==1){
      await RadioApi().getRadiosByCountry(keyword).then((value) {
        data = value;
      });
    }
    else if(selectedIndex==2){
      await RadioApi().getRadiosByState(keyword).then((value) {
        data = value;
      });
    }
    else if(selectedIndex==3){
      await RadioApi().getRadiosByLanguage(keyword).then((value) {
        data = value;
      });
    }
    else{
      await RadioApi().getRadiosByGenre(keyword).then((value) {
        data = value;
      });
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        leading:  NeumorphicButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: const NeumorphicStyle(
                depth: 10,
                boxShape: NeumorphicBoxShape.circle(),
              ),
              child: ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (bounds) => CustomGradient.primaryGradient.createShader(
                    Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                  ),
                  child: const Center(child: Icon(Icons.arrow_back_ios_new))),

        ),
        title: const Text('Search Channels'),
        centerTitle: true,
      ),
        body: Scrollbar(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 2.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Hero(
                    tag: 'search-button',
                    child: Material(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: Neumorphic(
                        style: NeumorphicStyle(
                          depth: 10,
                          intensity: 1,
                          shape: NeumorphicShape.concave,
                          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(25.sp)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.sp),
                          child: TextField(
                            controller: searchKeyword,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Type a ${chipData[selectedIndex]} name',
                            ),
                            onChanged: (_){
                              loadData(searchKeyword.text);
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
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
                            onTap: (){
                                selectedIndex = index;
                                loadData(searchKeyword.text);
                            },
                            child: customChip(chipData[index], selectedIndex==index)),
                      );
                    },
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int i) {
                    return channelTile(data, i, context);
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
