import '../../helpers/function.dart';

class ProductModel {
  int productid;
  String productname;
  int bpid;
  String bpname;

  ProductModel({
    this.productid = 0,
    this.productname = '',
    this.bpid = 0,
    this.bpname = '',
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productid: parseInt(json['productid']),
      productname: parseString(json['productname']),
      bpid: parseInt(json['businesspartner']['bpid']),
      bpname: parseString(json['businesspartner']['bpname']),
    );
  }
}
