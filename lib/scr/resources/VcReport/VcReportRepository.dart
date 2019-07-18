
import 'VcReportApiProvider.dart';
import 'VcReportBody.dart';
import 'VcReportResponse.dart';

class VcReportRepository extends VcReportBody{
  final _apiProvider = VcReportApiProvider();
  Future<VcReportResponse> getAll(Map<String,dynamic> body,{String linkApi}){
    return _apiProvider.getAll(body,linkApi:linkApi);
  }
}