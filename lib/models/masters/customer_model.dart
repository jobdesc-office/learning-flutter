import '../../helpers/function.dart';

class CustomerModel {
  int cstmid;
  String cstmprefix;
  String cstmname;
  String cstmphone;
  String cstmaddress;
  String cstmpostalcode;
  String typename;
  String provname;
  String cityname;
  String subdistrictname;
  int cstmtypeid;
  int cstmprovinceid;
  int cstmcityid;
  int cstmsubdistrictid;
  int cstmuvid;
  double cstmlatitude;
  double cstmlongitude;
  String referalcode;
  bool isactive;

  String jwtToken;

  CustomerModel({
    this.cstmid = 0,
    this.cstmprefix = '',
    this.cstmname = '',
    this.cstmphone = '',
    this.cstmaddress = '',
    this.cstmpostalcode = '',
    this.typename = '',
    this.provname = '',
    this.cityname = '',
    this.subdistrictname = '',
    this.cstmtypeid = 0,
    this.cstmprovinceid = 0,
    this.cstmcityid = 0,
    this.cstmsubdistrictid = 0,
    this.cstmuvid = 0,
    this.cstmlatitude = 0.0,
    this.cstmlongitude = 0.0,
    this.referalcode = '',
    this.isactive = true,
    this.jwtToken = '',
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      cstmid: parseInt(json['cstmid']),
      cstmprefix: parseString(json['cstmprefix']),
      cstmname: parseString(json['cstmname']),
      cstmphone: parseString(json['cstmphone']),
      cstmaddress: parseString(json['cstmaddress']),
      cstmpostalcode: parseString(json['cstmpostalcode']),
      typename: parseString(json['cstmtype']['typename']),
      provname: parseString(json['cstmprovince']['provname']),
      cityname: parseString(json['cstmcity']['cityname']),
      subdistrictname: parseString(json['cstmsubdistrict']['subdistrictname']),
      cstmtypeid: parseInt(json['cstmtypeid']),
      cstmprovinceid: parseInt(json['cstmprovinceid']),
      cstmcityid: parseInt(json['cstmcityid']),
      cstmsubdistrictid: parseInt(json['cstmsubdistrictid']),
      cstmuvid: parseInt(json['cstmuvid']),
      referalcode: parseString(json['referalcode']),
      isactive: parseBool(json['isactive']),
      jwtToken: parseString(json['jwt_token']),
    );
  }
}
