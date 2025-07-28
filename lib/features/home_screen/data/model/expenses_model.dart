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
     this.product,
     this.employee,
     this.date,
     this.state,
  });

  ExpensesResult.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    product= Product.fromList(json['product_id']);
    employee= Employee.fromList(json['employee_id']);
    date= json['date'];
    state= json['state'];
  }

  int? id;
  String? name;
  Product? product;
  Employee? employee;
  String? date;
  String? state;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['product_id'] = product;
    map['employee_id'] = employee;
    map['date'] = date;
    map['state'] = state;
    return map;
  }
}
class Product {
  final int id;
  final String name;

  Product({
    required this.id,
    required this.name,
  });

  factory Product.fromList(List<dynamic> list) {
    return Product(
      id: list[0],
      name: list[1],
    );
  }
}

class Employee {
  final int id;
  final String name;

  Employee({
    required this.id,
    required this.name,
  });

  factory Employee.fromList(List<dynamic> list) {
    return Employee(
      id: list[0],
      name: list[1],
    );
  }
}
