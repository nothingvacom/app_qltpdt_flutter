import 'package:app_qltpdt_flutter/scr/models/VcDvcs.dart';

class VcDvcsResponse{
  final List<VcDvcs> results;
  final String error;
  VcDvcsResponse(this.results, this.error);

  VcDvcsResponse.fromJson(List<dynamic> jsonList)
      : results =(jsonList).map((i) => new VcDvcs.fromJson(i)).toList(), error = "";

//  VcDvcsResponse.fromJson(Map<String, dynamic> json)
//      : results =(json["results"] as List).map((i) => new VcDvcs.fromJson(i)).toList(), error = "";

  VcDvcsResponse.withError(String errorValue)
      : results = List(), error = errorValue;
}