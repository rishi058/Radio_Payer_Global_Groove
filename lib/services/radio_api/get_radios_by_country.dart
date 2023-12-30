import 'dart:developer';
import 'package:global_groove/models/radio_model.dart';
import 'package:global_groove/services/radio_api/dio_base.dart';

extension RadioApiExtension on RadioApi{
  Future<List<RadioChannel>> getCountryRadios(int page, String countryCode) async {
    List<RadioChannel> data = [];

    var params = {
      'offset' : page,
      'limit' : '25',
      'hidebroken' : 'true',
    };

    try{
      var response = await dio.get('/stations/bycountrycodeexact/$countryCode', queryParameters: params);
      data = (response.data as List)
          .map((item) => RadioChannel.fromJson(item))
          .toList();
    }
    catch(e){
      log(e.toString());
    }

    return data;
  }
}