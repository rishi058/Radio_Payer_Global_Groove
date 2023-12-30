import 'dart:developer';
import 'package:global_groove/models/country_model.dart';
import 'package:global_groove/models/home_page_model.dart';
import 'package:global_groove/models/radio_model.dart';
import 'package:global_groove/services/radio_api/dio_base.dart';

extension RadioApiExtension on RadioApi{
  Future<HomePageData> getHomePage() async {
    List<RadioChannel> featured = [];
    List<RadioChannel> topVoted = [];
    List<CountryModel> topCountries = [];

    HomePageData data = HomePageData(featured: featured, topVoted: topVoted, topCountries: topCountries);

    try{
      var params = {
        'limit' : '30',
        'hidebroken' : 'true',
      };

      var response = await dio.get('/stations/topvote', queryParameters: params);

      data.topVoted = (response.data as List)
          .map((item) => RadioChannel.fromJson(item))
          .toList();

      response = await dio.get('/stations/lastclick', queryParameters: params);

      data.featured = (response.data as List)
          .map((item) => RadioChannel.fromJson(item))
          .toList();

      params = {
        'limit' : '30',
        'hidebroken' : 'true',
        'order' : 'stationcount',
        'reverse': 'true'
      };

      response = await dio.get('/countries', queryParameters: params);
      data.topCountries = (response.data as List)
          .map((item) => CountryModel.fromJson(item))
          .toList();

    }
    catch(e){
      log(e.toString());
    }

    return data;
  }
}
