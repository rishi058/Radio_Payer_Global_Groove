import 'dart:developer';
import 'package:global_groove/models/radio_model.dart';
import 'package:global_groove/services/radio_api/dio_base.dart';

extension RadioApiExtension on RadioApi{

  static var params = {
    'hidebroken' : 'true',
    'limit' : '50',
  };

  Future<List<RadioChannel>> getRadiosByName(String keyword) async {
    List<RadioChannel> data = [];
    try{
      var response = await dio.get('/stations/byname/$keyword', queryParameters: params);
      data = (response.data as List)
          .map((item) => RadioChannel.fromJson(item))
          .toList();
    }
    catch(e){
      log(e.toString());
    }
    return data;
  }

  Future<List<RadioChannel>> getRadiosByCountry(String keyword) async {
    List<RadioChannel> data = [];

    try{
      var response = await dio.get('/stations/bycountry/$keyword', queryParameters: params);
      data = (response.data as List)
          .map((item) => RadioChannel.fromJson(item))
          .toList();
    }
    catch(e){
      log(e.toString());
    }
    return data;
  }

  Future<List<RadioChannel>> getRadiosByState(String keyword) async {
    List<RadioChannel> data = [];

    try{
      var response = await dio.get('/stations/bystate/$keyword', queryParameters: params);
      data = (response.data as List)
          .map((item) => RadioChannel.fromJson(item))
          .toList();
    }
    catch(e){
      log(e.toString());
    }
    return data;
  }

  Future<List<RadioChannel>> getRadiosByLanguage(String keyword) async {
    List<RadioChannel> data = [];

    try{
      var response = await dio.get('/stations/bylanguage/$keyword', queryParameters: params);
      data = (response.data as List)
          .map((item) => RadioChannel.fromJson(item))
          .toList();
    }
    catch(e){
      log(e.toString());
    }
    return data;
  }

  Future<List<RadioChannel>> getRadiosByGenre(String keyword) async {
    List<RadioChannel> data = [];

    try{
      var response = await dio.get('/stations/bytag/$keyword', queryParameters: params);
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