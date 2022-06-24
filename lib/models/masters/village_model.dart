import '../../helpers/function.dart';

class VillageModel {
  int villageid;
  String villagename;
  int subdistrictid;
  String subdistrictname;

  VillageModel({
    this.villageid = 0,
    this.villagename = '',
    this.subdistrictid = 0,
    this.subdistrictname = '',
  });

  factory VillageModel.fromJson(Map<String, dynamic> json) {
    return VillageModel(
      villageid: parseInt(json['villageid']),
      villagename: parseString(json['villagename']),
      subdistrictid: parseInt(json['villagesubdistrict']['subdistrictid']),
      subdistrictname:
          parseString(json['villagesubdistrict']['subdistrictname']),
    );
  }
}
