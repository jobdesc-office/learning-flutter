import '../../helpers/function.dart';

class ScheduleModel {
  int scheid;
  String schenm;
  String userfullname;
  String schestartdate;
  String scheenddate;
  String schedesc;
  String typename;
  String bpname;
  bool isactive;

  String jwtToken;

  ScheduleModel({
    this.scheid = 0,
    this.schenm = '',
    this.userfullname = '',
    this.schestartdate = '',
    this.scheenddate = '',
    this.schedesc = '',
    this.typename = '',
    this.bpname = '',
    this.isactive = true,
    this.jwtToken = '',
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      scheid: parseInt(json['scheid']),
      schenm: parseString(json['schenm']),
      userfullname: parseString(json['schetoward']['userfullname']),
      schestartdate: parseString(json['schestartdate']),
      scheenddate: parseString(json['scheenddate']),
      schedesc: parseString(json['schedesc']),
      typename: parseString(json['schetype']['typename']),
      bpname: parseString(json['schebp']['bpname']),
      isactive: parseBool(json['isactive']),
      jwtToken: parseString(json['jwt_token']),
    );
  }
}
