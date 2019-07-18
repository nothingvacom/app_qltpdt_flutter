import 'package:app_qltpdt_flutter/utils/all_translations.dart';
import 'package:flutter/material.dart';
Widget BuildNoDataWidget(BuildContext context) {
  return Center(
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.not_interested,color: Theme.of(context).buttonColor,),
        Flexible(
            child: Text(" "+allTranslations.text("no_data"))
        )
      ],
    ),
  );
}