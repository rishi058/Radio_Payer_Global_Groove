import 'dart:developer';
import 'package:dio/dio.dart';
import '../../models/quotes_model.dart';

class QuotesApi {
  Dio dio = Dio();

  Future<List<QuotesModel>> getRandomQuotes() async {
    List<QuotesModel> data = [];
    try {
      var response =
          await dio.get('https://api.quotable.io/quotes/random?limit=10');
      data = (response.data as List)
          .map((item) => QuotesModel.fromJson(item))
          .toList();
    } catch (e) {
      log(e.toString());
    }
    return data;
  }

}
