class AuthModel {
  int? userid;
  String? userfullname;
  String? username;
  String? useremail;
  String? userphone;
  String? password;
  List<Userdetails>? userdetails;
  String? jwtToken;

  AuthModel(
      {this.userid,
      this.userfullname,
      this.username,
      this.useremail,
      this.userphone,
      this.password,
      this.userdetails,
      this.jwtToken});

  AuthModel.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    userfullname = json['userfullname'];
    username = json['username'];
    useremail = json['useremail'];
    userphone = json['userphone'];
    password = json['password'];
    if (json['userdetails'] != null) {
      userdetails = <Userdetails>[];
      json['userdetails'].forEach((v) {
        userdetails!.add(new Userdetails.fromJson(v));
      });
    }
    jwtToken = json['jwt_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['userfullname'] = this.userfullname;
    data['username'] = this.username;
    data['useremail'] = this.useremail;
    data['userphone'] = this.userphone;
    if (this.userdetails != null) {
      data['userdetails'] = this.userdetails!.map((v) => v.toJson()).toList();
    }
    data['jwt_token'] = this.jwtToken;

    data['jwtToken'] = this.jwtToken;
    data['password'] = this.password;
    data['userdtbpid'] = userdetails!.first.businesspartner!.bpid;
    data['userId'] = this.userid;
    return data;
  }
}

class Userdetails {
  int? userdtid;
  Usertype? usertype;
  Businesspartner? businesspartner;

  Userdetails({this.userdtid, this.usertype, this.businesspartner});

  Userdetails.fromJson(Map<String, dynamic> json) {
    userdtid = json['userdtid'];
    usertype = json['usertype'] != null
        ? new Usertype.fromJson(json['usertype'])
        : null;
    businesspartner = json['businesspartner'] != null
        ? new Businesspartner.fromJson(json['businesspartner'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userdtid'] = this.userdtid;
    if (this.usertype != null) {
      data['usertype'] = this.usertype!.toJson();
    }
    if (this.businesspartner != null) {
      data['businesspartner'] = this.businesspartner!.toJson();
    }
    return data;
  }
}

class Usertype {
  int? typeid;
  String? typename;
  String? typecd;

  Usertype({this.typeid, this.typename, this.typecd});

  Usertype.fromJson(Map<String, dynamic> json) {
    typeid = json['typeid'];
    typename = json['typename'];
    typecd = json['typecd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['typeid'] = this.typeid;
    data['typename'] = this.typename;
    data['typecd'] = this.typecd;
    return data;
  }
}

class Businesspartner {
  int? bpid;
  String? bpname;

  Businesspartner({this.bpid, this.bpname});

  Businesspartner.fromJson(Map<String, dynamic> json) {
    bpid = json['bpid'];
    bpname = json['bpname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bpid'] = this.bpid;
    data['bpname'] = this.bpname;
    return data;
  }
}
