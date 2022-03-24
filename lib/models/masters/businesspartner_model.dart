import '../../helpers/function.dart';
import 'type_model.dart';

class BusinessPartnerModel {
  int bpid;
  String bpname;
  String bptypeid;
  String bppicname;
  String bpemail;
  String bpphone;
  bool isactive;
  Map<String, dynamic>? _bptype;


  String jwtToken;

  BusinessPartnerModel({
    this.bpid = 0,
    this.bpname = '',
    this.bptypeid = '',
    this.bppicname = '',
    this.bpemail = '',
    this.bpphone = '',
    this.isactive = true,
    this.jwtToken = '',
    Map<String, dynamic>? bptype,
  }) : _bptype = bptype;

  factory BusinessPartnerModel.fromJson(Map<String, dynamic> json) {
    return BusinessPartnerModel(
      bpid: parseInt(json['bpid']),
      bpname: parseString(json['bpname']),
      bptypeid: parseString(json['bptypeid']),
      bppicname: parseString(json['bppicname']),
      bpemail: parseString(json['bpemail']),
      bpphone: parseString(json['bpphone']),
      isactive: parseBool(json['isactive']),
      jwtToken: parseString(json['jwt_token']),
      bptype: json['bptype'],
    );
  }

  TypeModel get bptype {
    if (_bptype == null) return TypeModel();

    return TypeModel.fromJson(_bptype!);
  }

}
