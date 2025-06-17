import 'package:get/get.dart';
import 'package:global_groove/models/radio_model.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:developer';



/// for updating UI of miniPlayer
class RadioIdController extends GetxController{
  RxString globalRadioId = "".obs ;

  void setValue(String id){
    globalRadioId.value = id;
  }

  String getValue(){
    return globalRadioId.value;
  }
}


/// for Dependency of Current Audio Properties
class AudioController {    //

  static AudioPlayer audioPlayer = AudioPlayer();
  static DateTime? audioStartTime;
  static bool isPlaying = false;
  static List<RadioChannel> channelList = [];
  static int channelIndex = 0;


  static Future<bool> playAudio(String url, String id) async {
    if (isPlaying) {
      stopAudio();
    }

    bool error = false;

    try {

      await audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(url))).then((_) {
        audioPlayer.play().onError((e, stackTrace) {
          Get.snackbar("Player Error", "");
          error = true;
        });
      });

    }

    catch (e) {

      Get.snackbar("Channel Fetch Error", "");
      log('Error Fetching audio: $e');
      return false;

    }

    if(error){
      return false;
    }

    RadioIdController ctrl = Get.find();
    ctrl.setValue(id);

    audioStartTime = DateTime.now();
    isPlaying = true;
    return true;
  }

  static void stopAudio() {
    if (isPlaying) {
      audioPlayer.stop();
    }
    RadioIdController ctrl = Get.find();
    ctrl.setValue("");
    audioStartTime = null;
    isPlaying = false;
  }

}


