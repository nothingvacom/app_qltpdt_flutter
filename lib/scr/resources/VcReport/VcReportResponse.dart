
import 'package:app_qltpdt_flutter/scr/models/VcReport.dart';

class VcReportResponse{
  final List<VcReport> results;
  final String error;
  VcReportResponse():results = List(), error = "";
  VcReportResponse.fromJson(List<dynamic> jsonList)
      : results =(jsonList).map((i) => new VcReport.fromJson(i)).toList(), error = "";

  VcReportResponse.withError(String errorValue)
      : results = List(), error = errorValue;

}