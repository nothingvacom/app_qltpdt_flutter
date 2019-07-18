
import 'dart:async';
import 'package:app_qltpdt_flutter/utils/api_link.dart';
import 'package:dio/dio.dart';

import 'VcDvcsResponse.dart';
class VcDvcsApiProvider{
  final Dio _dio = Dio();
  Future<VcDvcsResponse> getAllDvcs(String baseUrl) async {
    try {
      Response response = await _dio.get(baseUrl+VcApiLink.GET_ALL_DVCS);
      return VcDvcsResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return VcDvcsResponse.withError("$error");
    }
  }
}