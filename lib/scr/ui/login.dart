import 'dart:convert';
import 'dart:io';
import 'package:app_qltpdt_flutter/scr/blocs/VcDvcsBloc.dart';
import 'package:app_qltpdt_flutter/scr/models/VcDvcs.dart';
import 'package:app_qltpdt_flutter/scr/models/VcInfoLogin.dart';
import 'package:app_qltpdt_flutter/scr/models/VcIp.dart';
import 'package:app_qltpdt_flutter/scr/resources/VcDvcs/VcDvcsResponse.dart';
import 'package:app_qltpdt_flutter/utils/vc_dialog.dart';
import 'package:app_qltpdt_flutter/widgets/CheckBoxTitle.dart';
import 'package:app_qltpdt_flutter/widgets/build_loading_widget.dart';
import 'package:app_qltpdt_flutter/widgets/password_field.dart';
import 'package:path_provider/path_provider.dart';
import '../../utils/all_translations.dart';
import '../../utils/vc_const.dart';
import 'package:flutter/material.dart';

const _table_dvcs="lst_dvcs";
const _file_data="vacom_data.json";
Map lstVacomData;

class Login extends StatefulWidget{
  Login({Key key,this.idxTheme,this.themeMode,this.toggleTheme,this.idxLang,this.langMode,this.toggleLang,this.timKhongDau,this.checkTimKhongDau});
  final int idxTheme;
  final String themeMode;
  final Function toggleTheme;
  final int idxLang;
  final String langMode;
  final Function toggleLang;
  final String timKhongDau;
  final Function checkTimKhongDau;

  @override
  _LoginState createState()=>_LoginState();
}

class _LoginState extends State<Login>{
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormFieldState<String>> _passwordFieldKey=new GlobalKey<FormFieldState<String>>();

  bool _isLoading = false;
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final vcDvcsBloc = VcDvcsBloc();
  // list IPs
  List<VcIp> _lstIp=[];
  VcIp _ipSelected=null;
  VcDvcs _dvcsSelected=null;
//  bool _firstLoad=true;
  // Add more IP
  _displayIp() async{
    List<VcIp> _lstIpTmp=[];
    await getApplicationDocumentsDirectory().then((Directory directory) async {
      File jsonFile = new File(directory.path + "/${_file_data}");
      if (!jsonFile.existsSync()) {
        jsonFile.createSync();
        jsonFile.writeAsStringSync("{}");
      }
      lstVacomData = json.decode(jsonFile.readAsStringSync());
    });
    try {
      for (Map _dataTable in lstVacomData[_table_dvcs]) {
        VcIp __ip = new VcIp(
            _dataTable['ip'], _dataTable['note'], _dataTable['selected']);
        _lstIpTmp.add(__ip);
        if (__ip.selected) _ipSelected = __ip;
      }
    }catch(e){
      lstVacomData[_table_dvcs] = [];
    }
    if (_lstIpTmp.length==0){
      VcIp __ip=new VcIp('http://hocvienquany.vaonline.vn','Dữ liệu demo Học viện quân y',true);
      _lstIpTmp.add(__ip);
      _ipSelected=__ip;
    }
    setState(() {
      _lstIp=_lstIpTmp;
      if (_ipSelected==null){
        _ipSelected=_lstIp[0];
      }
      // Load name company from link api server
      vcDvcsBloc.getAllDvcs(_ipSelected.ip);
    });
  }

  _refreshDvcs(){
    setState(() {
      vcDvcsBloc.getAllDvcs(_ipSelected.ip);
    });
  }

