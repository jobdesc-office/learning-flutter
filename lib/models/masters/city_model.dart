import '../../helpers/function.dart';

class CityModel {
  int cityid;
  String cityname;
  int provid;
  String provname;

  CityModel({
    this.cityid = 0,
    this.cityname = '',
    this.provid = 0,
    this.provname = '',
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      cityid: parseInt(json['cityid']),
      cityname: parseString(json['cityname']),
      provid: parseInt(json['cityprov']['provid']),
      provname: parseString(json['cityprov']['provname']),
    );
  }
}
