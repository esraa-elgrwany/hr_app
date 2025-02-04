class ExpensesModel {
  ExpensesModel({
      this.jsonrpc, 
      this.id, 
      this.result,});

  ExpensesModel.fromJson(dynamic json) {
    jsonrpc = json['jsonrpc'];
    id = json['id'];
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result?.add(Result.fromJson(v));
      });
    }
  }
  String? jsonrpc;
  int? id;
  List<Result>? result;

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

class Result {
  Result({
      this.id, 
      this.name, 
      this.productId, 
      this.totalAmountCurrency, 
      this.employeeId, 
      this.date,});

  Result.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    productId = json['product_id'];
    totalAmountCurrency = json['total_amount_currency'];
    employeeId = json['employee_id'] != null ? json['employee_id'].cast<int>() : [];
    date = json['date'];
  }
  int? id;
  String? name;
  bool? productId;
  double? totalAmountCurrency;
  List<int>? employeeId;
  String? date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['product_id'] = productId;
    map['total_amount_currency'] = totalAmountCurrency;
    map['employee_id'] = employeeId;
    map['date'] = date;
    return map;
  }

}