class ProductModel {
  ProductModel({
      this.jsonrpc, 
      this.id, 
      this.result,});

  ProductModel.fromJson(dynamic json) {
    jsonrpc = json['jsonrpc'];
    id = json['id'];
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result?.add(ProductResult.fromJson(v));
      });
    }
  }
  String? jsonrpc;
  int? id;
  List<ProductResult>? result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['jsonrpc'] = jsonrpc;
    map['id'] = id;
    if (result != null) {
      map['result'] = result?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class ProductResult {
  ProductResult({
      this.id, 
      this.name, 
      this.defaultCode, 
      this.lstPrice,});

  ProductResult.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    defaultCode = json['default_code'];
    lstPrice = json['lst_price'];
  }
  int? id;
  String? name;
  String? defaultCode;
  double? lstPrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['default_code'] = defaultCode;
    map['lst_price'] = lstPrice;
    return map;
  }

}