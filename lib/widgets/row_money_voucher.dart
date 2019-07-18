import 'package:app_qltpdt_flutter/scr/models/VcInfoLogin.dart';
import 'package:app_qltpdt_flutter/widgets/text_number.dart';
import 'package:flutter/material.dart';
class RowMoneyVoucher extends StatelessWidget{
  final String title;
  final Widget wTitle;
  final double tien_nt;
  final double tien;
  final bool displayWhenZezo;
  final TextStyle style;
  final TextStyle style_nt;
  final bool displayCard;
  final GestureTapCallback onTap;
  const RowMoneyVoucher({Key key,@required this.title,this.wTitle,this.tien_nt=0.0,this.tien,this.displayWhenZezo:false,this.style,this.style_nt,this.displayCard:false,this.onTap})
      :assert(title!=null);
  @override
  Widget build(BuildContext context) {
    final _style=style??Theme.of(context).textTheme.body2.apply(color: tien>=0?Colors.blue:Colors.red);
    final _style_nt=style_nt??Theme.of(context).textTheme.caption.apply(color: Theme.of(context).hintColor);
    Widget _row=(displayWhenZezo)?SizedBox(width: 0.0,height: 0.0):Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child:wTitle??Text(title,style: Theme.of(context).textTheme.body2.apply(color: Colors.blueGrey)),
        ),
        tien_nt==0?null:Expanded(
          flex: 1,
          child:TextNumber(
            value: tien_nt,
            style: _style_nt,
            dicimal: vcInfoLogin.dicimal.tien_nt,
          ),
        ),
        Expanded(
            flex: 1,
            child:TextNumber(
              value: tien,
              style: _style,
              dicimal: vcInfoLogin.dicimal.tien,
            )
        ),
      ].where(notNull).toList(),
    );

    return displayCard?Card(
      margin: EdgeInsets.only(left: 4.0,top: 2.0,right: 4.0,bottom: 2.0),
      elevation: 0.5,
      child:InkWell(
          onTap:onTap,
          child:Padding(
              padding: EdgeInsets.all(8.0),
              child:_row
          )
      ),
    ):_row;
  }
  bool notNull(Object o) => o != null;
}