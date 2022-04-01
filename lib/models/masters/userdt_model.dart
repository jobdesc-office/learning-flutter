import '../../helpers/function.dart';

class UserDetailModel {
  int userid;
  String username;
  String userpassword;
  String userfullname;
  String useremail;
  String userphone;
  String typename;
  String bpname;
  bool isactive;

  String jwtToken;

  UserDetailModel({
    this.userid = 0,
    this.username = '',
    this.userpassword = '',
    this.userfullname = '',
    this.useremail = '',
    this.userphone = '',
    this.typename = '',
    this.bpname = '',
    this.isactive = true,
    this.jwtToken = '',
  });

  factory UserDetailModel.fromJson(Map<String, dynamic> json) {
    return UserDetailModel(
      userid: parseInt(json['user']['userid']),
      username: parseString(json['user']['username']),
      userpassword: parseString(json['user']['userpassword']),
      userfullname: parseString(json['user']['userfullname']),
      useremail: parseString(json['user']['useremail']),
      userphone: parseString(json['user']['userphone']),
      typename: parseString(json['usertype']['typename']),
      bpname: parseString(json['businesspartner']['bpname']),
      isactive: parseBool(json['isactive']),
      jwtToken: parseString(json['jwt_token']),
    );
  }
}
