import 'package:app_qltpdt_flutter/scr/models/VcDm.dart';

class VcDmResponse{
  final List<VcDm> results;
  final int totalCount;
  final String error;

  VcDmResponse.fromJson(List<dynamic> jsonList,{String ma:"MA",String ten:"TEN"})
      : results =(jsonList).map((i) => new VcDm.fromJson(i,ma: ma,ten: ten)).toList(), error = "",
        totalCount=0;

  VcDmResponse.fromJsonPage(Map<String,dynamic> jsonList):
        results=(jsonList['data'] as List).map((i) => new VcDm.fromJson(i)).toList(),
        error = "",
        totalCount=jsonList.containsKey('total_count')?jsonList['total_count']:0;

  VcDmResponse.withError(String errorValue)
      : results = List(), error = errorValue,totalCount=0;
}