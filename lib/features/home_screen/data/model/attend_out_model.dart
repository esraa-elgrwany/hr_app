class AttendOutModel {
  AttendOutModel({
      this.jsonrpc, 
      this.id, 
      this.result,});

  AttendOutModel.fromJson(dynamic json) {
    jsonrpc = json['jsonrpc'];
    id = json['id'];
    result = json['result'];
  }
  String? jsonrpc;
  int? id;
  bool? result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['jsonrpc'] = jsonrpc;
    map['id'] = id;
    map['result'] = result;
    return map;
  }

}