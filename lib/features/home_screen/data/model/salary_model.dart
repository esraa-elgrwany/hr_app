class SalaryModel {
  SalaryModel({
    this.jsonrpc,
    this.id,
    this.result,
  });

  SalaryModel.fromJson(dynamic json) {
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
    this.dateFrom,
    this.dateTo,
    this.state,
    this.employeeId,
    this.lineIds,
  });

  Result.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    dateFrom = json['date_from'];
    dateTo = json['date_to'];
    state = json['state'];
    employeeId =
        json['employee_id'] != null ? json['employee_id'].cast<dynamic>() : [];
    lineIds = json['line_ids'] != null ? json['line_ids'].cast<int>() : [];
  }

  int? id;
  String? name;
  String? dateFrom;
  String? dateTo;
  String? state;
  List<dynamic>? employeeId;
  List<int>? lineIds;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['date_from'] = dateFrom;
    map['date_to'] = dateTo;
    map['state'] = state;
    map['employee_id'] = employeeId;
    map['line_ids'] = lineIds;
    return map;
  }
}
