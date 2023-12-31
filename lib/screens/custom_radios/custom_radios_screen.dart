import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:global_groove/screens/custom_radios/components/add_dialog.dart';
import 'package:global_groove/services/firebase_api/firebase_db/small_data_instances.dart';
import 'package:global_groove/sizer/sizer.dart';
import 'package:lottie/lottie.dart';
import '../../color_scheme/color_scheme.dart';
import '../../controller/audio_controller/audio_controllers.dart';
import '../../global_widgets/mini_player.dart';
import '../../services/local_storage/get_storage_helper.dart';
import 'components/custom_channel_tile.dart';

class CustomRadiosScreen extends StatefulWidget {
  const CustomRadiosScreen({super.key});

  @override
  State<CustomRadiosScreen> createState() => _CustomRadiosScreenState();
}

class _CustomRadiosScreenState extends State<CustomRadiosScreen> {

  refresh() {
   setState(() {});
  }

  late RadioIdController ctrl;

  @override
  void initState() {
    ctrl = Get.find();
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
                    shaderCallback: (bounds) =>
                        CustomGradient.primaryGradient.createShader(
                          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                        ),
                    child: const Center(child: Icon(Icons.arrow_back_ios_new))),

          ),
          title: const Text('Custom Channel'),
          centerTitle: true,
          actions: [
            NeumorphicButton(
              onPressed: () {
                if(LocalStorage().isLoggedIn()){
                  showDialog(context: context, builder: (BuildContext context){
                    return AddChannelDialog(refresh: refresh);
                  });
                  // AddChannelDialog(refresh: refresh);
                }
                else{
                  Get.snackbar('Login to add a custom channel', '');
                }
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
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ),
        body: Scrollbar(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Center(
                  child: Hero(
                    tag: 'My Custom Channels',
                    child: SizedBox(
                        width: 40.w,
                        child: Lottie.asset('assets/custom-radios.json')),
                  ),
                ),
                LocalStorage().isLoggedIn() == false
                    ? const Center(child: Text('Login to view your Custom Channel'))
                    : myCustomChannelList.isEmpty
                        ? const Center(
                            child: Text('You do not have any Custom Channel'))
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: myCustomChannelList.length,
                            itemBuilder: (BuildContext context, int i) {
                              return customChannelTile(
                                  myCustomChannelList, i, context, refresh);
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
