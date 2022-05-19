import '../../helpers/function.dart';
import 'type_model.dart';

class CountryModel {
  int countryid;
  String countryname;

  CountryModel({
    this.countryid = 0,
    this.countryname = '',
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      countryid: parseInt(json['countryid']),
      countryname: parseString(json['countryname']),
    );
  }
}
