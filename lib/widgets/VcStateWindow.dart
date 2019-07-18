import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
abstract class VcStateWindow<T extends StatefulWidget> extends State<T>{
  final GlobalKey<EasyRefreshState> easyRefreshKey = new GlobalKey<EasyRefreshState>();
  final GlobalKey<RefreshHeaderState> headerKey = new GlobalKey<RefreshHeaderState>();
  final GlobalKey<RefreshFooterState> footerKey = new GlobalKey<RefreshFooterState>();
  int pageSize=5;
  int totalPage;
  int currentPage=1;
  int totalCount;
  bool loading=true;

  Map<String,dynamic> body;

  void getMoreData() ;

  void nextPage() async {
    this.currentPage++;
    body["start"]=(currentPage-1)*pageSize;
    getMoreData();
  }

  void setFilter(String column,String filterValue,{String columnType="nvarchar"}){
    List<dynamic> _filter=[{"columnName": "$column", "columnType": "$columnType", "value": "$filterValue"}];
    body['filter']=_filter;
  }
  void setKyHieu(String _id){
    List<dynamic> _tblparam=[{"columnName":"inv_InvoiceCode_id","value":"$_id"}];
    body['tlbparam']=_tblparam;
  }

  void refresh() async {
    setState(() {
      loading=true;
    });
    this.currentPage=1;
    body["start"]=(currentPage-1)*pageSize;
    clearData();
    await getMoreData();
    setState(() {
      loading=false;
    });
  }

  void clearData();

  @override
  void initState() {
    vcInitState();
    pageSize=body.containsKey("count")?body["count"]:pageSize;
    refresh();
    super.initState();
  }

  void vcInitState();
}