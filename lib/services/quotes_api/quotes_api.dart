import 'dart:developer';
import 'package:dio/dio.dart';
import '../../models/quotes_model.dart';

class QuotesApi {
  Dio dio = Dio();

  Future<List<QuotesModel>> getRandomQuotes() async {
    List<QuotesModel> data = [];
    try {
      var response = await dio.get('https://api.quotable.io/quotes/random?limit=10');

      // If the response is a list (as expected from /quotes/random), parse directly
      if (response.statusCode == 200 && response.data is List) {
        data = (response.data as List)
            .map((item) => QuotesModel.fromJson(item))
            .toList();
      } else {
        log('Unexpected response format: ${response.data}');
      }

    } catch (e) {
      log('Error fetching quotes: $e');
    }
    return data;
  }
}