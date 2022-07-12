class CompetitorModel {
  int? comptid;
  int? comptbpid;
  int? comptreftypeid;
  int? comptrefid;
  String? comptname;
  String? comptproductname;
  String? description;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;
  Comptreftype? comptreftype;
  Comptbp? comptbp;

  CompetitorModel(
      {this.comptid,
      this.comptbpid,
      this.comptreftypeid,
      this.comptrefid,
      this.comptname,
      this.comptproductname,
      this.description,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive,
      this.comptreftype,
      this.comptbp});

  CompetitorModel.fromJson(Map<String, dynamic> json) {
    comptid = json['comptid'];
    comptbpid = json['comptbpid'];
    comptreftypeid = json['comptreftypeid'];
    comptrefid = json['comptrefid'];
    comptname = json['comptname'];
    comptproductname = json['comptproductname'];
    description = json['description'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
    comptreftype = json['comptreftype'] != null
        ? new Comptreftype.fromJson(json['comptreftype'])
        : null;
    comptbp =
        json['comptbp'] != null ? new Comptbp.fromJson(json['comptbp']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comptid'] = this.comptid;
    data['comptbpid'] = this.comptbpid;
    data['comptreftypeid'] = this.comptreftypeid;
    data['comptrefid'] = this.comptrefid;
    data['comptname'] = this.comptname;
    data['comptproductname'] = this.comptproductname;
    data['description'] = this.description;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    if (this.comptreftype != null) {
      data['comptreftype'] = this.comptreftype!.toJson();
    }
    if (this.comptbp != null) {
      data['comptbp'] = this.comptbp!.toJson();
    }
    return data;
  }
}

class Comptreftype {
  int? typeid;
  String? typename;

  Comptreftype({this.typeid, this.typename});

  Comptreftype.fromJson(Map<String, dynamic> json) {
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

class Comptbp {
  int? bpid;
  String? bpname;
  int? bptypeid;
  String? bppicname;
  String? bpemail;
  String? bpphone;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;

  Comptbp(
      {this.bpid,
      this.bpname,
      this.bptypeid,
      this.bppicname,
      this.bpemail,
      this.bpphone,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive});

  Comptbp.fromJson(Map<String, dynamic> json) {
    bpid = json['bpid'];
    bpname = json['bpname'];
    bptypeid = json['bptypeid'];
    bppicname = json['bppicname'];
    bpemail = json['bpemail'];
    bpphone = json['bpphone'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bpid'] = this.bpid;
    data['bpname'] = this.bpname;
    data['bptypeid'] = this.bptypeid;
    data['bppicname'] = this.bppicname;
    data['bpemail'] = this.bpemail;
    data['bpphone'] = this.bpphone;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    return data;
  }
}
