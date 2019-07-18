import 'package:flutter/material.dart';

class TextIcon extends StatelessWidget{
  final Widget leading;
  final Widget trailing;
  final String title;
  final TextStyle style;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  const TextIcon({Key key,@required this.title,this.leading,this.trailing,this.style,this.mainAxisAlignment=MainAxisAlignment.start,this.crossAxisAlignment: CrossAxisAlignment.start}):assert(title!=null);
  @override
  Widget build(BuildContext context) {
    TextStyle _style=this.style??Theme.of(context).textTheme.body1;
    return Row(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment,
      children: <Widget>[
        (leading!=null)?leading:null,
        Flexible(
          child: Text((leading!=null?" ":"")+title+(trailing!=null?" ":""),style: _style,)
        ),
        (trailing!=null)?trailing:null,
      ].where(notNull).toList(),
    );
  }
  bool notNull(Object o) => o != null;
}