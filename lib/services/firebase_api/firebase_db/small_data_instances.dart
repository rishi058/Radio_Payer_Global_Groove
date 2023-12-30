import 'package:global_groove/services/firebase_api/firebase_db/custom_channels.dart';
import 'package:global_groove/services/firebase_api/firebase_db/favourite_channels.dart';
import 'package:global_groove/services/local_storage/get_storage_helper.dart';
import '../../../models/radio_model.dart';
import 'firebase_database.dart';

List<RadioChannel> myCustomChannelList = [];
List<String> myFavouriteChannelList = [];


Future<void> loadFirebaseDBToCache() async {
    if(LocalStorage().isLoggedIn()){
      await FirebaseDB().geFavouritesChannel().then((value) {
        myFavouriteChannelList = value;
      });

      await FirebaseDB().getCustomChannels().then((value) {
        myCustomChannelList = value;
      });
    }
}