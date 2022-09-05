class VillageModel {
  int? villageid;
  int? villagesubdistrictid;
  String? villagename;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;
  Villagesubdistrict? villagesubdistrict;
  Villagecreatedby? villagecreatedby;
  Villagecreatedby? villageupdatedby;

  VillageModel(
      {this.villageid,
      this.villagesubdistrictid,
      this.villagename,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive,
      this.villagesubdistrict,
      this.villagecreatedby,
      this.villageupdatedby});

  VillageModel.fromJson(Map<String, dynamic> json) {
    villageid = json['villageid'];
    villagesubdistrictid = json['villagesubdistrictid'];
    villagename = json['villagename'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
    villagesubdistrict = json['villagesubdistrict'] != null
        ? new Villagesubdistrict.fromJson(json['villagesubdistrict'])
        : null;
    villagecreatedby = json['villagecreatedby'] != null
        ? new Villagecreatedby.fromJson(json['villagecreatedby'])
        : null;
    villageupdatedby = json['villageupdatedby'] != null
        ? new Villagecreatedby.fromJson(json['villageupdatedby'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['villageid'] = this.villageid;
    data['villagesubdistrictid'] = this.villagesubdistrictid;
    data['villagename'] = this.villagename;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    if (this.villagesubdistrict != null) {
      data['villagesubdistrict'] = this.villagesubdistrict!.toJson();
    }
    if (this.villagecreatedby != null) {
      data['villagecreatedby'] = this.villagecreatedby!.toJson();
    }
    if (this.villageupdatedby != null) {
      data['villageupdatedby'] = this.villageupdatedby!.toJson();
    }
    return data;
  }
}

class Villagesubdistrict {
  int? subdistrictid;
  String? subdistrictname;

  Villagesubdistrict({this.subdistrictid, this.subdistrictname});

  Villagesubdistrict.fromJson(Map<String, dynamic> json) {
    subdistrictid = json['subdistrictid'];
    subdistrictname = json['subdistrictname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subdistrictid'] = this.subdistrictid;
    data['subdistrictname'] = this.subdistrictname;
    return data;
  }
}

class Villagecreatedby {
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

  Villagecreatedby(
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

  Villagecreatedby.fromJson(Map<String, dynamic> json) {
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
