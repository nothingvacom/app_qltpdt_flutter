import 'package:app_qltpdt_flutter/scr/models/VcReport.dart';
import 'package:flutter/material.dart';
class ItemThuHocPhi extends StatelessWidget{
  final VcReport data;
  final int index;
  ItemThuHocPhi({this.data,this.index}){
    // khai báo các biến...
  }
  @override
  Widget build(BuildContext context) {
    return Text(data.json.toString());
  }
}