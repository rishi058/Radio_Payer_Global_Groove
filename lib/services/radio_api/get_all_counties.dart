import 'dart:developer';
import 'dart:math';

import 'package:global_groove/models/country_model.dart';
import 'package:global_groove/services/radio_api/dio_base.dart';


extension RadioApiExtension on RadioApi{
  Future<List<CountryModel>> getAllCountries(int page) async {
    List<CountryModel> data = [];
    var params = {
      'offset' : page*30,
      'limit' : '30',
      'hidebroken' : 'true',
    };

    try{
      var response = await dio.get('/countries', queryParameters: params);
      data = (response.data as List)
          .map((item) => CountryModel.fromJson(item))
          .toList();
    }
    catch(e){
      // log(e.toString());
    }

    return data;
  }

}