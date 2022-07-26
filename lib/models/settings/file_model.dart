class FileModel {
  int? fileid;
  int? transtypeid;
  int? refid;
  String? directories;
  String? filename;
  String? mimetype;
  String? filesize;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;
  String? url;
  Transtype? transtype;

  FileModel(
      {this.fileid,
      this.transtypeid,
      this.refid,
      this.directories,
      this.filename,
      this.mimetype,
      this.filesize,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive,
      this.url,
      this.transtype});

  FileModel.fromJson(Map<String, dynamic> json) {
    fileid = json['fileid'];
    transtypeid = json['transtypeid'];
    refid = json['refid'];
    directories = json['directories'];
    filename = json['filename'];
    mimetype = json['mimetype'];
    filesize = json['filesize'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
    url = json['url'];
    transtype = json['transtype'] != null
        ? new Transtype.fromJson(json['transtype'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fileid'] = this.fileid;
    data['transtypeid'] = this.transtypeid;
    data['refid'] = this.refid;
    data['directories'] = this.directories;
    data['filename'] = this.filename;
    data['mimetype'] = this.mimetype;
    data['filesize'] = this.filesize;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    data['url'] = this.url;
    if (this.transtype != null) {
      data['transtype'] = this.transtype!.toJson();
    }
    return data;
  }
}

class Transtype {
  int? typeid;
  String? typename;

  Transtype({this.typeid, this.typename});

  Transtype.fromJson(Map<String, dynamic> json) {
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
