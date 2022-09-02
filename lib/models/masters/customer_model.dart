class CustomerModel {
  int? cstmid;
  String? cstmprefix;
  String? cstmname;
  String? cstmphone;
  String? cstmaddress;
  int? cstmtypeid;
  int? cstmprovinceid;
  int? cstmcityid;
  int? cstmsubdistrictid;
  int? cstmuvid;
  String? cstmpostalcode;
  String? cstmlatitude;
  String? cstmlongitude;
  String? referalcode;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;
  Custcreatedby? custcreatedby;
  Custcreatedby? custupdatedby;
  Cstmtype? cstmtype;
  Cstmprovince? cstmprovince;
  Cstmcity? cstmcity;
  Cstmsubdistrict? cstmsubdistrict;
  Cstmvillage? cstmvillage;

  CustomerModel(
      {this.cstmid,
      this.cstmprefix,
      this.cstmname,
      this.cstmphone,
      this.cstmaddress,
      this.cstmtypeid,
      this.cstmprovinceid,
      this.cstmcityid,
      this.cstmsubdistrictid,
      this.cstmuvid,
      this.cstmpostalcode,
      this.cstmlatitude,
      this.cstmlongitude,
      this.referalcode,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive,
      this.custcreatedby,
      this.custupdatedby,
      this.cstmtype,
      this.cstmprovince,
      this.cstmcity,
      this.cstmsubdistrict,
      this.cstmvillage});

  CustomerModel.fromJson(Map<String, dynamic> json) {
    cstmid = json['cstmid'];
    cstmprefix = json['cstmprefix'];
    cstmname = json['cstmname'];
    cstmphone = json['cstmphone'];
    cstmaddress = json['cstmaddress'];
    cstmtypeid = json['cstmtypeid'];
    cstmprovinceid = json['cstmprovinceid'];
    cstmcityid = json['cstmcityid'];
    cstmsubdistrictid = json['cstmsubdistrictid'];
    cstmuvid = json['cstmuvid'];
    cstmpostalcode = json['cstmpostalcode'];
    cstmlatitude = json['cstmlatitude'];
    cstmlongitude = json['cstmlongitude'];
    referalcode = json['referalcode'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
    custcreatedby = json['custcreatedby'] != null
        ? new Custcreatedby.fromJson(json['custcreatedby'])
        : null;
    custupdatedby = json['custupdatedby'] != null
        ? new Custcreatedby.fromJson(json['custupdatedby'])
        : null;
    cstmtype = json['cstmtype'] != null
        ? new Cstmtype.fromJson(json['cstmtype'])
        : null;
    cstmprovince = json['cstmprovince'] != null
        ? new Cstmprovince.fromJson(json['cstmprovince'])
        : null;
    cstmcity = json['cstmcity'] != null
        ? new Cstmcity.fromJson(json['cstmcity'])
        : null;
    cstmsubdistrict = json['cstmsubdistrict'] != null
        ? new Cstmsubdistrict.fromJson(json['cstmsubdistrict'])
        : null;
    cstmvillage = json['cstmvillage'] != null
        ? new Cstmvillage.fromJson(json['cstmvillage'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cstmid'] = this.cstmid;
    data['cstmprefix'] = this.cstmprefix;
    data['cstmname'] = this.cstmname;
    data['cstmphone'] = this.cstmphone;
    data['cstmaddress'] = this.cstmaddress;
    data['cstmtypeid'] = this.cstmtypeid;
    data['cstmprovinceid'] = this.cstmprovinceid;
    data['cstmcityid'] = this.cstmcityid;
    data['cstmsubdistrictid'] = this.cstmsubdistrictid;
    data['cstmuvid'] = this.cstmuvid;
    data['cstmpostalcode'] = this.cstmpostalcode;
    data['cstmlatitude'] = this.cstmlatitude;
    data['cstmlongitude'] = this.cstmlongitude;
    data['referalcode'] = this.referalcode;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    if (this.custcreatedby != null) {
      data['custcreatedby'] = this.custcreatedby!.toJson();
    }
    if (this.custupdatedby != null) {
      data['custupdatedby'] = this.custupdatedby!.toJson();
    }
    if (this.cstmtype != null) {
      data['cstmtype'] = this.cstmtype!.toJson();
    }
    if (this.cstmprovince != null) {
      data['cstmprovince'] = this.cstmprovince!.toJson();
    }
    if (this.cstmcity != null) {
      data['cstmcity'] = this.cstmcity!.toJson();
    }
    if (this.cstmsubdistrict != null) {
      data['cstmsubdistrict'] = this.cstmsubdistrict!.toJson();
    }
    if (this.cstmvillage != null) {
      data['cstmvillage'] = this.cstmvillage!.toJson();
    }
    return data;
  }
}

class Custcreatedby {
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

  Custcreatedby(
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

  Custcreatedby.fromJson(Map<String, dynamic> json) {
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

class Cstmtype {
  int? typeid;
  String? typename;

  Cstmtype({this.typeid, this.typename});

  Cstmtype.fromJson(Map<String, dynamic> json) {
    typeid = json['typeid'];
    typename = json['typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['typeid'] = this.typeid;
    data['typename'] = this.typename;
    return data;
  }
}

class Cstmprovince {
  int? provid;
  String? provname;

  Cstmprovince({this.provid, this.provname});

  Cstmprovince.fromJson(Map<String, dynamic> json) {
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

class Cstmcity {
  int? cityid;
  String? cityname;

  Cstmcity({this.cityid, this.cityname});

  Cstmcity.fromJson(Map<String, dynamic> json) {
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

class Cstmsubdistrict {
  int? subdistrictid;
  String? subdistrictname;

  Cstmsubdistrict({this.subdistrictid, this.subdistrictname});

  Cstmsubdistrict.fromJson(Map<String, dynamic> json) {
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

class Cstmvillage {
  int? villageid;
  String? villagename;

  Cstmvillage({this.villageid, this.villagename});

  Cstmvillage.fromJson(Map<String, dynamic> json) {
    villageid = json['villageid'];
    villagename = json['villagename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['villageid'] = this.villageid;
    data['villagename'] = this.villagename;
    return data;
  }
}
