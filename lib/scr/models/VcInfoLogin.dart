import 'dart:io';
import 'package:app_qltpdt_flutter/utils/api_link.dart';
import 'package:app_qltpdt_flutter/utils/vc_const.dart';
import 'package:dio/dio.dart';

class Dicimal{
  int pt=0;
  int ty_le=0;
  int ty_gia=2;
  int so_luong=2;
  int gia_nt=2;
  int gia=2;
  int tien_nt=2;
  int tien=0;
}

class VcInfoLogin{
  String ip="";
  String dvcs="";
  String userName="";
  String password="";
  String token="";
  String error="";
  String lang="";
  String tu_ngay1="";
  String den_ngay1="";
  String timKhongDau="K";
  String tu_ngay01="";
  String den_ngay01="";
  int minYear=0;
  int maxYear=0;
  String currentYear="";
  Dicimal dicimal=new Dicimal();

  void _setFromJson(_ip, _dvcs, _userName, _password,_timKhongDau,Map<String, dynamic> json){
    String _token=json.containsKey("token")?json["token"]:"";
    String _error=json.containsKey("error")?json["error"]:"";
    this.ip=_ip;
    this.dvcs=_dvcs;
    this.userName=_userName;
    this.password=_password;
    this.token=_token;
    this.error=_error;
    this.timKhongDau=_timKhongDau;
    this.tu_ngay1=VcConst.getDateToString(DateTime(DateTime.now().year),format: "yyyy-MM-dd");
    this.den_ngay1=VcConst.getDateToString(DateTime(DateTime.now().year,12,31),format: "yyyy-MM-dd");
    this.minYear=DateTime.now().year-10; // chọn thời gian trước 10 năm so với năm hiện tại
    this.maxYear=DateTime.now().year+10; // đến sau 10 năm so với năm hiện tại
    this.currentYear=(DateTime.now().year).toString();
  }


  void _setWithError(String _error){
    this.ip="";
    this.dvcs="";
    this.userName="";
    this.password="";
    this.token="";
    this.error=_error;
  }


  setLang(String lang){
    this.lang=lang;
  }
  //
  void _getDicimal() async {
    // có thể lấy các giá trị khai báo về dấu thập phân ở đây để gán cho hệ thống...
  }
  void getInfoLogin(String baseUrl,String dvcs,String userName,String password,String timKhongDau) async {
    final Dio _dio = Dio();
    try {
      var formData = {
        "dvcs": dvcs,
        "username": userName,
        "pass": password,
      };
      Response response = await _dio.post(baseUrl+VcApiLink.LOGIN_ACCOUT,
          data: formData,
          options: new Options(contentType:ContentType.parse("application/x-www-form-urlencoded"))
      );
      Map<String,dynamic> _login=response.data;
      if (_login.containsKey("error")){
        _setWithError("${_login["error"]}");
      }else{
        await _setFromJson(baseUrl,dvcs,userName,password,timKhongDau,_login);
        _getDicimal();
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      _setWithError("$error");
    }
  }
  String getToken(){
    return token.isEmpty?"":"Bear $token;$dvcs;$currentYear;$lang";
  }
  // có lỗi.
  bool hasError()=>error.isNotEmpty;
}

final vcInfoLogin=VcInfoLogin();