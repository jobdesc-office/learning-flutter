import 'package:boilerplate/models/masters/security_group_model.dart';

class CustomFieldModel {
  int? custfid;
  int? custfbpid;
  String? custfname;
  int? custftypeid;
  int? custfreftypeid;
  bool? alldata;
  bool? onlythisdata;
  int? thisdataid;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;
  Custfcreatedby? custfcreatedby;
  Custfcreatedby? custfupdatedby;
  Businesspartner? businesspartner;
  SecurityGroupModel? securitygroup;
  Custftype? custftype;
  Custftype? custfreftype;
  Refprospect? refprospect;
  Refactivity? refactivity;
  List<Selectoption>? selectoption;

  CustomFieldModel(
      {this.custfid,
      this.custfbpid,
      this.custfname,
      this.custftypeid,
      this.custfreftypeid,
      this.alldata,
      this.onlythisdata,
      this.thisdataid,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive,
      this.custfcreatedby,
      this.custfupdatedby,
      this.businesspartner,
      this.custftype,
      this.custfreftype,
      this.refprospect,
      this.refactivity,
      this.selectoption});

  CustomFieldModel.fromJson(Map<String, dynamic> json) {
    custfid = json['custfid'];
    custfbpid = json['custfbpid'];
    custfname = json['custfname'];
    custftypeid = json['custftypeid'];
    custfreftypeid = json['custfreftypeid'];
    alldata = json['alldata'];
    onlythisdata = json['onlythisdata'];
    thisdataid = json['thisdataid'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
    custfcreatedby = json['custfcreatedby'] != null ? new Custfcreatedby.fromJson(json['custfcreatedby']) : null;
    custfupdatedby = json['custfupdatedby'] != null ? new Custfcreatedby.fromJson(json['custfupdatedby']) : null;
    businesspartner = json['businesspartner'] != null ? new Businesspartner.fromJson(json['businesspartner']) : null;
    securitygroup = json['securitygroup'] != null ? new SecurityGroupModel.fromJson(json['securitygroup']) : null;
    custftype = json['custftype'] != null ? new Custftype.fromJson(json['custftype']) : null;
    custfreftype = json['custfreftype'] != null ? new Custftype.fromJson(json['custfreftype']) : null;
    refprospect = json['refprospect'] != null ? new Refprospect.fromJson(json['refprospect']) : null;
    refactivity = json['refactivity'] != null ? new Refactivity.fromJson(json['refactivity']) : null;
    if (json['selectoption'] != null) {
      selectoption = <Selectoption>[];
      json['selectoption'].forEach((v) {
        selectoption!.add(new Selectoption.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['custfid'] = this.custfid;
    data['custfbpid'] = this.custfbpid;
    data['custfname'] = this.custfname;
    data['custftypeid'] = this.custftypeid;
    data['custfreftypeid'] = this.custfreftypeid;
    data['alldata'] = this.alldata;
    data['onlythisdata'] = this.onlythisdata;
    data['thisdataid'] = this.thisdataid;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    if (this.custfcreatedby != null) {
      data['custfcreatedby'] = this.custfcreatedby!.toJson();
    }
    if (this.custfupdatedby != null) {
      data['custfupdatedby'] = this.custfupdatedby!.toJson();
    }
    if (this.businesspartner != null) {
      data['businesspartner'] = this.businesspartner!.toJson();
    }
    if (this.securitygroup != null) {
      data['securitygroup'] = this.securitygroup!.toJson();
    }
    if (this.custftype != null) {
      data['custftype'] = this.custftype!.toJson();
    }
    if (this.custfreftype != null) {
      data['custfreftype'] = this.custfreftype!.toJson();
    }
    if (this.refprospect != null) {
      data['refprospect'] = this.refprospect!.toJson();
    }
    if (this.refactivity != null) {
      data['refactivity'] = this.refactivity!.toJson();
    }
    if (this.selectoption != null) {
      data['selectoption'] = this.selectoption!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Custfcreatedby {
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

  Custfcreatedby(
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

  Custfcreatedby.fromJson(Map<String, dynamic> json) {
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

class Custftype {
  int? typeid;
  String? typename;

  Custftype({this.typeid, this.typename});

  Custftype.fromJson(Map<String, dynamic> json) {
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

class Refprospect {
  int? prospectid;
  String? prospectname;
  String? prospectcode;
  String? prospectstartdate;
  String? prospectenddate;
  String? prospectvalue;
  int? prospectowner;
  int? prospectstageid;
  int? prospectstatusid;
  String? prospectexpclosedate;
  int? prospectbpid;
  String? prospectdescription;
  int? prospectcustid;
  int? prospectrefid;
  int? prospectlostreasonid;
  String? prospectlostdesc;
  int? prospectcustlabel;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;
  Prospectcust? prospectcust;

  Refprospect(
      {this.prospectid,
      this.prospectname,
      this.prospectcode,
      this.prospectstartdate,
      this.prospectenddate,
      this.prospectvalue,
      this.prospectowner,
      this.prospectstageid,
      this.prospectstatusid,
      this.prospectexpclosedate,
      this.prospectbpid,
      this.prospectdescription,
      this.prospectcustid,
      this.prospectrefid,
      this.prospectlostreasonid,
      this.prospectlostdesc,
      this.prospectcustlabel,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive,
      this.prospectcust});

  Refprospect.fromJson(Map<String, dynamic> json) {
    prospectid = json['prospectid'];
    prospectname = json['prospectname'];
    prospectcode = json['prospectcode'];
    prospectstartdate = json['prospectstartdate'];
    prospectenddate = json['prospectenddate'];
    prospectvalue = json['prospectvalue'];
    prospectowner = json['prospectowner'];
    prospectstageid = json['prospectstageid'];
    prospectstatusid = json['prospectstatusid'];
    prospectexpclosedate = json['prospectexpclosedate'];
    prospectbpid = json['prospectbpid'];
    prospectdescription = json['prospectdescription'];
    prospectcustid = json['prospectcustid'];
    prospectrefid = json['prospectrefid'];
    prospectlostreasonid = json['prospectlostreasonid'];
    prospectlostdesc = json['prospectlostdesc'];
    prospectcustlabel = json['prospectcustlabel'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
    prospectcust = json['prospectcust'] != null ? new Prospectcust.fromJson(json['prospectcust']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prospectid'] = this.prospectid;
    data['prospectname'] = this.prospectname;
    data['prospectcode'] = this.prospectcode;
    data['prospectstartdate'] = this.prospectstartdate;
    data['prospectenddate'] = this.prospectenddate;
    data['prospectvalue'] = this.prospectvalue;
    data['prospectowner'] = this.prospectowner;
    data['prospectstageid'] = this.prospectstageid;
    data['prospectstatusid'] = this.prospectstatusid;
    data['prospectexpclosedate'] = this.prospectexpclosedate;
    data['prospectbpid'] = this.prospectbpid;
    data['prospectdescription'] = this.prospectdescription;
    data['prospectcustid'] = this.prospectcustid;
    data['prospectrefid'] = this.prospectrefid;
    data['prospectlostreasonid'] = this.prospectlostreasonid;
    data['prospectlostdesc'] = this.prospectlostdesc;
    data['prospectcustlabel'] = this.prospectcustlabel;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    if (this.prospectcust != null) {
      data['prospectcust'] = this.prospectcust!.toJson();
    }
    return data;
  }
}

class Prospectcust {
  int? sbcid;
  int? sbcbpid;
  int? sbccstmid;
  int? sbccstmstatusid;
  int? sbcactivitytypeid;
  String? sbccstmname;
  String? sbccstmphone;
  String? sbccstmaddress;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;

  Prospectcust(
      {this.sbcid,
      this.sbcbpid,
      this.sbccstmid,
      this.sbccstmstatusid,
      this.sbcactivitytypeid,
      this.sbccstmname,
      this.sbccstmphone,
      this.sbccstmaddress,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive});

  Prospectcust.fromJson(Map<String, dynamic> json) {
    sbcid = json['sbcid'];
    sbcbpid = json['sbcbpid'];
    sbccstmid = json['sbccstmid'];
    sbccstmstatusid = json['sbccstmstatusid'];
    sbcactivitytypeid = json['sbcactivitytypeid'];
    sbccstmname = json['sbccstmname'];
    sbccstmphone = json['sbccstmphone'];
    sbccstmaddress = json['sbccstmaddress'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sbcid'] = this.sbcid;
    data['sbcbpid'] = this.sbcbpid;
    data['sbccstmid'] = this.sbccstmid;
    data['sbccstmstatusid'] = this.sbccstmstatusid;
    data['sbcactivitytypeid'] = this.sbcactivitytypeid;
    data['sbccstmname'] = this.sbccstmname;
    data['sbccstmphone'] = this.sbccstmphone;
    data['sbccstmaddress'] = this.sbccstmaddress;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    return data;
  }
}

class Refactivity {
  int? dayactid;
  int? dayactcatid;
  int? dayactcustid;
  String? dayactdate;
  String? dayactdesc;
  String? dayactloclabel;
  String? dayactloc;
  String? dayactaddress;
  double? dayactlatitude;
  double? dayactlongitude;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;

  Refactivity(
      {this.dayactid,
      this.dayactcatid,
      this.dayactcustid,
      this.dayactdate,
      this.dayactdesc,
      this.dayactloclabel,
      this.dayactloc,
      this.dayactaddress,
      this.dayactlatitude,
      this.dayactlongitude,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive});

  Refactivity.fromJson(Map<String, dynamic> json) {
    dayactid = json['dayactid'];
    dayactcatid = json['dayactcatid'];
    dayactcustid = json['dayactcustid'];
    dayactdate = json['dayactdate'];
    dayactdesc = json['dayactdesc'];
    dayactloclabel = json['dayactloclabel'];
    dayactloc = json['dayactloc'];
    dayactaddress = json['dayactaddress'];
    dayactlatitude = json['dayactlatitude'];
    dayactlongitude = json['dayactlongitude'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dayactid'] = this.dayactid;
    data['dayactcatid'] = this.dayactcatid;
    data['dayactcustid'] = this.dayactcustid;
    data['dayactdate'] = this.dayactdate;
    data['dayactdesc'] = this.dayactdesc;
    data['dayactloclabel'] = this.dayactloclabel;
    data['dayactloc'] = this.dayactloc;
    data['dayactaddress'] = this.dayactaddress;
    data['dayactlatitude'] = this.dayactlatitude;
    data['dayactlongitude'] = this.dayactlongitude;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    return data;
  }
}

class Selectoption {
  int? optid;
  int? optcustfid;
  String? optvalue;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;

  Selectoption({this.optid, this.optcustfid, this.optvalue, this.createdby, this.createddate, this.updatedby, this.updateddate, this.isactive});

  Selectoption.fromJson(Map<String, dynamic> json) {
    optid = json['optid'];
    optcustfid = json['optcustfid'];
    optvalue = json['optvalue'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['optid'] = this.optid;
    data['optcustfid'] = this.optcustfid;
    data['optvalue'] = this.optvalue;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    return data;
  }
}
