import 'package:flutter/foundation.dart';

class RadioChannel {
  String radioId;
  String radioName;
  String radioImage;
  String radioUrl;
  String urlResolved;
  String tags;
  String countryCode;
  String countryName;
  String countryFlag;
  String language;
  String state;


  RadioChannel({
    required this.radioId,
    required this.radioName,
    required this.radioImage,
    required this.radioUrl,
    required this.urlResolved,
    required this.tags,
    required this.countryCode,
    required this.countryName,
    required this.countryFlag,
    required this.language,
    required this.state,
  });

  // Factory method to create an instance of RadioData from a JSON map
  factory RadioChannel.fromJson(Map<String, dynamic> json) {
    String countryCODE = json['countrycode'] ?? "";
    String countryIcon = "https://flagcdn.com/224x168/${countryCODE.toLowerCase()}.png";
    String channelIcon = json['favicon'] ?? "";

    if(countryCODE.isEmpty){
      countryIcon = "https://images.squarespace-cdn.com/content/v1/5fa6b76b045ef433ae7b252e/1604765875569-MUAEJNXG2NL6E4VEORZ6/Flag_20x30.jpg?format=750w";
    }

    if(channelIcon.isEmpty){
      channelIcon = countryIcon;
    }

    return RadioChannel(
      radioId: json['stationuuid'] ?? "",
      radioName: json['name'] ?? "",
      radioImage: channelIcon,
      radioUrl: json['url'] ?? "",
      urlResolved: json['url_resolved'],
      tags: json['tags'] ?? "",
      countryCode: json['countrycode'] ?? "",
      countryName: json['country'] ?? "",
      countryFlag: countryIcon,
      language: json['language'] ?? "",
      state: json['state'] ?? ""
    );
  }

  void log() {
    if(kDebugMode){
      print('RadioChannel Information:');
      print('Radio ID: $radioId');
      print('Radio Name: $radioName');
      print('Radio Image: $radioImage');
      print('Radio URL: $radioUrl');
      print('Resolved URL: $urlResolved');
      print('Tags: $tags');
      print('Country Code: $countryCode');
      print('Country Name: $countryName');
      print('Country Flag: $countryFlag');
      print('Language: $language');
      print('State: $state');
    }
  }


}