import '../../helpers/function.dart';

class ProvinceModel {
  int provid;
  String provname;
  int countryid;
  String countryname;

  ProvinceModel({
    this.provid = 0,
    this.provname = '',
    this.countryid = 0,
    this.countryname = '',
  });

  factory ProvinceModel.fromJson(Map<String, dynamic> json) {
    return ProvinceModel(
      provid: parseInt(json['provid']),
      provname: parseString(json['provname']),
      countryid: parseInt(json['provcountry']['countryid']),
      countryname: parseString(json['provcountry']['countryname']),
    );
  }
}
