import 'package:flutter/material.dart';

class CheckBoxTitle extends StatelessWidget{
  final bool left;
  final String title;
  final bool value;
  final TextStyle style;
  const CheckBoxTitle({Key key,this.title,this.left=true,@required this.value,this.style}):assert(value!=null);
  @override
  Widget build(BuildContext context) {
    TextStyle _style=this.style??Theme.of(context).textTheme.body2;
    return Row(
      children: <Widget>[
        (left)?Checkbox(value: value,onChanged: (value){}):SizedBox(height: 0.0,width: 0.0),
        (title==null)?SizedBox(height: 0.0,width: 0.0):Flexible(
          child: Text(title,style: _style,)
        ),
        (!left)?Checkbox(value: value,onChanged: (value){}):SizedBox(height: 0.0,width: 0.0),
      ],
    );
  }
}