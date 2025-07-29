class NewsModel {
  NewsModel({
      this.jsonrpc, 
      this.id, 
      this.result,});

  NewsModel.fromJson(dynamic json) {
    jsonrpc = json['jsonrpc'];
    id = json['id'];
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result?.add(NewsResult.fromJson(v));
      });
    }
  }
  String? jsonrpc;
  int? id;
  List<NewsResult>? result;

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

class NewsResult {
  NewsResult({
      this.id, 
      this.name, 
      this.announcement,
      this.dateStart,});

  NewsResult.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    announcement = json['announcement'];
    dateStart = json['date_start'];
  }
  int? id;
  String? name;
  String? announcement;
  String? dateStart;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['announcement'] = announcement;
    map['date_start'] = dateStart;
    return map;
  }

}