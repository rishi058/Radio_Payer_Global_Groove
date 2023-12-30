import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:global_groove/models/radio_model.dart';

import 'firebase_database.dart';

extension CustomChannels on FirebaseDB {
  static String radioImgUrl = "https://w7.pngwing.com/pngs/122/303/png-transparent-internet-radio-fm-broadcasting-south-korea-radio-station-radio-electronics-fm-broadcasting-radio-station-thumbnail.png";

  static String countryFlag =
      "https://images.squarespace-cdn.com/content/v1/5fa6b76b045ef433ae7b252e/1604765875569-MUAEJNXG2NL6E4VEORZ6/Flag_20x30.jpg?format=750w";

  Future<List<RadioChannel>> getCustomChannels() async {
    List<RadioChannel> data = [];
    try {
      List<String> radioIdList = [];
      DocumentSnapshot docSnap = await userCollection.doc(userId).get();

      if(docSnap.exists==false){return [];}

      Map<String, dynamic> temp = docSnap.data() as Map<String, dynamic>;

      if (temp.containsKey('custom_radios')) {
        radioIdList = List<String>.from(temp['custom_radios']);
      }

      for (int i = 0; i < radioIdList.length; i++) {
          DocumentSnapshot snap = await customRadioCollection.doc(radioIdList[i]).get();
          Map<String, dynamic> temp = snap.data() as Map<String, dynamic>;
          data.add(RadioChannel(
              radioId: temp['channel_id'] ?? "",
              radioName: temp['channel_name'] ?? "",
              radioImage: radioImgUrl,
              radioUrl: temp['channel_url'] ?? "",
              urlResolved: temp['channel_url'] ?? "",
              tags: 'Custom Channel',
              countryCode: '',
              countryName: '',
              countryFlag: countryFlag,
              language: '',
              state: ''
          ));
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      log(e.toString());
    }
    return data;
  }

  Future<void> addChannel({required String channelName, required String streamUrl}) async {
    try {
      final DocumentReference docRef = await customRadioCollection.add({
        'channel_name': channelName,
        'channel_url': streamUrl,
      });

      await customRadioCollection.doc(docRef.id).update({
        'channel_id': docRef.id,
      });

      final userDoc = await userCollection.doc(userId).get();

      if(!userDoc.exists){
        await userCollection.doc(userId).set({
          'custom_radios': [docRef.id],
        }).then((_) {
          Get.snackbar("Added a New Custom Channel", "");
        });
      }
      else{
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        if (userData.containsKey('custom_radios')) {
          await userCollection.doc(userId).update({
            'custom_radios': FieldValue.arrayUnion([docRef.id]),
          }).then((_) {
            Get.snackbar("Added a New Custom Channel", "");
          });
        } else {
          await userCollection.doc(userId).update({
            'custom_radios': [docRef.id],
          }).then((_) {
            Get.snackbar("Added a New Custom Channel", "");
          });
        }
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      log(e.toString());
    }
  }

  Future<void> deleteChannel(String customChannelId) async {
    try {
      await userCollection.doc(userId).update({
        'custom_radios': FieldValue.arrayRemove([customChannelId]),
      });

      await customRadioCollection.doc(customChannelId).delete();
    } catch (e) {
      Get.snackbar("Error", e.toString());
      log(e.toString());
    }
  }
}
