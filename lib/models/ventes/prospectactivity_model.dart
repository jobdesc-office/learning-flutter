class ProspectActivityModel {
  int? prospectactivityid;
  int? prospectactivityprospectid;
  int? prospectactivitycatid;
  int? prospectactivitytypeid;
  String? prospectactivitydate;
  String? prospectactivitydesc;
  String? prospectactivityinfo;
  String? prospectactivityloc;
  double? prospectactivitylatitude;
  double? prospectactivitylongitude;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;
  Prospectactivityprospect? prospectactivityprospect;
  Prospectactivitycat? prospectactivitycat;
  Prospectactivitycat? prospectactivitytype;

  ProspectActivityModel(
      {this.prospectactivityid,
      this.prospectactivityprospectid,
      this.prospectactivitycatid,
      this.prospectactivitytypeid,
      this.prospectactivitydate,
      this.prospectactivitydesc,
      this.prospectactivityinfo,
      this.prospectactivityloc,
      this.prospectactivitylatitude,
      this.prospectactivitylongitude,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive,
      this.prospectactivityprospect,
      this.prospectactivitycat,
      this.prospectactivitytype});

  ProspectActivityModel.fromJson(Map<String, dynamic> json) {
    prospectactivityid = json['prospectactivityid'];
    prospectactivityprospectid = json['prospectactivityprospectid'];
    prospectactivitycatid = json['prospectactivitycatid'];
    prospectactivitytypeid = json['prospectactivitytypeid'];
    prospectactivitydate = json['prospectactivitydate'];
    prospectactivitydesc = json['prospectactivitydesc'];
    prospectactivityinfo = json['prospectactivityinfo'];
    prospectactivityloc = json['prospectactivityloc'];
    prospectactivitylatitude = json['prospectactivitylatitude'];
    prospectactivitylongitude = json['prospectactivitylongitude'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
    prospectactivityprospect = json['prospectactivityprospect'] != null
        ? new Prospectactivityprospect.fromJson(
            json['prospectactivityprospect'])
        : null;
    prospectactivitycat = json['prospectactivitycat'] != null
        ? new Prospectactivitycat.fromJson(json['prospectactivitycat'])
        : null;
    prospectactivitytype = json['prospectactivitytype'] != null
        ? new Prospectactivitycat.fromJson(json['prospectactivitytype'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prospectactivityid'] = this.prospectactivityid;
    data['prospectactivityprospectid'] = this.prospectactivityprospectid;
    data['prospectactivitycatid'] = this.prospectactivitycatid;
    data['prospectactivitytypeid'] = this.prospectactivitytypeid;
    data['prospectactivitydate'] = this.prospectactivitydate;
    data['prospectactivitydesc'] = this.prospectactivitydesc;
    data['prospectactivityinfo'] = this.prospectactivityinfo;
    data['prospectactivityloc'] = this.prospectactivityloc;
    data['prospectactivitylatitude'] = this.prospectactivitylatitude;
    data['prospectactivitylongitude'] = this.prospectactivitylongitude;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    if (this.prospectactivityprospect != null) {
      data['prospectactivityprospect'] =
          this.prospectactivityprospect!.toJson();
    }
    if (this.prospectactivitycat != null) {
      data['prospectactivitycat'] = this.prospectactivitycat!.toJson();
    }
    if (this.prospectactivitytype != null) {
      data['prospectactivitytype'] = this.prospectactivitytype!.toJson();
    }
    return data;
  }
}

class Prospectactivityprospect {
  int? prospectid;
  String? prospectname;
  String? prospectstartdate;
  String? prospectenddate;
  String? prospectvalue;
  int? prospectowner;
  int? prospectstageid;
  int? prospectstatusid;
  int? prospecttypeid;
  String? prospectexpclosedate;
  int? prospectbpid;
  String? prospectdescription;
  int? prospectcustid;
  int? prospectrefid;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;

  Prospectactivityprospect(
      {this.prospectid,
      this.prospectname,
      this.prospectstartdate,
      this.prospectenddate,
      this.prospectvalue,
      this.prospectowner,
      this.prospectstageid,
      this.prospectstatusid,
      this.prospecttypeid,
      this.prospectexpclosedate,
      this.prospectbpid,
      this.prospectdescription,
      this.prospectcustid,
      this.prospectrefid,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive});

  Prospectactivityprospect.fromJson(Map<String, dynamic> json) {
    prospectid = json['prospectid'];
    prospectname = json['prospectname'];
    prospectstartdate = json['prospectstartdate'];
    prospectenddate = json['prospectenddate'];
    prospectvalue = json['prospectvalue'];
    prospectowner = json['prospectowner'];
    prospectstageid = json['prospectstageid'];
    prospectstatusid = json['prospectstatusid'];
    prospecttypeid = json['prospecttypeid'];
    prospectexpclosedate = json['prospectexpclosedate'];
    prospectbpid = json['prospectbpid'];
    prospectdescription = json['prospectdescription'];
    prospectcustid = json['prospectcustid'];
    prospectrefid = json['prospectrefid'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prospectid'] = this.prospectid;
    data['prospectname'] = this.prospectname;
    data['prospectstartdate'] = this.prospectstartdate;
    data['prospectenddate'] = this.prospectenddate;
    data['prospectvalue'] = this.prospectvalue;
    data['prospectowner'] = this.prospectowner;
    data['prospectstageid'] = this.prospectstageid;
    data['prospectstatusid'] = this.prospectstatusid;
    data['prospecttypeid'] = this.prospecttypeid;
    data['prospectexpclosedate'] = this.prospectexpclosedate;
    data['prospectbpid'] = this.prospectbpid;
    data['prospectdescription'] = this.prospectdescription;
    data['prospectcustid'] = this.prospectcustid;
    data['prospectrefid'] = this.prospectrefid;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    return data;
  }
}

class Prospectactivitycat {
  int? typeid;
  String? typename;

  Prospectactivitycat({this.typeid, this.typename});

  Prospectactivitycat.fromJson(Map<String, dynamic> json) {
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
