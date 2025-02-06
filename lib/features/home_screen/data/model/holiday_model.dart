class HolidayModel {
  HolidayModel({
    this.jsonrpc,
    this.id,
    this.result,
  });

  HolidayModel.fromJson(dynamic json) {
    jsonrpc = json['jsonrpc'];
    id = json['id'];
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result?.add(HolidayResult.fromJson(v));
      });
    }
  }

  String? jsonrpc;
  int? id;
  List<HolidayResult>? result;

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

class HolidayResult {
  HolidayResult({
    this.id,
    this.name,
    this.holidayStatusId,
    this.requestDateFrom,
    this.requestDateTo,
    this.state,
  });

  HolidayResult.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'].toString();
    holidayStatusId = json['holiday_status_id'] != null
        ? List<dynamic>.from(json['holiday_status_id'])
        : [];
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
