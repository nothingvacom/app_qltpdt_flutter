import 'package:app_qltpdt_flutter/scr/models/VcInfoLogin.dart';
import 'package:app_qltpdt_flutter/widgets/CheckBoxTitle.dart';
import 'package:app_qltpdt_flutter/widgets/fromdate_todate.dart';
import 'package:flutter/material.dart';
class ModalFilterThuHocPhi extends StatefulWidget{
  final Map<String,dynamic> params;
  final Function onRefresh;
  const ModalFilterThuHocPhi({this.params=const {},this.onRefresh});
  @override
  _ModalFilterThuHocPhiState createState()=>_ModalFilterThuHocPhiState();
}
class _ModalFilterThuHocPhiState extends State<ModalFilterThuHocPhi>{
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      child: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 20.0,top: 8.0,right: 20.0,bottom: 8.0),
            child: Column(
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:<Widget>[
                      FromDateToDate(
                        from: vcInfoLogin.tu_ngay1,
                        to:vcInfoLogin.den_ngay1,
                        onResultFrom: (String _fromDate){
                          setState(() {
                            vcInfoLogin.tu_ngay1=_fromDate;
                          });
                        },
                        onResultTo: (String _toDate){
                          setState(() {
                            vcInfoLogin.den_ngay1=_toDate;
                          });
                        },
                        onSetDate: (String _fromDate,String _toDate){
                          setState(() {
                            vcInfoLogin.tu_ngay1=_fromDate;
                            vcInfoLogin.den_ngay1=_toDate;
                          });
                        },
                      ),
                      IconButton(icon: Icon(Icons.refresh),color: Colors.redAccent, onPressed: (){
                        Navigator.pop(context);
                        Map<String,dynamic> _params={
                          "TU_NGAY":vcInfoLogin.tu_ngay1,
                          "DEN_NGAY":vcInfoLogin.den_ngay1
                        };
                        widget.onRefresh(_params);
                      })
                    ]
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
