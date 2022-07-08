class AddressModel {
  int? villageid;
  int? villagesubdistrictid;
  String? villagename;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;
  Villagesubdistrict? villagesubdistrict;

  AddressModel(
      {this.villageid,
      this.villagesubdistrictid,
      this.villagename,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive,
      this.villagesubdistrict});

  AddressModel.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class Villagesubdistrict {
  int? subdistrictid;
  int? subdistrictcityid;
  String? subdistrictname;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;
  Subdistrictcity? subdistrictcity;

  Villagesubdistrict(
      {this.subdistrictid,
      this.subdistrictcityid,
      this.subdistrictname,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive,
      this.subdistrictcity});

  Villagesubdistrict.fromJson(Map<String, dynamic> json) {
    subdistrictid = json['subdistrictid'];
    subdistrictcityid = json['subdistrictcityid'];
    subdistrictname = json['subdistrictname'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
    subdistrictcity = json['subdistrictcity'] != null
        ? new Subdistrictcity.fromJson(json['subdistrictcity'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subdistrictid'] = this.subdistrictid;
    data['subdistrictcityid'] = this.subdistrictcityid;
    data['subdistrictname'] = this.subdistrictname;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    if (this.subdistrictcity != null) {
      data['subdistrictcity'] = this.subdistrictcity!.toJson();
    }
    return data;
  }
}

class Subdistrictcity {
  int? cityid;
  int? cityprovid;
  String? cityname;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;
  Cityprov? cityprov;

  Subdistrictcity(
      {this.cityid,
      this.cityprovid,
      this.cityname,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive,
      this.cityprov});

  Subdistrictcity.fromJson(Map<String, dynamic> json) {
    cityid = json['cityid'];
    cityprovid = json['cityprovid'];
    cityname = json['cityname'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
    cityprov = json['cityprov'] != null
        ? new Cityprov.fromJson(json['cityprov'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cityid'] = this.cityid;
    data['cityprovid'] = this.cityprovid;
    data['cityname'] = this.cityname;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    if (this.cityprov != null) {
      data['cityprov'] = this.cityprov!.toJson();
    }
    return data;
  }
}

class Cityprov {
  int? provid;
  int? provcountryid;
  String? provname;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;

  Cityprov(
      {this.provid,
      this.provcountryid,
      this.provname,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive});

  Cityprov.fromJson(Map<String, dynamic> json) {
    provid = json['provid'];
    provcountryid = json['provcountryid'];
    provname = json['provname'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
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
    return data;
  }
}
