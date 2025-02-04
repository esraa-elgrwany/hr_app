import 'package:dio/dio.dart';

import 'Constants.dart';

class ApiManager {
  Dio dio = Dio();

  Future<Response> getData({Map<String, dynamic>? data}) async {
    return await dio.get(
      Constants.baseUrl ,
      data:data ,
      options: Options(
        headers: {
          'Content-Type':"application/json",
          "User-Agent":"insomnia/10.1.1"
        },
      ),
    );
  }


  postData({Map<String, dynamic>? body}) async {
    return  await dio.post(
      Constants.baseUrl ,
      data: body,
      options: Options(
        headers: {
          'Content-Type':"application/json",
          "User-Agent":"insomnia/10.1.1"
        },
      ),
    );
  }

}