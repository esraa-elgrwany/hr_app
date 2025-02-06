class ExpensesModel {
  ExpensesModel({
    this.jsonrpc,
    this.id,
    this.result,
  });

  ExpensesModel.fromJson(dynamic json) {
    jsonrpc = json['jsonrpc'];
    id = json['id'];
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result?.add(ExpensesResult.fromJson(v));
      });
    }
  }

  String? jsonrpc;
  int? id;
  List<ExpensesResult>? result;

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

class ExpensesResult {
  ExpensesResult({
    this.id,
    this.name,
    this.productId,
    this.totalAmountCurrency,
    this.date,
  });

  ExpensesResult.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    productId = (json['product_id'] is List && json['product_id'].length == 2)
        ? json['product_id']
        : (json['product_id'] == false ? false : null);
    totalAmountCurrency = json['total_amount_currency'];
    date = json['date'];
  }

  int? id;
  String? name;
  dynamic productId;
  double? totalAmountCurrency;
  String? date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['product_id'] = productId;
    map['total_amount_currency'] = totalAmountCurrency;
    map['date'] = date;
    return map;
  }
}
