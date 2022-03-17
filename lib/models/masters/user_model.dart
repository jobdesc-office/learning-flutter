import '../../helpers/function.dart';

class UserModel {
  int userid;
  String userfullname;

  String jwtToken;

  UserModel({
    this.userid = 0,
    this.userfullname = '',
    this.jwtToken = '',
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userid: parseInt(json['userid']),
      userfullname: parseString(json['userfullname']),
      jwtToken: parseString(json['jwt_token']),
    );
  }
}
