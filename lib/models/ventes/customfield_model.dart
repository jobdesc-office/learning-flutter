class CustomFieldModel {
  int? custfid;
  int? custfbpid;
  String? custfname;
  int? custftypeid;
  bool? allprospect;
  bool? onlythisprospect;
  int? thisprospectid;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;
  Businesspartner? businesspartner;
  Custftype? custftype;

  CustomFieldModel(
      {this.custfid,
      this.custfbpid,
      this.custfname,
      this.custftypeid,
      this.allprospect,
      this.onlythisprospect,
      this.thisprospectid,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive,
      this.businesspartner,
      this.custftype});

  CustomFieldModel.fromJson(Map<String, dynamic> json) {
    custfid = json['custfid'];
    custfbpid = json['custfbpid'];
    custfname = json['custfname'];
    custftypeid = json['custftypeid'];
    allprospect = json['allprospect'];
    onlythisprospect = json['onlythisprospect'];
    thisprospectid = json['thisprospectid'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
    businesspartner = json['businesspartner'] != null
        ? new Businesspartner.fromJson(json['businesspartner'])
        : null;
    custftype = json['custftype'] != null
        ? new Custftype.fromJson(json['custftype'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['custfid'] = this.custfid;
    data['custfbpid'] = this.custfbpid;
    data['custfname'] = this.custfname;
    data['custftypeid'] = this.custftypeid;
    data['allprospect'] = this.allprospect;
    data['onlythisprospect'] = this.onlythisprospect;
    data['thisprospectid'] = this.thisprospectid;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    if (this.businesspartner != null) {
      data['businesspartner'] = this.businesspartner!.toJson();
    }
    if (this.custftype != null) {
      data['custftype'] = this.custftype!.toJson();
    }
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
