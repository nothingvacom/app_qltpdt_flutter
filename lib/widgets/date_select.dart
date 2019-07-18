
import 'package:app_qltpdt_flutter/scr/models/VcInfoLogin.dart';
import 'package:app_qltpdt_flutter/utils/vc_const.dart';
import 'package:flutter/material.dart';

class DateSelect extends StatefulWidget{
  final String value; // yyyy-MM-dd
  final Function onResult;
  final int firstYear;
  final int lastYear;
  final TextStyle style;
  const DateSelect({Key key,@required this.value,@required this.onResult,this.firstYear,this.lastYear, this.style});

  @override
  _DataSelectState createState()=>_DataSelectState();
}

class _DataSelectState extends State<DateSelect>{
  DateTime _value;
  int _firstYear,_lastYear;
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _value??DateTime.now(),
        firstDate: DateTime(_firstYear),
        lastDate: DateTime(_lastYear,12,31)
    );

    if ((_value==null) || (picked != null && picked != _value)){
      setState(() {
        _value = picked;
      });
      widget.onResult(VcConst.getDateToString(picked,format: "yyyy-MM-dd"));
    }
  }

  @override
  void initState() {
    super.initState();
    _firstYear=widget.firstYear??vcInfoLogin.minYear;
    _lastYear=widget.lastYear??vcInfoLogin.maxYear;
  }

  @override
  Widget build(BuildContext context) {
    _value=VcConst.getStringToDate(widget.value); //DateTime.now();
    return Card(
      child: InkWell(
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child:Text(VcConst.getDateToString(_value),style: widget.style??Theme.of(context).textTheme.body1)
        ),
        onTap: ()=>_selectDate(context),
      )
    );
  }
}