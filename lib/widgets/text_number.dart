import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'VcRowWidget.dart';
import 'WidgetFlex.dart';

class TextNumber extends  StatelessWidget{
  final double value;
  final int dicimal;
  final TextStyle style;
  final String displayEmpty;
  final Widget leading;
  final Widget trailing;
  const TextNumber({Key key,@required this.value,this.dicimal,this.style,this.displayEmpty:"0",this.leading,this.trailing});
  @override
  Widget build(BuildContext context) {
    String _formatter;
    if (value==null || value!=0){
      String _format="##,###,###,###,###,###";
      if (dicimal !=null && dicimal>0){
        _format+=".";
        for (int i=0;i<dicimal;i++){
          _format+="#";
        }
      }
      _formatter = new NumberFormat(_format).format(value).replaceAll(".", "*").replaceAll(",", ".").replaceAll("*", ",");
    }else{
      _formatter=displayEmpty;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        (leading!=null)?leading:null,
        Text(_formatter,style: style==null?Theme.of(context).textTheme.caption:style),
        (trailing!=null)?trailing:null,
      ].where(notNull).toList(),
    );
  }
  bool notNull(Object o) => o != null;
}