class ProvinceModel {
  int? provid;
  int? provcountryid;
  String? provname;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;
  Provcountry? provcountry;
  Provincecreatedby? provincecreatedby;
  Provincecreatedby? provinceupdatedby;

  ProvinceModel(
      {this.provid,
      this.provcountryid,
      this.provname,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive,
      this.provcountry,
      this.provincecreatedby,
      this.provinceupdatedby});

  ProvinceModel.fromJson(Map<String, dynamic> json) {
    provid = json['provid'];
    provcountryid = json['provcountryid'];
    provname = json['provname'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
    provcountry = json['provcountry'] != null
        ? new Provcountry.fromJson(json['provcountry'])
        : null;
    provincecreatedby = json['provincecreatedby'] != null
        ? new Provincecreatedby.fromJson(json['provincecreatedby'])
        : null;
    provinceupdatedby = json['provinceupdatedby'] != null
        ? new Provincecreatedby.fromJson(json['provinceupdatedby'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['provid'] = this.provid;
    data['provcountryid'] = this.provcountryid;
    data['provname'] = this.provname;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    if (this.provcountry != null) {
      data['provcountry'] = this.provcountry!.toJson();
    }
    if (this.provincecreatedby != null) {
      data['provincecreatedby'] = this.provincecreatedby!.toJson();
    }
    if (this.provinceupdatedby != null) {
      data['provinceupdatedby'] = this.provinceupdatedby!.toJson();
    }
    return data;
  }
}

class Provcountry {
  int? countryid;
  String? countryname;

  Provcountry({this.countryid, this.countryname});

  Provcountry.fromJson(Map<String, dynamic> json) {
    countryid = json['countryid'];
    countryname = json['countryname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countryid'] = this.countryid;
    data['countryname'] = this.countryname;
    return data;
  }
}

class Provincecreatedby {
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

  Provincecreatedby(
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

  Provincecreatedby.fromJson(Map<String, dynamic> json) {
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
