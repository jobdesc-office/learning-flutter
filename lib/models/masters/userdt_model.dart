import '../../helpers/function.dart';

class UserDetailModel{

  String username;
  String userfullname;
  String useremail;
  String userphone;
  String typename;
  String bpname;
  bool isactive;

  String jwtToken;

  UserDetailModel({
    this.username = '',
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
      username: parseString(json['username']),
      userfullname: parseString(json['userfullname']),
      useremail: parseString(json['useremail']),
      userphone: parseString(json['userphone']),
      typename: parseString(json['typename']),
      bpname: parseString(json['bpname']),
      isactive: parseBool(json['isactive']),
      jwtToken: parseString(json['jwt_token']),
    );
  }
  
}