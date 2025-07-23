class EmployeeModel {
  EmployeeModel({
    this.jsonrpc,
    this.id,
    this.result,});

  EmployeeModel.fromJson(dynamic json) {
    jsonrpc = json['jsonrpc'];
    id = json['id'];
    result = (json['result'] as List?)?.map((v) => EmployeeResult.fromJson(v)).toList() ?? [];
    /*if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result?.add(EmployeeResult.fromJson(v));
      });
    }*/
  }
  String? jsonrpc;
  int? id;
  List<EmployeeResult>? result;

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

class EmployeeResult {
  EmployeeResult({
    this.id,
    this.name,
    this.employeeIds,});

  EmployeeResult.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    employeeIds = json['employee_ids'] != null ? json['employee_ids'].cast<int>() : [];
  }
  int? id;
  String? name;
  List<int>? employeeIds;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['employee_ids'] = employeeIds;
    return map;
  }

}