import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'firebase_database.dart';

extension Favourites on FirebaseDB{

  Future<List<String>> geFavouritesChannel() async {
    List<String> data = [];
    try{
      DocumentSnapshot docSnap = await userCollection.doc(userId).get();
      if(docSnap.exists){
        Map<String,dynamic> temp = docSnap.data() as Map<String,dynamic>;

        if(temp.containsKey('favourites')){
          data = List<String>.from(temp['favourites']);
        }
      }
    }
    catch(e){
      Get.snackbar("Error", e.toString());
      log(e.toString());
    }
    return data;
  }


  Future<bool> addToFavourites(String radioId) async {
    try {
      final userDoc = await userCollection.doc(userId).get();

      if (!userDoc.exists) {
        // User document doesn't exist, create it
        await userCollection.doc(userId).set({
          'favourites': [radioId],
        }).then((_) {
          Get.snackbar("Radio Added to favourites", "");
        });
      } else {
        // User document exists, check and update 'favourites'
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

        if (userData.containsKey('favourites')) {
          await userCollection.doc(userId).update({
            'favourites': FieldValue.arrayUnion([radioId]),
          }).then((_) {
            Get.snackbar("Radio Added to favourite", "");
          });
        } else {
          await userCollection.doc(userId).update({
            'favourites': [radioId],
          }).then((_) {
            Get.snackbar("Radio Added to favourite", "");
          });
        }
      }
      return true;
    } catch (e) {
      Get.snackbar("Error", e.toString());
      log(e.toString());
    }
    return false;
  }

  Future<bool> removeFromFavourites(String radioId) async {
    try{
      await userCollection.doc(userId).update({
        'favourites' : FieldValue.arrayRemove([radioId]),
      }).then((_){
        Get.snackbar("Radio Removed from favourite", "");
      });
      return true;
    }
    catch(e){
      Get.snackbar("Error", e.toString());
      log(e.toString());
    }
    return false;
  }

}