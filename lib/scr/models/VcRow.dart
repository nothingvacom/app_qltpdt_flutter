import 'package:app_qltpdt_flutter/utils/vc_const.dart';
import 'VcInfoLogin.dart';

const List<String> _CO_DAU=[
      "á", "à", "ả", "ã", "ạ", "â", "ấ", "ầ", "ẩ", "ẫ", "ậ", "ă", "ắ", "ằ", "ẳ", "ẵ", "ặ",
      "đ", "é","è","ẻ","ẽ","ẹ","ê","ế","ề","ể","ễ","ệ", "í","ì","ỉ","ĩ","ị",
      "ó","ò","ỏ","õ","ọ","ô","ố","ồ","ổ","ỗ","ộ","ơ","ớ","ờ","ở","ỡ","ợ",
      "ú","ù","ủ","ũ","ụ","ư","ứ","ừ","ử","ữ","ự", "ý","ỳ","ỷ","ỹ","ỵ"," "
];
const List<String> _KHONG_DAU=[
      "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a", "a",
      "d", "e","e","e","e","e","e","e","e","e","e","e", "i","i","i","i","i",
      "o","o","o","o","o","o","o","o","o","o","o","o","o","o","o","o","o",
      "u","u","u","u","u","u","u","u","u","u","u", "y","y","y","y","y",""
];
class VcRow{
  final Map<String, dynamic> jsonBase;
  VcRow(json):jsonBase=json;

  dynamic get1(String key,{dynamic defaultValue:"",Map<String, dynamic> json}){
    if (json==null) json=jsonBase;
    return json.containsKey(key)?(json[key]??defaultValue):defaultValue;
  }

  dynamic get(String key,{dynamic defaultValue:"",Map<String, dynamic> json}){
    if (json==null) json=jsonBase;
    return json.containsKey(key)?(json[key]??defaultValue):defaultValue;
  }
  String getString(String key,{String defaultValue:"",Map<String, dynamic> json}){
    if (json==null) json=jsonBase;
    dynamic _value=json.containsKey(key)?(json[key]??defaultValue):defaultValue;
    return (_value.runtimeType==String)?_value:defaultValue;
  }
  int getInt(String key,{int defaultValue:0,Map<String, dynamic> json}){
    if (json==null) json=jsonBase;
    dynamic _value=json.containsKey(key)?(json[key]??defaultValue):defaultValue;
    return (_value.runtimeType==int)?_value:defaultValue;
  }
  double getDouble(String key,{double defaultValue:0.0,Map<String, dynamic> json}){
    if (json==null) json=jsonBase;
    dynamic _value=json.containsKey(key)?(json[key]??defaultValue):defaultValue;
    return (_value.runtimeType==double)?_value:defaultValue;
  }
  bool getBool(String key,{bool defaultValue:false,Map<String, dynamic> json}){
    if (json==null) json=jsonBase;
    dynamic _value=json.containsKey(key)?(json[key]??defaultValue):defaultValue;
    return (_value.runtimeType==bool)?_value:defaultValue;
  }
  String converDate(final String ngay_ct){
    return ngay_ct.isEmpty?"":VcConst.getDateToString(VcConst.getStringToDate(ngay_ct));
  }
  static String catDau(final String _str){
    String _strReturn=_str.toLowerCase();
    if (vcInfoLogin.timKhongDau.contains("C")){
      int _len=_CO_DAU.length;
      for (int i=0;i<_len;i++){
        _strReturn=_strReturn.replaceAll(_CO_DAU[i], _KHONG_DAU[i]);
      }
    }
    return _strReturn;
  }
}