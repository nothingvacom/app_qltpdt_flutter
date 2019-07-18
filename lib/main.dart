import 'package:app_qltpdt_flutter/scr/models/VcInfoLogin.dart';
import 'package:app_qltpdt_flutter/scr/ui/home_screen.dart';
import 'package:app_qltpdt_flutter/scr/ui/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_qltpdt_flutter/utils/vc_const.dart';
import 'package:app_qltpdt_flutter/utils/all_translations.dart';
const double appBarHeight = 48.0;
const double appBarElevation = 1.0;

Future main() async {
  await allTranslations.init();
  String timKhongDau="K";
  String themeMode = VcConst.listThemeNames[0];
  String langMode = VcConst.titleLanguages[0];
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getString("themeMode") != null && prefs.getString("langMode") != null && prefs.getString("timKhongDau") != null) {
    themeMode = prefs.getString("themeMode");
    langMode = prefs.getString("langMode");
    timKhongDau = prefs.getString("timKhongDau");
  }
  runApp(VacomApp(themeMode:themeMode,langMode:langMode,timKhongDau: timKhongDau,));
}

class VacomApp extends StatefulWidget {
  final String themeMode;
  final String langMode;
  final String timKhongDau;
  VacomApp({Key key, String this.themeMode,this.langMode,this.timKhongDau});

  @override
  _VacomAppState createState() => _VacomAppState();
}

class _VacomAppState extends State<VacomApp>{
  int idxTheme;
  String themeMode;
  int idxLang;
  String langMode;
  String timKhongDau;
  void _savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("themeMode", themeMode);
    prefs.setString("langMode", langMode);
    prefs.setString("timKhongDau", timKhongDau);
  }
  checkTimKhongDau(bool check){
    setState(() {
      timKhongDau=(check)?"C":"K";
    });
    _savePreferences();
  }
  toggleTheme(String newTheme) {
    int idxThemeNew=VcConst.listThemeNames.indexOf(newTheme);
    if (idxTheme!=idxThemeNew) _toggleTheme(idxThemeNew);
  }
  _toggleTheme(int idxThemeNew){
    themeMode=VcConst.listThemeNames[idxThemeNew];
    _savePreferences();
    setState(() {
      this.idxTheme = idxThemeNew;
    });
    setNavBarColor();
  }
  toggleLang(String newLang){
    int idxLangNew=VcConst.titleLanguages.indexOf(newLang);
    if (idxLang!=idxLangNew) _toggleLang(idxLangNew);
  }
  _toggleLang(int idxLangNew) async {
    await allTranslations.setNewLanguage(VcConst.listLanguages[idxLangNew]);
    vcInfoLogin.setLang(VcConst.listLanguages[idxLangNew]);
    langMode=VcConst.titleLanguages[idxLangNew];
    _savePreferences();
    setState(() {
      this.idxLang = idxLangNew;
    });
  }

  setNavBarColor() async {
    if (idxTheme!=0) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
          systemNavigationBarIconBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
          systemNavigationBarColor:VcConst.listThemes[idxTheme].primaryColor)
      );
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
          systemNavigationBarColor:VcConst.listThemes[idxTheme].primaryColor)
      );
    }
  }

  _onLocaleChanged() async {
    // do anything you need to do if the language changes
    print('Language has been changed to: ${allTranslations.currentLanguage}');
  }

  @override
  void initState() {
    super.initState();
    themeMode = widget.themeMode ?? VcConst.listThemeNames[0];
    idxTheme=idxTheme??VcConst.listThemeNames.indexOf(themeMode);
    if (idxTheme<0) idxTheme=0;
    langMode = widget.langMode ?? VcConst.titleLanguages[0];
    idxLang=idxLang??VcConst.titleLanguages.indexOf(langMode);
    allTranslations.onLocaleChangedCallback = _onLocaleChanged;
    if (idxLang!=0) _toggleLang(idxLang);
    vcInfoLogin.setLang(VcConst.listLanguages[idxLang]);
    timKhongDau=widget.timKhongDau??"K";
    setNavBarColor();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        color: VcConst.listThemes[idxTheme].primaryColor,
        title: "VACOM.,JSC",
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: allTranslations.supportedLocales(),
        home: Login(
            idxTheme:idxTheme,
            themeMode:themeMode,
            toggleTheme:toggleTheme,
            idxLang:idxLang,
            langMode:langMode,
            toggleLang:toggleLang,
            timKhongDau: timKhongDau,
            checkTimKhongDau:checkTimKhongDau
        ),
        theme: VcConst.listThemes[idxTheme],
        routes: <String, WidgetBuilder>{
          '/login': (BuildContext context) => new Login(
              idxTheme:idxTheme,
              themeMode:themeMode,
              toggleTheme:toggleTheme,
              idxLang:idxLang,
              langMode:langMode,
              toggleLang:toggleLang,
              timKhongDau: timKhongDau,
              checkTimKhongDau:checkTimKhongDau
          ),
          '/home': (BuildContext context) => new HomeScreen()
        }
    );
  }
}