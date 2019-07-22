import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class VcConst{
  // Button
  static final shapeButton=new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0));
  static getStyleButton(BuildContext context){
    return Theme.of(context).textTheme.body2.apply(
      color: Theme.of(context).iconTheme.color
    );
  }
  // progress
  static final progress=new CircularProgressIndicator();

  // Text
  static getStyleTextBody2Factor(BuildContext context,{sizeFactor:1}){
    return Theme.of(context).textTheme.body2.apply(fontSizeFactor: sizeFactor);
  }
  static getStyleCaption(BuildContext context){
    return Theme.of(context).textTheme.caption;
  }
  static InputDecoration getInputDecorationTextFormField(BuildContext context,{String labelText,Widget icon}){
    return new InputDecoration(labelText: labelText,
        labelStyle: VcConst.getStyleCaption(context),
        contentPadding: EdgeInsets.all(8.0),
        icon: icon,
        border: UnderlineInputBorder(),
        focusedBorder:UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).textSelectionHandleColor),
        )
    );
  }
  // property Language
  static const List<String> _listLanguages = ['vi','en'];
  static const List<String> _titleLanguages = ['Việt Nam','English'];
  static final List<IconData> _iconsLanguages = [Icons.outlined_flag,Icons.public];

  // Get language
  static List<String> get listLanguages => _listLanguages;
  static List<String> get titleLanguages => _titleLanguages;
  static List<IconData> get iconsLanguages => _iconsLanguages;

  // Theme
  static final ThemeData _lightTheme = new ThemeData(
    primarySwatch: Colors.purple,
    brightness: Brightness.light,
    accentColor: Colors.purple[200],
    primaryColor: Colors.white,
    primaryColorLight: Colors.purple[700],
    textSelectionHandleColor: Colors.purple[700],
    dividerColor: Colors.grey[200],
    bottomAppBarColor: Colors.grey[200],
    buttonColor: Colors.purple[700],
    iconTheme: new IconThemeData(color: Colors.white),
    primaryIconTheme: new IconThemeData(color: Colors.black),
    accentIconTheme: new IconThemeData(color: Colors.purple[700]),
    disabledColor: Colors.grey[500],
    fontFamily: "myriad_pro"
  );

  static final ThemeData _darkTheme = new ThemeData(
    primarySwatch: Colors.purple,
    brightness: Brightness.dark,
    accentColor: Colors.deepPurpleAccent[100],
    primaryColor: Color.fromRGBO(50, 50, 57, 1.0),
    primaryColorLight: Colors.deepPurpleAccent[100],
    textSelectionHandleColor: Colors.deepPurpleAccent[100],
    buttonColor: Colors.deepPurpleAccent[100],
    iconTheme: new IconThemeData(color: Colors.white),
    accentIconTheme: new IconThemeData(color: Colors.deepPurpleAccent[100]),
    cardColor: Color.fromRGBO(55, 55, 55, 1.0),
    dividerColor: Color.fromRGBO(60, 60, 60, 1.0),
    bottomAppBarColor: Colors.black26,
    fontFamily: "myriad_pro"
  );

  static final List<ThemeData> _listThemes=[
    _lightTheme,
    _darkTheme
  ];
  static final List<String> _listThemeNames=[
    "Light",
    "Dark"
  ];

  static final List<IconData> _listThemeIcons=[
    Icons.wb_sunny,
    Icons.brightness_3
  ];

  static List<ThemeData> get listThemes => _listThemes;
  static List<String> get listThemeNames => _listThemeNames;
  static List<IconData> get listThemeIcons => _listThemeIcons;

  static String getDateToString(DateTime value,{String format:"dd/MM/yyyy"}){
    String _strReturn="  /  /    ";
    try{
      _strReturn=DateFormat(format).format(value)??"  /  /    ";
    }catch(e){
    }
    return _strReturn;
  }
  static DateTime getStringToDate(String value,{String format:"yyyy-MM-dd"}){
    DateTime _dateTimeReturn=null;
    try{
      _dateTimeReturn=DateFormat(format).parse(value);
    }catch(e){
    }
    return _dateTimeReturn;
  }

  static Color hexToColor(String hexString, {String alphaChannel = 'FF'}) {
    return Color(int.parse(hexString.replaceFirst('#', '0x$alphaChannel')));
  }

  static String converDate(final String ngay_ct){
    return ngay_ct.isEmpty?"":VcConst.getDateToString(VcConst.getStringToDate(ngay_ct));
  }

  static double toDoule(dynamic value){
    return (value==null)?0.0:value.toDouble();
  }
}

