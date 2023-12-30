class CountryModel {
  String countryCode;
  String countryName;
  String countryFlag;
  String stationCount;

  CountryModel({
    required this.countryCode,
    required this.countryName,
    required this.countryFlag,
    required this.stationCount,
  });

  // Factory method to create a CountryModel instance from a JSON map
  factory CountryModel.fromJson(Map<String, dynamic> json) {
    String countryFlag = "https://images.squarespace-cdn.com/content/v1/5fa6b76b045ef433ae7b252e/1604765875569-MUAEJNXG2NL6E4VEORZ6/Flag_20x30.jpg?format=750w";
    if(json['iso_3166_1']!=null){
      countryFlag = "https://flagcdn.com/224x168/${json['iso_3166_1'].toString().toLowerCase()}.png";
    }
    return CountryModel(
      countryCode: json['iso_3166_1'] ?? "",
      countryName: json['name'] ?? "",
      stationCount: json['stationcount'].toString() ,
      countryFlag: countryFlag,
    );
  }
}
