class SubdistrictModel {
  int? subdistrictid;
  int? subdistrictcityid;
  String? subdistrictname;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;
  Subdistrictcity? subdistrictcity;
  Subdistrictcreatedby? subdistrictcreatedby;
  Subdistrictcreatedby? subdistrictupdatedby;

  SubdistrictModel(
      {this.subdistrictid,
      this.subdistrictcityid,
      this.subdistrictname,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive,
      this.subdistrictcity,
      this.subdistrictcreatedby,
      this.subdistrictupdatedby});

  SubdistrictModel.fromJson(Map<String, dynamic> json) {
    subdistrictid = json['subdistrictid'];
    subdistrictcityid = json['subdistrictcityid'];
    subdistrictname = json['subdistrictname'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
    subdistrictcity = json['subdistrictcity'] != null
        ? new Subdistrictcity.fromJson(json['subdistrictcity'])
        : null;
    subdistrictcreatedby = json['subdistrictcreatedby'] != null
        ? new Subdistrictcreatedby.fromJson(json['subdistrictcreatedby'])
        : null;
    subdistrictupdatedby = json['subdistrictupdatedby'] != null
        ? new Subdistrictcreatedby.fromJson(json['subdistrictupdatedby'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subdistrictid'] = this.subdistrictid;
    data['subdistrictcityid'] = this.subdistrictcityid;
    data['subdistrictname'] = this.subdistrictname;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    if (this.subdistrictcity != null) {
      data['subdistrictcity'] = this.subdistrictcity!.toJson();
    }
    if (this.subdistrictcreatedby != null) {
      data['subdistrictcreatedby'] = this.subdistrictcreatedby!.toJson();
    }
    if (this.subdistrictupdatedby != null) {
      data['subdistrictupdatedby'] = this.subdistrictupdatedby!.toJson();
    }
    return data;
  }
}

class Subdistrictcity {
  int? cityid;
  String? cityname;

  Subdistrictcity({this.cityid, this.cityname});

  Subdistrictcity.fromJson(Map<String, dynamic> json) {
    cityid = json['cityid'];
    cityname = json['cityname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cityid'] = this.cityid;
    data['cityname'] = this.cityname;
    return data;
  }
}

class Subdistrictcreatedby {
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

  Subdistrictcreatedby(
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

  Subdistrictcreatedby.fromJson(Map<String, dynamic> json) {
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
