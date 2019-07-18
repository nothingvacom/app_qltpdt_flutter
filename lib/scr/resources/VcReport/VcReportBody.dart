import 'package:app_qltpdt_flutter/scr/models/VcReport.dart';
import 'package:app_qltpdt_flutter/utils/api_link.dart';
import 'VcReportParams.dart';
import 'package:flutter/material.dart';
import 'package:app_qltpdt_flutter/scr/listviewitems/reports/item_export.dart';
import 'package:app_qltpdt_flutter/scr/listviewitems/reports_show_filter/modal_export.dart';
enum TypeReports {
  ThuHocPhi
}
class VcReportBody extends VcReportParams{
  // body bảng kê bán ra
  Map<String,dynamic> getBody(TypeReports typeReports,{Map<String,dynamic> params=const {}}){
    Map<String,dynamic> _body={};
    switch(typeReports){
      case TypeReports.ThuHocPhi: return _setParameters(THU_HOC_PHI,params);
    }
    return _body;
  }

  Widget getItemView(TypeReports typeReports,VcReport vcReport,int index){
    switch(typeReports){
      case TypeReports.ThuHocPhi: return ItemThuHocPhi(data: vcReport,index: index);
    }
    return null;
  }
  Widget getOtherView(TypeReports typeReports,List<VcReport> datas){
    return null;
  }
  Widget getModalBottomSheet(BuildContext context,TypeReports typeReports,{Map<String,dynamic> params=const {},Function onRefresh}){
    switch(typeReports){
      case TypeReports.ThuHocPhi: return ModalFilterThuHocPhi(params: params,onRefresh:onRefresh);
    }
    return null;
  }

  Map<String,dynamic> _setParameters(final Map<String,dynamic> body,final Map<String,dynamic> params){
    Map<String,dynamic> _body=body;
    params.forEach((key,value){
      if (_body["parameters"].containsKey(key)) _body["parameters"][key]=value;
    });
    return _body;
  }

  final Map<String,TypeReports> listTypeReports={
    "thu_hoc_phi":TypeReports.ThuHocPhi
  };
  final Map<String,String> linkApis={
    "thu_hoc_phi":VcApiLink.POST_CREATE_REPORT
  };
}