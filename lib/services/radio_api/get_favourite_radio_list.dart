import 'dart:async';
import 'dart:developer';
import 'package:global_groove/models/radio_model.dart';
import 'package:global_groove/services/radio_api/dio_base.dart';

extension RadioApiExtension on RadioApi {
  Future<List<RadioChannel>> getFavouriteRadioList(List<String> radioList) async {
    List<RadioChannel> data = [];

    try{
      for(int i=0; i<radioList.length; i++){
          var response = await dio.get('/stations/byuuid/${radioList[i]}');
          data.add((response.data as List)
              .map((item) => RadioChannel.fromJson(item))
              .toList()[0]);
      }
    }
    catch(e){
      log(e.toString());
    }

    return data;
  }


}
