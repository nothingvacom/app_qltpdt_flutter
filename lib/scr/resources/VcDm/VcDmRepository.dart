import 'package:app_qltpdt_flutter/scr/models/VcInfoLogin.dart';
import 'VcDmApiProvider.dart';
import 'VcDmResponse.dart';

const int TOP=10;
enum LstDm {
  KhoaHoc
}
class VcDmRepository{
  final _apiProvider = VcDmApiProvider();

  Future<VcDmResponse> getRefId(Map<String,dynamic> _param){
    return _apiProvider.getRefId(_param);
  }

  Future<VcDmResponse> getQuery(String _query){
    return _apiProvider.getAllDm(_query);
  }

  Future<VcDmResponse> getAllDm(String _textSearch,LstDm _type){
    String _query=_getQuery(_textSearch, _type);
    return _apiProvider.getAllDm(_query);
  }

  Future<VcDmResponse> getAllPage(Map<String,dynamic> body){
    return _apiProvider.getAllPage(body);
  }

  String _getQuery(String _textSearch,LstDm _type){
    String _query="";
    if (_textSearch.isNotEmpty){
      switch(_type){
        case LstDm.KhoaHoc:
          _query=_SEARCH_DM_KHOA_HOC.replaceAll('#VALUE#',_textSearch.trim());
          break;
      }
    }
    return _query;
  }
  //
  final String _SEARCH_DM_KHOA_HOC="SELECT TOP ${TOP} MA_KHOA_HOC MA,TEN_KHOA_HOC TEN "
      "FROM KHOA_HOC WHERE MA_DVCS='${vcInfoLogin.dvcs}' AND MA_KHOA_HOC LIKE N'%#VALUE#%' "
      "ORDER BY MA_KHOA_HOC";

  static const Map<String,String> WINDOW_IDS={
    "khoa_hoc":"WIN00217",
    "khoan_thu":"WIN00215",
    "lop":"WIN00216",
    "sinh_vien":"WIN00218"
  };
  static const Map<String,String> TITLE_WINDOW_IDS={
    "khoa_hoc":"Danh sách khóa học",
    "khoan_thu":"Khoản thu",
    "lop":"Lớp",
    "sinh_vien":"Sinh viên"
  };
}