  _saveIp(VcIp newIp,{isDelete:false}) async{
    await getApplicationDocumentsDirectory().then((Directory directory) {
      File jsonFile = new File(directory.path + "/${_file_data}");
      if (!jsonFile.existsSync()) {
        jsonFile.createSync();
        jsonFile.writeAsStringSync("{}");
      }

      print("WRITING TO JSON...");

      Map jsonContent = json.decode(jsonFile.readAsStringSync());

      if (jsonContent == null) {
        jsonContent = {};
      }
      Map _newIp = {
        "ip": newIp.ip,
        "note": newIp.note,
        "selected": true
      };
      // remove if exists

      int index = 0,_idxRemove=-1;
      try {
        for (Map dataTable in jsonContent[_table_dvcs]) {
          if (dataTable['ip'] == _newIp['ip']) {
            _idxRemove=index;
            //            jsonContent[_table_dvcs].removeAt(index);
          }
          jsonContent[_table_dvcs][index]["selected"]=false;
          index += 1;
        }
        if (_idxRemove!=-1){
          if (isDelete){
            jsonContent[_table_dvcs].removeAt(_idxRemove);
            if (jsonContent[_table_dvcs].length>0){
              jsonContent[_table_dvcs][0]["selected"]=true;
            }
          }else{
            jsonContent[_table_dvcs][_idxRemove]=_newIp;
          }
        }else {
          // Add
          jsonContent[_table_dvcs].add(_newIp);
        }
      } catch (e) {
        jsonContent[_table_dvcs] = [];
        jsonContent[_table_dvcs].add(_newIp);
      }
      print("json file: ${jsonContent}");

      lstVacomData[_table_dvcs]=jsonContent[_table_dvcs];

      jsonFile.writeAsStringSync(json.encode(jsonContent));

      print("WRITE SUCCESS");

//        Navigator.of(context).pop();
    });
    //
    _displayIp();
  }

  void _submit(BuildContext context) {
    String _userName=_userNameController.text;
    String _password=_passwordController.text;
    if (_userName.length==0 || _password.length==0){
      String _textErr=_userName.length==0?allTranslations.text("user_name_valid"):allTranslations.text("password_valid");
      VcDialog.showDialogSingleButton(context,_textErr,title: allTranslations.text('title_login'));
    }else {
      setState(() {
        _isLoading = true;
      });
      _login(context,_userName,_password);
    }
  }

  void _login(BuildContext context,String userName,String password) async{
    await vcInfoLogin.getInfoLogin(_ipSelected.ip, _dvcsSelected.id, userName, password,widget.timKhongDau);
    if (vcInfoLogin.hasError()){
      VcDialog.showDialogSingleButton(context,vcInfoLogin.error,title: allTranslations.text('title_err'));
      setState(() {
        _isLoading = false;
      });
    }else {
      print("Token: ${vcInfoLogin.token}");
      Navigator.of(context).pushReplacementNamed("/home");
    }
  }

  @override
  void initState() {
    _displayIp();
  }

