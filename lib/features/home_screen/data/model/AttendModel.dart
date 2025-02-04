class AttendModel {
  AttendModel({
      this.jsonrpc, 
      this.id, 
      this.result,});

  AttendModel.fromJson(dynamic json) {
    jsonrpc = json['jsonrpc'];
    id = json['id'];
    result = json['result'];
  }
  String? jsonrpc;
  int? id;
  int? result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['jsonrpc'] = jsonrpc;
    map['id'] = id;
    map['result'] = result;
    return map;
  }

}