import 'package:app_qltpdt_flutter/utils/all_translations.dart';
import 'package:flutter/material.dart';

import 'fragments/frg_home.dart';
import 'fragments/frg_list.dart';
import 'fragments/frg_other.dart';
import 'fragments/frg_thp.dart';
import 'fragments/frg_report.dart';
import 'fragments/frg_sys.dart';

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class HomeScreen extends StatefulWidget {
  final drawerItems = [
    new DrawerItem(allTranslations.text("frg_home"), Icons.home),
    new DrawerItem(allTranslations.text("frg_thp"), Icons.assignment),
    new DrawerItem(allTranslations.text("frg_report"), Icons.note),
    new DrawerItem(allTranslations.text("frg_list"), Icons.view_list),
    new DrawerItem(allTranslations.text("frg_sys"), Icons.settings_input_component),
    new DrawerItem(allTranslations.text("frg_other"), Icons.favorite),
  ];
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _HomeScreenState();
  }
}
class _HomeScreenState extends State<HomeScreen>{
  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new FrgHome();
      case 1:
        return new FrgThp();
      case 2:
        return new FrgReport();
      case 3:
        return new FrgList();
      case 4:
        return new FrgSys();
      case 5:
        return new FrgOther();
      default:
        return new FrgHome();
    }
  }
  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

//
  @override
  Widget build(BuildContext context) {

    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(
        Ink(
          color: i == _selectedDrawerIndex?Theme.of(context).dividerColor:Colors.transparent,
          child:
          new ListTile(
            leading: new Icon(d.icon,color:i == _selectedDrawerIndex?Theme.of(context).buttonColor:Theme.of(context).textTheme.caption.color),
            title: new Text(d.title,style: TextStyle(color:i == _selectedDrawerIndex?Theme.of(context).buttonColor:Theme.of(context).textTheme.caption.color)),
//            selected: i == _selectedDrawerIndex,
            onTap: () => _onSelectItem(i),

          )
        )
      );
    }
    return new Scaffold(
      appBar: new PreferredSize(
        preferredSize: const Size.fromHeight(48.0),
        child: new AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          titleSpacing: 0.0,
          elevation: 0.5,
          title: new Text(widget.drawerItems[_selectedDrawerIndex].title, style: Theme.of(context).textTheme.title),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.power_settings_new),
              onPressed: ()=>{
                Navigator.of(context).pushReplacementNamed("/login")
              }
            )
          ],
        ),
      ),
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width*0.6,
        child:new Drawer(
          child: new Scaffold(
            body: new ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Center(
                    child: Text("VACOM.,JSC",style: Theme.of(context).textTheme.title.apply(color: Theme.of(context).disabledColor)),
                  ),
                ),
                Divider(),
                new Column(children: drawerOptions),
              ],
            ),
            bottomNavigationBar: BottomAppBar(
              child: Container(
                padding: EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Divider(),
                    Text('VACOM.,JSC Copyright © 2019',style: TextStyle(color: Theme.of(context).disabledColor,fontSize: 10.0))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}