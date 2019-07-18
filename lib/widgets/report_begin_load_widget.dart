import 'package:flutter/material.dart';
import 'build_loading_widget.dart';
Widget ReportBeginLoad(BuildContext context) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        BuildLoadingWidget(typeLoading: TypeLoading.CubeGrid,color: Colors.blueGrey[100]),
        Card(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Text("Lọc dữ liệu để xem thông tin"),
          )
        ),
      ],
    ),
  );
}