class ProspectDetailModel {
  int? prospectdtid;
  int? prospectdtprospectid;
  int? prospectdtcatid;
  int? prospectdttypeid;
  String? prospectdtdate;
  String? prospectdtdesc;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;
  Prospectdtprospect? prospectdtprospect;
  Prospectdtcat? prospectdtcat;
  Prospectdtcat? prospectdttype;

  ProspectDetailModel(
      {this.prospectdtid,
      this.prospectdtprospectid,
      this.prospectdtcatid,
      this.prospectdttypeid,
      this.prospectdtdate,
      this.prospectdtdesc,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive,
      this.prospectdtprospect,
      this.prospectdtcat,
      this.prospectdttype});

  ProspectDetailModel.fromJson(Map<String, dynamic> json) {
    prospectdtid = json['prospectdtid'];
    prospectdtprospectid = json['prospectdtprospectid'];
    prospectdtcatid = json['prospectdtcatid'];
    prospectdttypeid = json['prospectdttypeid'];
    prospectdtdate = json['prospectdtdate'];
    prospectdtdesc = json['prospectdtdesc'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
    prospectdtprospect = json['prospectdtprospect'] != null
        ? new Prospectdtprospect.fromJson(json['prospectdtprospect'])
        : null;
    prospectdtcat = json['prospectdtcat'] != null
        ? new Prospectdtcat.fromJson(json['prospectdtcat'])
        : null;
    prospectdttype = json['prospectdttype'] != null
        ? new Prospectdtcat.fromJson(json['prospectdttype'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prospectdtid'] = this.prospectdtid;
    data['prospectdtprospectid'] = this.prospectdtprospectid;
    data['prospectdtcatid'] = this.prospectdtcatid;
    data['prospectdttypeid'] = this.prospectdttypeid;
    data['prospectdtdate'] = this.prospectdtdate;
    data['prospectdtdesc'] = this.prospectdtdesc;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    if (this.prospectdtprospect != null) {
      data['prospectdtprospect'] = this.prospectdtprospect!.toJson();
    }
    if (this.prospectdtcat != null) {
      data['prospectdtcat'] = this.prospectdtcat!.toJson();
    }
    if (this.prospectdttype != null) {
      data['prospectdttype'] = this.prospectdttype!.toJson();
    }
    return data;
  }
}

class Prospectdtprospect {
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

  Prospectdtprospect(
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

  Prospectdtprospect.fromJson(Map<String, dynamic> json) {
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

class Prospectdtcat {
  int? typeid;
  String? typename;

  Prospectdtcat({this.typeid, this.typename});

  Prospectdtcat.fromJson(Map<String, dynamic> json) {
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
