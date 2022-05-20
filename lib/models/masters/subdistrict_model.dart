import '../../helpers/function.dart';

class SubdistrictModel {
  int subdistrictid;
  String subdistrictname;
  int cityid;
  String cityname;

  SubdistrictModel({
    this.subdistrictid = 0,
    this.subdistrictname = '',
    this.cityid = 0,
    this.cityname = '',
  });

  factory SubdistrictModel.fromJson(Map<String, dynamic> json) {
    return SubdistrictModel(
      subdistrictid: parseInt(json['subdistrictid']),
      subdistrictname: parseString(json['subdistrictname']),
      cityid: parseInt(json['subdistrictcity']['cityid']),
      cityname: parseString(json['subdistrictcity']['cityname']),
    );
  }
}
