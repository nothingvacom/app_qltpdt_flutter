import 'package:flutter/material.dart';
import 'WidgetFlex.dart';
class VcRowWidget extends StatelessWidget{
  final List<WidgetFlex> childrenFlex;
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  const VcRowWidget({Key key,this.childrenFlex = const <WidgetFlex>[],this.children = const <Widget>[],this.mainAxisAlignment=MainAxisAlignment.end}):assert(children!=null);
  @override
  Widget build(BuildContext context) {
    return (childrenFlex.length>0)?
    Row(
      children: childrenFlex.where(notNull).toList().map((widgetFlex)=>Expanded(
        flex: widgetFlex.flex,
        child: Row(
          mainAxisAlignment:widgetFlex.mainAxisAlignment,
          children: <Widget>[widgetFlex.child],
        ),
      )).toList(),
    ):
    Row(
      children: children.where(notNull).toList().map((child)=>Expanded(
        flex: 1,
        child: Row(
          mainAxisAlignment:mainAxisAlignment,
          children: <Widget>[child],
        ),
      )).toList(),
    );
  }
}
bool notNull(Object o) => o != null;