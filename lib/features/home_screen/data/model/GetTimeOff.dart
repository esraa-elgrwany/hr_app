class GetTimeOff {
  GetTimeOff({
      this.jsonrpc, 
      this.id, 
      this.result,});

  GetTimeOff.fromJson(dynamic json) {
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
      this.holidayStatusId, 
      this.requestDateFrom, 
      this.requestDateTo, 
      this.state,});

  Result.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    holidayStatusId= json['holiday_status_id'] != null ? json['holiday_status_id'].cast<dynamic>() : [];
    requestDateFrom = json['request_date_from'];
    requestDateTo = json['request_date_to'];
    state = json['state'];
  }
  int? id;
  String? name;
  List<dynamic>? holidayStatusId;
  String? requestDateFrom;
  String? requestDateTo;
  String? state;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['holiday_status_id'] = holidayStatusId;
    map['request_date_from'] = requestDateFrom;
    map['request_date_to'] = requestDateTo;
    map['state'] = state;
    return map;
  }
}
