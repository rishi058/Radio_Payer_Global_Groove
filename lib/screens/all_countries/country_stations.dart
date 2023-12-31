import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:global_groove/models/country_model.dart';
import 'package:global_groove/screens/all_countries/components/radio_tile.dart';
import 'package:global_groove/sizer/sizer.dart';
import '../../color_scheme/color_scheme.dart';
import '../../controller/audio_controller/audio_controllers.dart';
import '../../global_widgets/custom_internet_image.dart';
import '../../global_widgets/mini_player.dart';
import '../../models/radio_model.dart';
import '../../services/radio_api/dio_base.dart';
import '../../services/radio_api/get_radios_by_country.dart';
import 'package:get/get.dart';

class CountryStations extends StatefulWidget {
  const CountryStations({super.key,
      required this.country,
  });

  final CountryModel country;

  @override
  State<CountryStations> createState() => _CountryStationsState();
}

class _CountryStationsState extends State<CountryStations>{
  List<RadioChannel> data = [];
  int _initialPage = 1;
  final ScrollController _scrollController = ScrollController();

  void loadData(){
    RadioApi().getCountryRadios(_initialPage, widget.country.countryCode).then((value) {
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
        title: Text(widget.country.countryName, style: TextStyle(fontSize: 10.sp),),
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
                  tag: widget.country.countryCode,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.sp),
                    child: Neumorphic(
                      style: const NeumorphicStyle(
                          depth: 10,
                          intensity: 1,
                          boxShape: NeumorphicBoxShape.circle()
                      ),
                      child: Container(
                        width: 15.h,
                        margin: EdgeInsets.all(3.sp),
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: ClipOval(
                          child: internetImage(widget.country.countryFlag, 15.h, 15.h),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              data.isEmpty ? Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: const CircularProgressIndicator(),
              ) :
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: data.length + 1,
                itemBuilder: (BuildContext context, int i) {
                  if(i<data.length){return radioTile(context, data, i);}
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
