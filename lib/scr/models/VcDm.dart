import 'VcRow.dart';
class VcDm extends VcRow{
  final String ma;
  final String ten;
  VcDm(Map<String, dynamic> json,{this.ma, this.ten}):super(json);
  VcDm.fromJson(Map<String, dynamic> json,{String ma:"MA",String ten:"TEN"}):
      ma=json.containsKey(ma)?json[ma]:"",
      ten=json.containsKey(ten)?json[ten]:"",
      super(json);
}