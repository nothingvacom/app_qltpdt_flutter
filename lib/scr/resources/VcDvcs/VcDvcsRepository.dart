import 'VcDvcsApiProvider.dart';
import 'VcDvcsResponse.dart';

class VcDvcsRepository{
  final _apiProvider = VcDvcsApiProvider();
  Future<VcDvcsResponse> getAllDvcs(String baseUrl){
    return _apiProvider.getAllDvcs(baseUrl);
  }
}