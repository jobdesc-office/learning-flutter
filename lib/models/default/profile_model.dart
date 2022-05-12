import '../../helpers/function.dart';

class ProfileModel {
  int scheid;
  String schenm;
  String schestartdate;
  String schestarttime;

  ProfileModel({
    this.scheid = 0,
    this.schenm = '',
    this.schestartdate = '',
    this.schestarttime = '',
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      scheid: parseInt(json['scheid']),
      schenm: parseString(json['schenm']),
      schestartdate: parseString(json['schestartdate']),
      schestarttime: parseString(json['schestarttime']),
    );
  }
}
