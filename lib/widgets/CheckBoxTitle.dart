import 'package:flutter/material.dart';
enum CheckBoxTitleAlignment{
  left,right
}
class CheckBoxTitle extends StatelessWidget{
  final String title;
  final TextStyle style;
  final bool value;
  final CheckBoxTitleAlignment alignment;
  final Function onCheck;
  final Color checkedColor;
  final IconData check;
  final Color unCheckedColor;
  final IconData unCheck;
  const CheckBoxTitle({Key key,this.title,this.style,@required this.value,
    this.check,this.checkedColor,this.unCheck,this.unCheckedColor,
    this.alignment=CheckBoxTitleAlignment.left,this.onCheck}):assert(value!=null);
  @override
  Widget build(BuildContext context) {
    TextStyle _style=this.style??Theme.of(context).textTheme.body1;
    Color _checkedColor=checkedColor??Theme.of(context).buttonColor;
    IconData _check=check??Icons.check_box;
    Color _unCheckedColor=unCheckedColor??Theme.of(context).disabledColor;
    IconData _unCheck=check??Icons.check_box_outline_blank;
    return InkWell(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          (alignment==CheckBoxTitleAlignment.right)?null:Icon(value?_check:_unCheck,color: value?_checkedColor:_unCheckedColor),
          (title==null)?null:Text("${(alignment==CheckBoxTitleAlignment.left)?" ":""}${title}${(alignment==CheckBoxTitleAlignment.right)?"":" "}",
            style: _style,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
//          (title==null)?null:Flexible(
//              child:Text("${(alignment==CheckBoxTitleAlignment.left)?" ":""}${title}${(alignment==CheckBoxTitleAlignment.right)?"":" "}",style: _style)
//          ),
          (alignment==CheckBoxTitleAlignment.left)?null:Icon(value?_check:_unCheck,color: value?_checkedColor:_unCheckedColor),
        ].where(notNull).toList(),
      ),
      onTap:()=>onCheck(!value),
    );;
  }
  bool notNull(Object o) => o != null;
}