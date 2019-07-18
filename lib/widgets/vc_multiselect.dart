import 'package:app_qltpdt_flutter/scr/resources/VcDm/VcDmRepository.dart';
import 'package:app_qltpdt_flutter/scr/resources/VcDm/VcDmResponse.dart';
import 'package:app_qltpdt_flutter/utils/all_translations.dart';
import 'package:flutter/material.dart';
class _ListItem{
  final String ma;
  final String ten;
  _ListItem(this.ma,this.ten,this.checked);
  bool checked;
}
class VcMultiSelect extends StatefulWidget{
  final String listValue;
  final String query;
  final Map<String,dynamic> oRef;
  final Function onChange;
  const VcMultiSelect({Key key,@required this.listValue,this.query,this.oRef,this.onChange});
  @override
  _VcMultiSelectState createState()=>_VcMultiSelectState();
}
class _VcMultiSelectState extends State<VcMultiSelect>{
  List<_ListItem> _datas=new List<_ListItem>();
  String listValue;
  bool loading=true;
  String buttonLabel=allTranslations.text("btn_ok");
  @override
  void initState() {
    listValue=listValue??widget.listValue;
    if (widget.oRef!=null){
      _getDataRef();
    }else{
      _getData();
    }
    super.initState();
  }
  void _getDataRef() async{
    final VcDmRepository _repository=VcDmRepository();
    VcDmResponse _vcDmResponse=await _repository.getRefId(widget.oRef["refId"]);
    List<String> _listCodeSelected=listValue.split(",");
    _datas.addAll(_vcDmResponse.results.map((row)=>_ListItem(row.jsonBase[widget.oRef["id"]],row.jsonBase[widget.oRef["value"]],(_listCodeSelected.indexOf(row.jsonBase[widget.oRef["id"]])>=0)?true:false)).toList());
    setState(() {
      loading=false;
    });
  }
  void _getData() async{
    final VcDmRepository _repository=VcDmRepository();
    VcDmResponse _vcDmResponse=await _repository.getQuery(widget.query);
    List<String> _listCodeSelected=listValue.split(",");
    _datas.addAll(_vcDmResponse.results.map((row)=>_ListItem(row.ma,row.ten,(_listCodeSelected.indexOf(row.ma)>=0)?true:false)).toList());
    setState(() {
      loading=false;
    });
  }
  void _onChange(){
    String _listValue="";
    _datas.forEach((item){
      if (item.checked) _listValue+=",${item.ma}";
    });
    if (_listValue.length>0){
      _listValue=_listValue.substring(1);
    }
    setState(() {
      listValue=_listValue;
    });
    if (widget.onChange!=null) widget.onChange(listValue);
  }
  void _openMultySelect(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text(allTranslations.text("title_choise")),
          contentPadding:const EdgeInsets.all(10.0),
          content: _ContentAlertDialog(datas: _datas,onTap: ()=>_onChange()),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(buttonLabel),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0.0),
      child: InkWell(
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child:Text(listValue,softWrap: false,overflow: TextOverflow.ellipsis)
              ),
              Icon(Icons.content_copy,color: Theme.of(context).buttonColor,)
            ],
          )
        ),
        onTap: ()=>_openMultySelect(context),
      ),
    );
  }
}

class _ContentAlertDialog extends StatefulWidget{
  final List<_ListItem> datas;
  final GestureTapCallback onTap;
  _ContentAlertDialog({this.datas,this.onTap});
  @override
  _ContentAlertDialogState createState() =>_ContentAlertDialogState();
}
class _ContentAlertDialogState extends State<_ContentAlertDialog>{
  bool _checkAll=false;
  void _setCheckAll(){
    setState(() {
      _checkAll=!_checkAll;
      int _len=widget.datas.length;
      for(int i=0;i<_len;i++){
        widget.datas[i].checked=_checkAll;
      }
    });
    if (widget.onTap!=null) widget.onTap();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView.builder(
        itemBuilder: (context,index)=>InkWell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(widget.datas[index].checked?Icons.check_box:Icons.check_box_outline_blank,color: widget.datas[index].checked?Theme.of(context).buttonColor:Theme.of(context).disabledColor),
              Flexible(
                child:Text(" ${widget.datas[index].ten}",softWrap: false,overflow: TextOverflow.ellipsis)
              )
            ],
          ),
          onTap: (){
            setState(() {
              widget.datas[index].checked=!widget.datas[index].checked;
            });
            if (widget.onTap!=null) widget.onTap();
          },
        ),
        itemCount: widget.datas.length,
      ),
      bottomNavigationBar: Card(
        elevation: 0.0,
        child: InkWell(
          child:Padding(
            padding: EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(_checkAll?Icons.check_box:Icons.check_box_outline_blank,color: Theme.of(context).buttonColor),
                Flexible(
                    child:Text(" ${allTranslations.text("choise_all")}",softWrap: false,overflow: TextOverflow.ellipsis)
                )
              ],
            ),
          ),
          onTap:()=>_setCheckAll(),
        )
      )
    );
  }
}