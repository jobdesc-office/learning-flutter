class DspbycustModel {
  int? prospectbpid;
  String? prospectbpname;
  int? prospectcustid;
  String? prospectcustname;
  int? prospectyy;
  int? prospectmm;
  int? prospectvalue;
  Prospectbp? prospectbp;
  Prospectcust? prospectcust;

  DspbycustModel(
      {this.prospectbpid,
      this.prospectbpname,
      this.prospectcustid,
      this.prospectcustname,
      this.prospectyy,
      this.prospectmm,
      this.prospectvalue,
      this.prospectbp,
      this.prospectcust});

  DspbycustModel.fromJson(Map<String, dynamic> json) {
    prospectbpid = json['prospectbpid'];
    prospectbpname = json['prospectbpname'];
    prospectcustid = json['prospectcustid'];
    prospectcustname = json['prospectcustname'];
    prospectyy = json['prospectyy'];
    prospectmm = json['prospectmm'];
    prospectvalue = json['prospectvalue'];
    prospectbp = json['prospectbp'] != null
        ? new Prospectbp.fromJson(json['prospectbp'])
        : null;
    prospectcust = json['prospectcust'] != null
        ? new Prospectcust.fromJson(json['prospectcust'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prospectbpid'] = this.prospectbpid;
    data['prospectbpname'] = this.prospectbpname;
    data['prospectcustid'] = this.prospectcustid;
    data['prospectcustname'] = this.prospectcustname;
    data['prospectyy'] = this.prospectyy;
    data['prospectmm'] = this.prospectmm;
    data['prospectvalue'] = this.prospectvalue;
    if (this.prospectbp != null) {
      data['prospectbp'] = this.prospectbp!.toJson();
    }
    if (this.prospectcust != null) {
      data['prospectcust'] = this.prospectcust!.toJson();
    }
    return data;
  }
}

class Prospectbp {
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

  Prospectbp(
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

  Prospectbp.fromJson(Map<String, dynamic> json) {
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

class Prospectcust {
  int? sbcid;
  int? sbcbpid;
  int? sbccstmid;
  int? sbccstmstatusid;
  String? sbccstmname;
  String? sbccstmphone;
  String? sbccstmaddress;
  Null? createdby;
  String? createddate;
  Null? updatedby;
  String? updateddate;
  bool? isactive;

  Prospectcust(
      {this.sbcid,
      this.sbcbpid,
      this.sbccstmid,
      this.sbccstmstatusid,
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
