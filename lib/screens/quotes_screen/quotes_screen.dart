import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:global_groove/screens/quotes_screen/components/quotes_card.dart';
import 'package:global_groove/services/quotes_api/quotes_api.dart';
import 'package:global_groove/sizer/sizer.dart';
import 'package:lottie/lottie.dart';

import '../../color_scheme/color_scheme.dart';
import '../../controller/audio_controller/audio_controllers.dart';
import '../../global_widgets/mini_player.dart';
import '../../models/quotes_model.dart';

class QuotesScreen extends StatefulWidget {
  const QuotesScreen({super.key});

  @override
  State<QuotesScreen> createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {

  List<QuotesModel> data = [];

  void loadData() async {
    await QuotesApi().getRandomQuotes().then((value){
      data = value;
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
        title: const Text('Random Quotes'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Hero(
                tag: 'Random Quotes',
                child: SizedBox(
                    width: 40.w,
                    child: Lottie.asset('assets/quotes.json')),
              ),
            ),
        
            data.isEmpty ? Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: const CircularProgressIndicator(),
            )
                :CarouselSlider.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int i, int pageViewIndex) =>
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 3.h),
                      child: quotesCard(data[i]),
                    ),
                options: CarouselOptions(
                  height: 50.h,
                  viewportFraction: 0.7,
                  initialPage: 0,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  scrollDirection: Axis.horizontal,
                )
            ),
          ],
        ),
      ),
      floatingActionButton: Obx(()=> miniPlayer(context, ctrl.getValue())),
    );
  }
}
