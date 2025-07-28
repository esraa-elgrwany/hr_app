class SalaryLineModel {
  SalaryLineModel({
      this.jsonrpc, 
      this.id, 
      this.result,});

  SalaryLineModel.fromJson(dynamic json) {
    jsonrpc = json['jsonrpc'];
    id = json['id'];
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result?.add(SalaryLineResult.fromJson(v));
      });
    }
  }
  String? jsonrpc;
  int? id;
  List<SalaryLineResult>? result;

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

class SalaryLineResult {
  SalaryLineResult({
      this.id, 
      this.name, 
      this.total, 
      this.slipId,});

  SalaryLineResult.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    total = json['total'];
    slipId = json['slip_id'] != null ? json['slip_id'].cast<int>() : [];
  }
  int? id;
  String? name;
  double? total;
  List<int>? slipId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['total'] = total;
    map['slip_id'] = slipId;
    return map;
  }

}