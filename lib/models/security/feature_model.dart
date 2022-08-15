class FeatureModel {
  int? featid;
  int? featmenuid;
  String? feattitle;
  String? featslug;
  String? featuredesc;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;
  Menu? menu;

  FeatureModel(
      {this.featid,
      this.featmenuid,
      this.feattitle,
      this.featslug,
      this.featuredesc,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive,
      this.menu});

  FeatureModel.fromJson(Map<String, dynamic> json) {
    featid = json['featid'];
    featmenuid = json['featmenuid'];
    feattitle = json['feattitle'];
    featslug = json['featslug'];
    featuredesc = json['featuredesc'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
    menu = json['menu'] != null ? new Menu.fromJson(json['menu']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['featid'] = this.featid;
    data['featmenuid'] = this.featmenuid;
    data['feattitle'] = this.feattitle;
    data['featslug'] = this.featslug;
    data['featuredesc'] = this.featuredesc;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    if (this.menu != null) {
      data['menu'] = this.menu!.toJson();
    }
    return data;
  }
}

class Menu {
  int? menuid;
  Null? masterid;
  int? menutypeid;
  String? menunm;
  Null? menuicon;
  Null? menuroute;
  Null? menucolor;
  Null? menuseq;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;

  Menu(
      {this.menuid,
      this.masterid,
      this.menutypeid,
      this.menunm,
      this.menuicon,
      this.menuroute,
      this.menucolor,
      this.menuseq,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive});

  Menu.fromJson(Map<String, dynamic> json) {
    menuid = json['menuid'];
    masterid = json['masterid'];
    menutypeid = json['menutypeid'];
    menunm = json['menunm'];
    menuicon = json['menuicon'];
    menuroute = json['menuroute'];
    menucolor = json['menucolor'];
    menuseq = json['menuseq'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menuid'] = this.menuid;
    data['masterid'] = this.masterid;
    data['menutypeid'] = this.menutypeid;
    data['menunm'] = this.menunm;
    data['menuicon'] = this.menuicon;
    data['menuroute'] = this.menuroute;
    data['menucolor'] = this.menucolor;
    data['menuseq'] = this.menuseq;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    return data;
  }
}
