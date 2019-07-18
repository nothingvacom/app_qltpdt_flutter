import 'dart:async';
import 'package:app_qltpdt_flutter/scr/models/VcInfoLogin.dart';
import 'package:app_qltpdt_flutter/utils/api_link.dart';
import 'package:dio/dio.dart';

import 'VcDmResponse.dart';
class VcDmApiProvider{
  final Dio _dio = Dio();

  Future<VcDmResponse> getRefId(Map<String,dynamic> _param) async {
    String _id=_param["id"];
    String _ma=_param["ma"];
    String _ten=_param["ten"];
    String _filter_value=_param.containsKey("filter_value")? _param["filter_value"]:"";
    if (_id.isEmpty) return VcDmResponse.withError("Empty query ...!");
    try {
      Response response = await _dio.get(
          vcInfoLogin.ip+VcApiLink.GET_DATA_BY_REFERENCE+_id+((_filter_value.isEmpty)?"":"&filter[value]="+Uri.encodeComponent(_filter_value)),
          options: Options(headers: {"Authorization":vcInfoLogin.getToken()})
      );
      return VcDmResponse.fromJson(response.data,ma: _ma,ten: _ten);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return VcDmResponse.withError("$error");
    }
  }

  Future<VcDmResponse> getAllDm(String _sql) async {
    if (_sql.isEmpty) return VcDmResponse.withError("Empty query ...!");
    try {
      Response response = await _dio.get(
        vcInfoLogin.ip+VcApiLink.GET_EXECUTE_QUERY+Uri.encodeComponent(_sql),
          options: Options(headers: {"Authorization":vcInfoLogin.getToken()})
      );
      return VcDmResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return VcDmResponse.withError("$error");
    }
  }
  Future<VcDmResponse> postAllPage(Map<String,dynamic> body) async {
    try {
      Response response = await _dio.post(
          vcInfoLogin.ip+VcApiLink.POST_DATA_BY_WINDOW_NO,
          data: body,
          options: Options(headers: {"Authorization":vcInfoLogin.getToken()})
      );
      return VcDmResponse.fromJsonPage(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return VcDmResponse.withError("$error");
    }
  }
  Future<VcDmResponse> getAllPage(Map<String,dynamic> body) async {
    try {
      Response response = await _dio.get(
          vcInfoLogin.ip+VcApiLink.POST_DATA_BY_WINDOW_NO+_getBodyParam(body),
          options: Options(headers: {"Authorization":vcInfoLogin.getToken()})
      );
      return VcDmResponse.fromJsonPage(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return VcDmResponse.withError("$error");
    }
  }
  String _getBodyParam(Map<String,dynamic> body){
    String _params="?";
    int i=0;
    body.forEach((key,value){
      if (i>0) _params+="&";
      _params+=key+"="+value.toString();
      i++;
    });
    return _params;
  }
}