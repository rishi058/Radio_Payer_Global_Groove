import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:global_groove/color_scheme/color_scheme.dart';
import 'package:global_groove/services/radio_api/get_all_counties.dart';
import 'package:global_groove/sizer/sizer.dart';
import 'package:lottie/lottie.dart';

import '../../controller/audio_controller/audio_controllers.dart';
import '../../global_widgets/country_tile.dart';
import '../../global_widgets/mini_player.dart';
import '../../models/country_model.dart';
import '../../services/radio_api/dio_base.dart';


class AllCountriesScreen extends StatefulWidget {
  const AllCountriesScreen({super.key});

  @override
  State<AllCountriesScreen> createState() => _AllCountriesScreenState();
}

class _AllCountriesScreenState extends State<AllCountriesScreen> {

  int _initialPage = 1;
  final ScrollController _scrollController = ScrollController();

  List<CountryModel> data = [];

  void loadData(){
      RadioApi().getAllCountries(_initialPage).then((value) {
      data += value;
      _initialPage++;
      setState(() {});
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      loadData();
    }
  }

  late RadioIdController ctrl;

  @override
  void initState() {
    data.clear();
    loadData();
    ctrl = Get.find();
    _scrollController.addListener(_onScroll);
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
                  shaderCallback: (bounds) => CustomGradient.primaryGradient.createShader(
                    Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                  ),
                  child: const Center(child: Icon(Icons.arrow_back_ios_new))),
        ),
        title: const Text('Country List'),
        centerTitle: true,
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          controller: _scrollController,
          child: Column(
            children: [
              Center(
                child: Hero(
                  tag: 'Listen to Country Channels',
                  child: SizedBox(
                      width: 70.w,
                      child: Lottie.asset('assets/all-countries.json')),
                ),
              ),
              data.isEmpty ? const CircularProgressIndicator() :
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: data.length + 1,
                itemBuilder: (BuildContext context, int i) {
                  if(i<data.length){return countryTile(data[i], context);}
                  else{
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 46.w, vertical: 5.h),
                      child: const CircularProgressIndicator(),
                    );
                  }
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