  void _deleteIP(BuildContext context){
    if (_lstIp.length>1){
      showDialog(
          context: context,
          builder: (BuildContext context)=>AlertDialog(
            title: Text(allTranslations.text("delete_ip"),style: TextStyle(
                fontSize: Theme.of(context).textTheme.body2.fontSize
            )),
            content: Text("${_ipSelected.ip} ?",style: TextStyle(
                fontSize:Theme.of(context).textTheme.caption.fontSize,
                color: Theme.of(context).disabledColor
            )),
            actions: <Widget>[
              FlatButton(
                  onPressed: ()=>Navigator.pop(context,false),
                  child: Text(allTranslations.text("btn_cancel"))
              ),
              FlatButton(
                  onPressed: ()=>Navigator.pop(context,true),
                  child: Text(allTranslations.text("btn_ok"))
              ),
            ],
          )
      ).then<bool>((isOk){
        if (isOk){
          _saveIp(_ipSelected,isDelete: true);
        }
      });
    }else{
      VcDialog.showDialogSingleButton(context,
          "You have only one IP !!!",
          title:allTranslations.text('delete_ip')
      );
    }

  }
  void _addIP(BuildContext context){
    final TextEditingController _ipController = TextEditingController();
    final TextEditingController _noteController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context)=>Dialog(
        child:Container(
          height: 206.0,
          child: Column(
            children: <Widget>[
              Card(
                elevation: 4.0,
                margin: EdgeInsets.all(0.0),
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(allTranslations.text("add_ip")),
                    ],
                  ),
                )
              ),
              Padding(
                padding: EdgeInsets.only(left:20.0,right: 20.0,bottom: 20.0),
                child: Column(
                  children: <Widget>[
                    new TextFormField(
                      controller: _ipController,
                      decoration: new InputDecoration(labelText: "Ip",
                          labelStyle: VcConst.getStyleCaption(context),
                          focusedBorder:UnderlineInputBorder(
                            borderSide: BorderSide(color: Theme.of(context).textSelectionHandleColor),
                          )
                      ),
                    ),
                    new TextFormField(
                      controller: _noteController,
                      decoration: new InputDecoration(labelText: "Note",
                          labelStyle: VcConst.getStyleCaption(context),
                          focusedBorder:UnderlineInputBorder(
                            borderSide: BorderSide(color: Theme.of(context).textSelectionHandleColor),
                          )
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(icon: Icon(Icons.cancel),color: Colors.red[300],onPressed: ()=>Navigator.pop(context)),
                        IconButton(icon: Icon(Icons.save),color: Colors.blue[300],onPressed: (){
                          if (_ipController.text!=null && _ipController.text!="") {
                            Navigator.pop(context);
                            _saveIp(new VcIp(
                                _ipController.text, _noteController.text, true));
                          }else{
                            VcDialog.showDialogSingleButton(context,"Bạn phải nhập Ip...",title: allTranslations.text('title_err'));
                          }
                        })
                      ],
                    )
                  ],
                ),
              ),
            ],
          )
        )
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    final _widthScreen=MediaQuery.of(context).size.width;
    final _heightScreen=MediaQuery.of(context).size.height;
    //
    final List<PopupMenuItem<String>> _dropDownThemes=VcConst.listThemeNames.map(
            (String nameTheme)=>PopupMenuItem(
            value: nameTheme,
            child: Row(
              children: <Widget>[
                Icon(VcConst.listThemeIcons[VcConst.listThemeNames.indexOf(nameTheme)],color: Theme.of(context).buttonColor),
                Text(" "+nameTheme,style: Theme.of(context)
                    .textTheme
                    .body2
                    .apply(color: Theme.of(context).buttonColor))
              ],
            )
        )).toList();

    final List<PopupMenuItem<String>> _dropDownLangs=VcConst.titleLanguages.map(
            (String nameLang)=>PopupMenuItem(
            value: nameLang,
            child: Row(
              children: <Widget>[
                Icon(VcConst.iconsLanguages[VcConst.titleLanguages.indexOf(nameLang)],color: Theme.of(context).buttonColor),
                Text(" "+nameLang,style: Theme.of(context)
                    .textTheme
                    .body2
                    .apply(color: Theme.of(context).buttonColor))
              ],
            )
        )).toList();

    var loginBtn = new RaisedButton(
      onPressed: ()=>_submit(context),
      child: new Text(
          allTranslations.text('title_login'),
          style: VcConst.getStyleButton(context)
      ),
      shape: VcConst.shapeButton,
    );
    CheckBoxTitle checkKhongDau=CheckBoxTitle(
      value: widget.timKhongDau.contains("C"),
      title: allTranslations.text("search_not_sign"),
      onCheck: (value)=>widget.checkTimKhongDau(value),
    );

    var loginForm=new SingleChildScrollView(
      child:Container(
        height: _heightScreen,
        width: _widthScreen,
        margin: EdgeInsets.only(left:_widthScreen*0.1,right:_widthScreen*0.1),
        child:Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(icon: Icon(Icons.remove_circle,color: Colors.red[300],), onPressed: ()=>_deleteIP(context)),
                    IconButton(icon: Icon(Icons.add_circle,color: Colors.blue[300],), onPressed: ()=>_addIP(context)),
                  ],
                ),
                _buildWidgetIP(),
                StreamBuilder<VcDvcsResponse>(
                  stream: vcDvcsBloc.subject.stream,
                  builder: (context,AsyncSnapshot<VcDvcsResponse> snapshot){
                    if (snapshot.hasData) {
                      if (snapshot.data.error != null && snapshot.data.error.length > 0){
                        return _buildErrorWidget(snapshot.data.error);
                      }
                      return _buildWidget(snapshot.data);
                    } else if (snapshot.hasError) {
                      return _buildErrorWidget(snapshot.error);
                    } else {
                      return BuildLoadingWidget();
                    }
                  },
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.0),
              child:new TextFormField(
                controller: _userNameController,
                onSaved: (val) => {},
                validator: (val) {
                  return val.length == 0
                      ? allTranslations.text("user_name_valid")
                      : null;
                },
                decoration: VcConst.getInputDecorationTextFormField(context,labelText:allTranslations.text("user_name")),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: new PasswordField(
                fieldKey: _passwordFieldKey,
                controller: _passwordController,
                labelText: allTranslations.text('password'),
                onSaved: (val)=>{},
                validator: (val){
                  return val.length==0?allTranslations.text("password_valid"):null;
                },
              ),
            ),
            checkKhongDau,
            Divider(),
            new Container(
                margin: EdgeInsets.only(top: 20.0),
                child: _isLoading ? BuildLoadingWidget() : loginBtn 
            ),
          ],
        ),
      ) ,
    );
    // TODO: implement build
    return new Scaffold(
        key: scaffoldKey,
        body: loginForm,
        bottomNavigationBar: BottomAppBar(
            child: Card(
              margin: EdgeInsets.zero,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  PopupMenuButton(
                      onSelected: (String newTheme)=>widget.toggleTheme(newTheme),
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(VcConst.listThemeIcons[widget.idxTheme],color: Theme.of(context).buttonColor),
                            Text(VcConst.listThemeNames[widget.idxTheme],style: Theme.of(context)
                                .textTheme
                                .body2
                                .apply(color: Theme.of(context).buttonColor))
                          ],
                        ),
                      ),
                      itemBuilder: (BuildContext context)=>_dropDownThemes
                  ),
                  PopupMenuButton(
                      onSelected: (String newLang)=>widget.toggleLang(newLang),
                      child: Container(
                          padding: EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(VcConst.titleLanguages[widget.idxLang],style: Theme.of(context)
                                  .textTheme
                                  .body2
                                  .apply(color: Theme.of(context).buttonColor)),
                              Icon(VcConst.iconsLanguages[widget.idxLang],color: Theme.of(context).buttonColor)
                            ],
                          )
                      ),
                      itemBuilder: (BuildContext context)=>_dropDownLangs
                  )
                ],
              ),
            )
        )
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                icon: Icon(Icons.refresh),color: Colors.blue[300],onPressed: ()=>_refreshDvcs()
            ),
            Text(error)
          ],
        ));
  }

  Widget _buildWidgetIP() {
    final List<PopupMenuItem<VcIp>> _dropDownIp=_lstIp.map((VcIp ip)=>PopupMenuItem(
        value: ip,
        child: Row(
          children: <Widget>[
            Icon(Icons.cloud_done,color: Colors.purple[300],),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(" "+ip.ip,softWrap: true),
                Text(" "+ip.note,softWrap: true,style:Theme.of(context).textTheme.caption),
              ],
            )
          ],
        )
    )).toList();
    return Card(
        child: PopupMenuButton(
          onSelected: (VcIp ip){
            if (ip.ip!=_ipSelected.ip){
              _saveIp(ip);
            }
          },
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Row(
              children: <Widget>[
                Icon(Icons.cloud_done,color: Colors.purple[300]),
                (_ipSelected!=null)?Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(" ${_ipSelected.ip}",softWrap: true),
                      Text(" ${_ipSelected.note}",softWrap: true,style: Theme.of(context).textTheme.caption),
                    ],
                  ),
                ):BuildLoadingWidget(),
              ],
            ),
          ),
          itemBuilder: (BuildContext context)=>_dropDownIp,
        )
    );
  }

  Widget _buildWidget(VcDvcsResponse data) {
    _dvcsSelected=_dvcsSelected??data.results[0];
    List<String> lstStringVcDvcs=data.results.map((vcDvcs)=>vcDvcs.id+vcDvcs.value).toList();
    if (lstStringVcDvcs.indexOf(_dvcsSelected.id+_dvcsSelected.value)==-1) _dvcsSelected=data.results[0];
    List<PopupMenuItem<VcDvcs>> _itemsBuider  =data.results.map(
            (VcDvcs dvcs)=>PopupMenuItem(
            value: dvcs,
            child: Text("${dvcs.id} - ${dvcs.value}")
        )).toList();

    return Card(
        child: PopupMenuButton(
          onSelected: (VcDvcs dvcs){
            if (dvcs.id!=_dvcsSelected.id){
              setState(() {
                _dvcsSelected=dvcs;
              });
            }
          },
          child:Padding(
            padding: EdgeInsets.all(5.0),
            child:Row(
              children: <Widget>[
                Icon(Icons.playlist_add_check,color: Colors.blue[300]),
                Flexible(
                  child: Text("${_dvcsSelected.id} - ${_dvcsSelected.value}",softWrap: true,),
                ),
              ],
            ),
          ),
          itemBuilder: (BuildContext context)=>_itemsBuider,
        )
    );
  }
}
