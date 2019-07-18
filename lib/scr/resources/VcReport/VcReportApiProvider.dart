
import 'dart:async';
import 'package:app_qltpdt_flutter/scr/models/VcInfoLogin.dart';
import 'package:dio/dio.dart';

import 'VcReportResponse.dart';
class VcReportApiProvider{
  final Dio _dio = Dio();
  Future<VcReportResponse> getAll(Map<String,dynamic> body,{String linkApi}) async {
    try {
      Response response = await _dio.post(
          vcInfoLogin.ip+linkApi,
          data: body,
          options: Options(
              headers: {
                "Authorization":vcInfoLogin.getToken()
              }
          )
      );
      switch (linkApi) {
        case "/api/Bcthsd/bangkebanra":
          return VcReportResponse.fromJson(response.data["data"]);
          break;
        default:
          return VcReportResponse.fromJson(response.data);
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return VcReportResponse.withError("$error");
    }
  }
}