import 'package:app_qltpdt_flutter/scr/models/VcInfoLogin.dart';
import 'package:app_qltpdt_flutter/utils/api_link.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_badge/flutter_badge.dart';

class ItemMenu extends StatefulWidget{
  final String query;
  final IconData iconData;
  final Color iconColor;
  final Color backgroundColor;
  final Widget title;
  final Widget subtitle;
  final GestureTapCallback onTap;
  ItemMenu({
    this.query="",
    @required this.iconData,
    this.iconColor,
    this.backgroundColor,
    @required this.title,
    this.subtitle,
    this.onTap
  });
  @override
  _ItemMenuState createState()=>_ItemMenuState();
}

class _ItemMenuState extends State<ItemMenu>{
  int _count=0;
  bool loading=true;
  @override
  void initState() {
    super.initState();
  }
  void _getNumberItem() async {
    if (!this.mounted) return;
    final Dio _dio = Dio();
    if (widget.query.isEmpty) return;
    try {
      Response response = await _dio.get(
        vcInfoLogin.ip+VcApiLink.GET_EXECUTE_QUERY+Uri.encodeComponent(widget.query),
        options: Options(
          headers: {
            "Authorization":vcInfoLogin.getToken()
          }
        )
      );
      if (!this.mounted) return;
      setState(() {
        _count=(response.data as List<dynamic>)[0]["ROW_COUNT"];
      });
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }
  @override
  Widget build(BuildContext context) {
    _getNumberItem();
    return Card(
      margin: EdgeInsets.only(left: 5.0,top: 0.0,right: 5.0,bottom: 5.0),
      child: Badge(
        number: _count,
        visible: (_count>0),
        backgroundColor:widget.backgroundColor??Theme.of(context).accentColor,
        showExactNumber: true,
        showShadow: true,
        child:ListTile(
          contentPadding: EdgeInsets.only(left: 10.0),
          leading: Icon(widget.iconData,color : widget.iconColor??Color(0xFF42A5F5)) ,
          title: widget.title,
          subtitle: widget.subtitle,
          onTap:widget.onTap,
        ),
      )
    );
  }
}