import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:global_groove/controller/audio_controller/audio_controllers.dart';
import 'package:global_groove/services/firebase_api/firebase_db/favourite_channels.dart';
import 'package:global_groove/services/firebase_api/firebase_db/firebase_database.dart';
import 'package:global_groove/services/local_storage/get_storage_helper.dart';
import 'package:global_groove/sizer/sizer.dart';
import '../../color_scheme/color_scheme.dart';
import '../../models/radio_model.dart';
import '../../services/firebase_api/firebase_db/small_data_instances.dart';
import 'components/seek_bar.dart';

class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen({super.key,
      required this.channels,
      required this.index,
  });

  final List<RadioChannel> channels;
  final int index;

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  List<RadioChannel> data = [];
  int i = 0;
  String imageUrl = "";

  bool isMusicOn = false;
  bool isLoading = false;


  void loadData(){
    data = widget.channels;
    i = widget.index;
    data[i].log();
    imageUrl = data[i].radioImage;
    if(imageUrl.isEmpty){
      imageUrl = data[i].countryFlag;
    }
    RadioIdController ctrl = Get.find();
    if(ctrl.getValue()==data[i].radioId){
      isMusicOn = true;
    }
  }


  void nextRadio(){
    if(i+1<data.length){
      AudioController.stopAudio();
      isMusicOn = false;
      i+=1;
      imageUrl = data[i].radioImage;
      if(imageUrl.isEmpty){
        imageUrl = data[i].countryFlag;
      }
      setState(() {});}
  }
  void prevRadio(){
    if(i>0){
      AudioController.stopAudio();
      i-=1;
      isMusicOn = false;
      imageUrl = data[i].radioImage;
      if(imageUrl.isEmpty){
        imageUrl = data[i].countryFlag;
      }
      setState(() {});}
    }


  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context){
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
        title: Text('NOW PLAYING', style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),),
        centerTitle: true,
        actions: [
          NeumorphicButton(
            onPressed: () {
                if(LocalStorage().isLoggedIn()){
                  if(myFavouriteChannelList.contains(data[i].radioId)){
                      FirebaseDB().removeFromFavourites(data[i].radioId).then((val){
                        if(val){
                          myFavouriteChannelList.remove(data[i].radioId);
                          setState(() {});
                        }
                      });

                  }
                  else{
                    FirebaseDB().addToFavourites(data[i].radioId).then((val) {
                        if(val){
                          myFavouriteChannelList.add(data[i].radioId);
                          setState(() {});
                        }
                    });
                  }
                }
                else{
                  Get.snackbar('Login to save this channel to favourite list', '');
                }
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
              child: myFavouriteChannelList.contains(data[i].radioId) ? const Icon(Icons.favorite) : const Icon(Icons.favorite_border),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 3.h),
            Hero(
              tag: data[i].radioId,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.sp),
                child: Neumorphic(
                  style: const NeumorphicStyle(
                      depth: 10,
                      intensity: 1,
                      shape: NeumorphicShape.concave,
                      boxShape: NeumorphicBoxShape.circle()
                  ),
                  child: Container(
                    height: 22.h,
                    margin: EdgeInsets.all(5.sp),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(imageUrl),
                            fit: BoxFit.fitHeight,
                            onError:(error, stackTrace) => const AssetImage('assets/not-load.jpg'),
                        )
                    ),
                  ),
                ),
              ),
            ),
            ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) => CustomGradient.secondaryGradient.createShader(
                  Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                ),
                child: SizedBox(
                    width: 95.w,
                    child: Center(child: Text(data[i].radioName, style: TextStyle(fontSize: 20.sp), overflow: TextOverflow.ellipsis))),
            ),
            SizedBox(height: 5.h),
            SizedBox(
              width: 95.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Country : '),
                  SizedBox(
                      width: 6.w,
                      child: Image.network(data[i].countryFlag)),
                  SizedBox(width: 1.w),
                  Flexible(child: Text(data[i].countryName, overflow: TextOverflow.ellipsis)),
                ],
              ),
            ),
            SizedBox(
                width: 95.w,
                child: Center(child: Text('State : ${data[i].state}', overflow: TextOverflow.ellipsis))),
            SizedBox(
                width: 95.w,
                child: Center(child: Text('Language : ${data[i].language}', overflow: TextOverflow.ellipsis))),
            SizedBox(
                width: 95.w,
                child: Center(child: Text('Genre : ${data[i].tags}', overflow: TextOverflow.ellipsis))),
            SizedBox(height: 12.h),
        Column(
          children: [
            seekBar(isMusicOn),
            SizedBox(height: 7.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  NeumorphicButton(
                    onPressed: (){
                      prevRadio();
                    },
                    style: const NeumorphicStyle(
                      depth: 10,
                      intensity: 1,
                      boxShape: NeumorphicBoxShape.circle(),
                    ),
                    child: SizedBox(
                      width: 5.h,
                      height: 5.h,
                      child: ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: (bounds) => CustomGradient.secondaryGradient.createShader(
                          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                        ),
                        child: Icon(Icons.skip_previous, size: 3.h),
                      ),
                    ),
                  ),
                  NeumorphicButton(
                    onPressed: (){
                      if(isMusicOn){
                        AudioController.stopAudio();
                        isMusicOn = false;
                        setState(() {});
                      }
                      else{
                        setState((){
                          isLoading = true;
                        });
                        AudioController.playAudio(data[i].radioUrl, data[i].radioId).then((value){
                          if(value){
                            isMusicOn = true;
                            AudioController.channelList = data;
                            AudioController.channelIndex =  i;
                          }
                          isLoading = false;
                          setState(() {});
                        });
                      }
                    },
                    style: const NeumorphicStyle(
                      depth: 10,
                      intensity: 1,
                      boxShape: NeumorphicBoxShape.circle(),
                    ),
                    child: SizedBox(
                      width: 8.5.h,
                      height: 8.5.h,
                      child: ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: (bounds) => CustomGradient.primaryGradient.createShader(
                          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                        ),
                        child: isLoading
                            ? Padding(
                          padding: EdgeInsets.all(2.h),
                          child: const CircularProgressIndicator(),
                        )
                            : isMusicOn
                            ? Icon(Icons.stop_outlined, size: 7.h)
                            :  Icon(Icons.play_arrow_outlined, size: 7.h),
                      ),
                    ),
                  ),
                  NeumorphicButton(
                    onPressed: (){
                      nextRadio();
                    },
                    style: const NeumorphicStyle(
                      depth: 10,
                      intensity: 1,
                      boxShape: NeumorphicBoxShape.circle(),
                    ),
                    child: SizedBox(
                      width: 5.h,
                      height: 5.h,
                      child: ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: (bounds) => CustomGradient.secondaryGradient.createShader(
                          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                        ),
                        child: Icon(Icons.skip_next, size: 3.h),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
            SizedBox(height : 5.h),
          ],
        ),
      ),
    );
  }
}


