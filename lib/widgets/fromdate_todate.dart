import 'package:app_qltpdt_flutter/scr/models/VcInfoLogin.dart';
import 'package:app_qltpdt_flutter/utils/vc_const.dart';
import 'package:flutter/material.dart';

import 'date_select.dart';
class FromDateToDate extends StatefulWidget{
  final String from;
  final String to;
  final Function onResultFrom;
  final Function onResultTo;
  final Function onSetDate;
  final int firstYear;
  final int lastYear;
  final bool displaySelectTime;
  final TextStyle styleFrom;
  final TextStyle styleTo;
  final bool vertical;
  final int year;
  const FromDateToDate({Key key,@required this.from,@required this.to,this.onResultFrom,this.onResultTo,this.onSetDate,this.firstYear,this.lastYear, this.displaySelectTime=true, this.styleFrom, this.styleTo, this.vertical:false,this.year});
  @override
  _FromDateToDate createState()=>_FromDateToDate();
}
class _FromDateToDate extends State<FromDateToDate>{
//  String from;
//  String to;
  int _firstYear,_lastYear,_year;
  @override
  void initState() {
//    from=from??widget.from;
//    to=to??widget.to;
    _firstYear=widget.firstYear??vcInfoLogin.minYear;
    _lastYear=widget.lastYear??vcInfoLogin.maxYear;
    _year=widget.year??DateTime.now().year;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final List<String> _titles=(vcInfoLogin.lang.contains("vi")?_titlesVi:_titlesEn);
    final List<PopupMenuItem<int>> _dropTime=_titles.map(
      (String _time)=>PopupMenuItem(
      value: _titles.indexOf(_time),
      child: Row(
        children: <Widget>[
          Text(_time,style: Theme.of(context)
              .textTheme
              .body2
              .apply(color: Theme.of(context).buttonColor))
        ],
      )
    )).toList();
    Function _onResultFrom(String date){
//      setState(() {
//        from=date;
//      });
      if (widget.onResultFrom!=null) widget.onResultFrom(date);
    }
    Function _onResultTo(String date){
//      setState(() {
//        to=date;
//      });
      if (widget.onResultTo!=null) widget.onResultTo(date);
    }
    return widget.vertical?Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(Icons.arrow_downward,color: Theme.of(context).buttonColor,),
        Column(
          children: <Widget>[
            DateSelect(
                firstYear: _firstYear,
                lastYear: _lastYear,
                value: widget.from,
                onResult: (String date)=>_onResultFrom(date),
                style: widget.styleFrom??Theme.of(context).textTheme.body1
            ),
            DateSelect(
                firstYear: _firstYear,
                lastYear: _lastYear,
                value: widget.to,
                onResult: (String date)=>_onResultTo(date),
                style: widget.styleTo??Theme.of(context).textTheme.body1
            ),
          ],
        ),
        widget.displaySelectTime?PopupMenuButton(
            onSelected: (int index)=>_onSelectTime(index),
            icon: Icon(Icons.access_time,color: Theme.of(context).buttonColor),
            itemBuilder: (BuildContext context)=>_dropTime
        ):null
      ].where(_notNull).toList(),
    ):Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        DateSelect(
          firstYear: _firstYear,
          lastYear: _lastYear,
          value: widget.from,
          onResult: (String date)=>_onResultFrom(date),
          style: widget.styleFrom??Theme.of(context).textTheme.body1
        ),
        Icon(Icons.navigate_next,color: Theme.of(context).buttonColor,),
        DateSelect(
          firstYear: _firstYear,
          lastYear: _lastYear,
          value: widget.to,
          onResult: (String date)=>_onResultTo(date),
          style: widget.styleTo??Theme.of(context).textTheme.body1
        ),
        widget.displaySelectTime?PopupMenuButton(
            onSelected: (int index)=>_onSelectTime(index),
            icon: Icon(Icons.access_time,color: Theme.of(context).buttonColor),
            itemBuilder: (BuildContext context)=>_dropTime
        ):null
      ].where(_notNull).toList(),
    );
  }

  bool _notNull(Object o) => o != null;

  _onSelectTime(int index){
    String _fromDate="";
    String _toDate="";
    // String _year=(new DateTime.now()).year.toString();
    if (index<12){
      int _thang=index+1;
      _fromDate="${_year}-${_thang<10?"0$_thang":"$_thang"}-01";
      if (_thang==12){
        _toDate="${_year}-12-31";
      }else{
        _toDate=VcConst.getDateToString(DateTime(_year,_thang+1,0),format: "yyyy-MM-dd");
      }

    }else{
      switch(index){
        case 12:{
          // Quy I
          _fromDate="${_year}-01-01";
          _toDate="${_year}-03-31";
        }
        break;
        case 13:{
          // Quy II
          _fromDate="${_year}-04-01";
          _toDate="${_year}-06-30";
        }
        break;
        case 14:{
          // Quy III
          _fromDate="${_year}-07-01";
          _toDate="${_year}-09-30";
        }
        break;
        case 15:{
          // Quy IV
          _fromDate="${_year}-10-01";
          _toDate="${_year}-12-31";
        }
        break;
        case 16:{
          // 6 thang dau nam
          _fromDate="${_year}-01-01";
          _toDate="${_year}-06-30";
        }
        break;
        case 17:{
          // 6 thang cuoi nam
          _fromDate="${_year}-07-01";
          _toDate="${_year}-12-31";
        }
        break;
        case 18:{
          // Ca nam
          _fromDate="${_year}-01-01";
          _toDate="${_year}-12-31";
        }
        break;
      }
    }
//    setState(() {
//      from=_fromDate;
//      to=_toDate;
//    });
    (widget.onSetDate!=null)?widget.onSetDate(_fromDate,_toDate):(){};
  }
}

const List<String> _titlesVi=[
  "Tháng 01",
  "Tháng 02",
  "Tháng 03",
  "Tháng 04",
  "Tháng 05",
  "Tháng 06",
  "Tháng 07",
  "Tháng 08",
  "Tháng 09",
  "Tháng 10",
  "Tháng 11",
  "Tháng 12",
  "Quý I",
  "Quý II",
  "Quý III",
  "Quý IV",
  "Sáu tháng đầu năm",
  "Sáu tháng cuối năm",
  "Cả năm"
];
const List<String> _titlesEn=[
  "Month 01",
  "Month 02",
  "Month 03",
  "Month 04",
  "Month 05",
  "Month 06",
  "Month 07",
  "Month 08",
  "Month 09",
  "Month 10",
  "Month 11",
  "Month 12",
  "Quater I",
  "Quater II",
  "Quater III",
  "Quater IV",
  "Six month begin year",
  "Six month end year",
  "All year"
];