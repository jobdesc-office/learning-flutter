import '../../helpers/function.dart';

class TypeModel {
  int typeid;
  String typecd;
  String typename;
  int typeseq;
  int masterid;
  String description;

  TypeModel({
    this.typeid = 0,
    this.typecd = '',
    this.typename = '',
    this.typeseq = 0,
    this.masterid = 0,
    this.description = '',
  });

  factory TypeModel.fromJson(Map<String, dynamic> json) {
    return TypeModel(
      typeid: parseInt(json['typeid']),
      typecd: parseString(json['typecd']),
      typename: parseString(json['typename']),
      typeseq: parseInt(json['typeseq']),
      masterid: parseInt(json['masterid']),
      description: parseString(json['description']),
    );
  }
}
