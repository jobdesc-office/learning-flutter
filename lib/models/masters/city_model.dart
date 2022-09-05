class CityModel {
  int? cityid;
  int? cityprovid;
  String? cityname;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;
  Cityprov? cityprov;
  Citycreatedby? citycreatedby;
  Citycreatedby? cityupdatedby;

  CityModel(
      {this.cityid,
      this.cityprovid,
      this.cityname,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive,
      this.cityprov,
      this.citycreatedby,
      this.cityupdatedby});

  CityModel.fromJson(Map<String, dynamic> json) {
    cityid = json['cityid'];
    cityprovid = json['cityprovid'];
    cityname = json['cityname'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
    cityprov = json['cityprov'] != null
        ? new Cityprov.fromJson(json['cityprov'])
        : null;
    citycreatedby = json['citycreatedby'] != null
        ? new Citycreatedby.fromJson(json['citycreatedby'])
        : null;
    cityupdatedby = json['cityupdatedby'] != null
        ? new Citycreatedby.fromJson(json['cityupdatedby'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cityid'] = this.cityid;
    data['cityprovid'] = this.cityprovid;
    data['cityname'] = this.cityname;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    if (this.cityprov != null) {
      data['cityprov'] = this.cityprov!.toJson();
    }
    if (this.citycreatedby != null) {
      data['citycreatedby'] = this.citycreatedby!.toJson();
    }
    if (this.cityupdatedby != null) {
      data['cityupdatedby'] = this.cityupdatedby!.toJson();
    }
    return data;
  }
}

class Cityprov {
  int? provid;
  String? provname;

  Cityprov({this.provid, this.provname});

  Cityprov.fromJson(Map<String, dynamic> json) {
    provid = json['provid'];
    provname = json['provname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['provid'] = this.provid;
    data['provname'] = this.provname;
    return data;
  }
}

class Citycreatedby {
  int? userid;
  String? username;
  String? userpassword;
  String? userfullname;
  String? useremail;
  String? userphone;
  String? userdeviceid;
  String? userfcmtoken;
  String? usersocketid;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;

  Citycreatedby(
      {this.userid,
      this.username,
      this.userpassword,
      this.userfullname,
      this.useremail,
      this.userphone,
      this.userdeviceid,
      this.userfcmtoken,
      this.usersocketid,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive});

  Citycreatedby.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    username = json['username'];
    userpassword = json['userpassword'];
    userfullname = json['userfullname'];
    useremail = json['useremail'];
    userphone = json['userphone'];
    userdeviceid = json['userdeviceid'];
    userfcmtoken = json['userfcmtoken'];
    usersocketid = json['usersocketid'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['username'] = this.username;
    data['userpassword'] = this.userpassword;
    data['userfullname'] = this.userfullname;
    data['useremail'] = this.useremail;
    data['userphone'] = this.userphone;
    data['userdeviceid'] = this.userdeviceid;
    data['userfcmtoken'] = this.userfcmtoken;
    data['usersocketid'] = this.usersocketid;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    return data;
  }
}
