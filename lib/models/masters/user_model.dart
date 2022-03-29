import '../../helpers/function.dart';

class UserModel {
  int userid;
  String username;
  String userpassword;
  String userfullname;
  String useremail;
  String userphone;
  bool isactive;

  String jwtToken;

  UserModel({
    this.userid = 0,
    this.username = '',
    this.userpassword = '',
    this.userfullname = '',
    this.useremail = '',
    this.userphone = '',
    this.isactive = true,
    this.jwtToken = '',
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userid: parseInt(json['userid']),
      username: parseString(json['username']),
      userpassword: parseString(json['userpassword']),
      userfullname: parseString(json['userfullname']),
      useremail: parseString(json['useremail']),
      userphone: parseString(json['userphone']),
      isactive: parseBool(json['isactive']),
      jwtToken: parseString(json['jwt_token']),
    );
  }
}
