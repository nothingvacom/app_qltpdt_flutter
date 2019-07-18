import 'package:flutter/material.dart';

class WidgetFlex{
  final int flex;
  final Widget child;
  final MainAxisAlignment mainAxisAlignment;
  WidgetFlex(Widget child,{this.flex=1,this.mainAxisAlignment=MainAxisAlignment.end}):this.child=child;
}