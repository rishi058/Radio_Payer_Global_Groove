import 'package:global_groove/models/country_model.dart';
import '../models/radio_model.dart';

class HomePageData {
  List<RadioChannel> featured;
  List<RadioChannel> topVoted;
  List<CountryModel> topCountries;

  HomePageData(
      {required this.featured,
        required this.topVoted,
        required this.topCountries});
}
