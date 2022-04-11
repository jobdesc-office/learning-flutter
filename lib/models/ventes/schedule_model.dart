import '../../helpers/function.dart';

class ScheduleModel {
  int scheid;
  int typeid;
  int bpid;
  int userid;
  String schenm;
  String userfullname;
  String schestartdate;
  String scheenddate;
  String scheactdate;
  String schestarttime;
  String scheendtime;
  String loc;
  String remind;
  String timezone;
  String schedesc;
  String link;
  String typename;
  String bpname;
  bool allday;
  bool online;
  bool private;
  bool isactive;

  String jwtToken;

  ScheduleModel({
    this.scheid = 0,
    this.typeid = 0,
    this.bpid = 0,
    this.userid = 0,
    this.schenm = '',
    this.userfullname = '',
    this.schestartdate = '',
    this.scheenddate = '',
    this.scheactdate = '',
    this.schestarttime = '',
    this.scheendtime = '',
    this.loc = '',
    this.remind = '',
    this.timezone = '',
    this.schedesc = '',
    this.link = '',
    this.typename = '',
    this.bpname = '',
    this.allday = false,
    this.online = false,
    this.private = false,
    this.isactive = true,
    this.jwtToken = '',
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      scheid: parseInt(json['scheid']),
      typeid: parseInt(json['schetype']['type']),
      bpid: parseInt(json['schebp']['bpid']),
      userid: parseInt(json['schetoward']['userid']),
      schenm: parseString(json['schenm']),
      userfullname: parseString(json['schetoward']['userfullname']),
      schestartdate: parseString(json['schestartdate']),
      scheenddate: parseString(json['scheenddate']),
      scheactdate: parseString(json['scheactdate']),
      schestarttime: parseString(json['schestarttime']),
      scheendtime: parseString(json['scheendtime']),
      loc: parseString(json['scheloc']),
      remind: parseString(json['scheremind']),
      timezone: parseString(json['schetz']),
      link: parseString(json['scheonlink']),
      schedesc: parseString(json['schedesc']),
      typename: parseString(json['schetype']['typename']),
      bpname: parseString(json['schebp']['bpname']),
      allday: parseBool(json['scheallday']),
      online: parseBool(json['scheonline']),
      private: parseBool(json['scheprivate']),
      isactive: parseBool(json['isactive']),
      jwtToken: parseString(json['jwt_token']),
    );
  }
}
