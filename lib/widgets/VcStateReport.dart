import 'package:app_qltpdt_flutter/scr/models/VcReport.dart';
import 'package:app_qltpdt_flutter/scr/models/VcRow.dart';
import 'package:app_qltpdt_flutter/scr/resources/VcReport/VcReportBody.dart';
import 'package:app_qltpdt_flutter/scr/resources/VcReport/VcReportRepository.dart';
import 'package:app_qltpdt_flutter/scr/resources/VcReport/VcReportResponse.dart';
import 'package:app_qltpdt_flutter/utils/vc_dialog.dart';
import 'package:app_qltpdt_flutter/widgets/report_begin_load_widget.dart';
import 'package:flutter/material.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';

import 'bottom_sheet_fix.dart';
import 'build_loading_widget.dart';
import 'build_no_data_widget.dart';

abstract class VcStateReport<T extends StatefulWidget> extends State<T>{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final VcReportRepository _repository=VcReportRepository();
  final ScrollController _scrollController = ScrollController();
  VcReportResponse _vcReportResponse=VcReportResponse();
  List<VcReport> _datas=new List<VcReport>();
  bool _loading=false;
  bool _beginLoad=true;
  bool _displayButtonFilter=true;
  Map<String,dynamic> _body;
  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle;
  Widget getTitle();
  TypeReports _typeReports;
  String getTypeReports();
  Map<String,dynamic> _params={};
  Map<String, dynamic> getParams() => _params;
  String _linkApi;
  TypeReports typeReportsGet(){
    return _typeReports;
  }

  void setDisplayButtonFilter(bool display){
    _displayButtonFilter=display;
  }
  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          controller: _filter,
          autocorrect: false,
          keyboardType: TextInputType.text,
          style: Theme.of(context).textTheme.subhead,
          autofocus: true,
          textCapitalization: TextCapitalization.none,
          decoration: new InputDecoration.collapsed(
              hintText: 'Tìm mọi thứ...'),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = getTitle();
        _filter.clear();
      }
    });
  }

  void vcInitState(){}

  @override
  void initState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        _searchText = "";
      } else {
        _searchText = _filter.text.trim();
      }
      if (!_loading) _filterInfo();
    });
    _typeReports=_repository.listTypeReports[getTypeReports()];
    _body=_repository.getBody(_typeReports);
    _appBarTitle=getTitle();
    _linkApi=_repository.linkApis[getTypeReports()];
    super.initState();
    vcInitState();
  }

  void setParameters(Map<String,dynamic> params){
    this._params=params;
    _beginLoad=false;
    params.forEach((key,value){
      if (_body.containsKey("parameters")){
        if (_body["parameters"].containsKey(key)) _body["parameters"][key]=value;
      }else{
        if (_body.containsKey(key)) _body[key]=value;
      }
    });
    refresh();
  }
  void _filterInfo(){
    _datas.clear();
    setState(() {
      _loading=true;
    });
    _datas.addAll(_vcReportResponse.results.where((VcReport vcReport)=>(_searchText.isEmpty)?true:vcReport.textSearch.contains(VcRow.catDau(_searchText))).toList());
    setState(() {
      _loading=false;
    });
  }
  void refresh() async {
    _datas.clear();
    if (!this.mounted) return;
    setState(() {
      _loading=true;
    });
    _vcReportResponse=await _repository.getAll(_body,linkApi:_linkApi);
    if (_vcReportResponse.error.isNotEmpty){
      if (_scaffoldKey.currentContext!=null){
        VcDialog.showDialogSingleButton(_scaffoldKey.currentContext, _vcReportResponse.error);
      }
    }else {
      _datas.addAll(
          _vcReportResponse.results.where((VcReport vcReport) => (_searchText
              .isEmpty) ? true : vcReport.json.toString().contains(_searchText))
              .toList());
    }
    if (!this.mounted) return;
    setState(() {
      _loading=false;
    });
  }

  Widget getModalBottomSheet(BuildContext context){
    return _repository.getModalBottomSheet(context, _typeReports,params: this._params,onRefresh: setParameters);
  }

  Widget getItemView(VcReport vcReport,int index){
    return _repository.getItemView(_typeReports, vcReport, index);
  }

  Widget getOtherView(List<VcReport> datas){
    return _repository.getOtherView(_typeReports, datas);
  }

  Function clickItem(BuildContext context,VcReport vcReport,int index){}

  @override
  Widget build(BuildContext context) {
    Widget _showModalBottomSheet(BuildContext context){
      return getModalBottomSheet(context);
    }
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: _appBarTitle,
        elevation:0.5,
        actions: <Widget>[
          IconButton(
            icon: _searchIcon,
            onPressed: _searchPressed,
          )
        ],
      ),
      body: _loading? BuildLoadingWidget(color: Theme.of(context).buttonColor):
      (_datas.length==0)?(_beginLoad)?ReportBeginLoad(context):BuildNoDataWidget(context):
      (getOtherView(_datas)!=null)?getOtherView(_datas):DraggableScrollbar.semicircle(
        controller: _scrollController,
        labelTextBuilder: (double offset){
          int currentItem = _scrollController.hasClients
              ? (_scrollController.offset /
              _scrollController.position.maxScrollExtent *
              _datas.length)
              .floor()
              : 0;
          if (currentItem>=_datas.length) currentItem=_datas.length-1;
//          VcReport _row=_datas[currentItem];
//          String _date=_row.converDate(VcRow.getString(_row.json, "NGAY_CT"));
          return Text("${currentItem+1}",style: Theme.of(context).textTheme.caption.apply(color: Colors.grey[400]));
        },
        child:ListView.builder(
          controller: _scrollController,
          itemBuilder:(context,index)=>(index<_datas.length)?Card(
            margin: EdgeInsets.only(left: 4.0,top: 2.0,right: 4.0,bottom: 2.0),
            elevation: 0.5,
            child:InkWell(
                onTap: ()=>clickItem(context,_datas[index],index),
                child:Padding(
                    padding: EdgeInsets.all(10.0),
                    child:getItemView(_datas[index],index)
                )
            ),
          ):SizedBox(height: 80.0),
          itemCount: _datas.length+1,
        ),
      ),
      floatingActionButton:(_displayButtonFilter)?FloatingActionButton(
        foregroundColor: Theme.of(context).iconTheme.color,
        backgroundColor: Theme.of(context).accentIconTheme.color,
        onPressed: (){
          showModalBottomSheetApp(
            context: context,
            builder: (BuildContext context)=>_showModalBottomSheet(context)
          );
        },
        tooltip: 'Search',
        child: Icon(Icons.search),
      ):null
    );
  }
}