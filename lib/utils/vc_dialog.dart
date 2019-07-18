import 'package:flutter/material.dart';
import 'all_translations.dart';
class VcDialog{
  static void showDialogSingleButton(BuildContext context, String message, {String title="", String buttonLabel=""}) {
    if (title.isEmpty) title=allTranslations.text("frg_notification");
    if (buttonLabel.isEmpty) buttonLabel=allTranslations.text("btn_ok");
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(title,style: TextStyle(
              fontSize: Theme.of(context).textTheme.body2.fontSize
            ),
          ),
          content: new Text(message,style: TextStyle(
              fontSize:Theme.of(context).textTheme.caption.fontSize,
              color: Theme.of(context).disabledColor
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(buttonLabel),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static void showDialogJsonData(BuildContext context, Map<String,dynamic> json, {String title="", String buttonLabel=""}) {
    if (title.isEmpty) title=allTranslations.text("view_data_json");
    if (buttonLabel.isEmpty) buttonLabel=allTranslations.text("btn_ok");
    List<_JsonData> _datas=new List<_JsonData>();
    json.forEach((key,value)=>_datas.add(new _JsonData(key: key,value: value)));
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(title,style: TextStyle(
              fontSize: Theme.of(context).textTheme.body2.fontSize),
          ),
          contentPadding:const EdgeInsets.all(5.0),
          content: ListView.builder(
            itemBuilder: (context,index)=>Card(
              margin: EdgeInsets.only(left: 2.0,top: 1.0,right: 2.0,bottom: 1.0),
              elevation: 0.5,
              child:Padding(
                  padding: EdgeInsets.all(10.0),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(_datas[index].key,style: Theme.of(context).textTheme.caption.apply(color:Colors.purple)),
                      Divider(),
                      Text("${_datas[index].value??""}",style: Theme.of(context).textTheme.caption),
                    ],
                  )
              ),
            ),
            itemCount: _datas.length,
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(buttonLabel),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class _JsonData{
  final String key;
  final dynamic value;
  _JsonData({this.key,this.value});
}