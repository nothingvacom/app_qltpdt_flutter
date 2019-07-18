import 'package:app_qltpdt_flutter/scr/models/VcDm.dart';
import 'package:flutter/material.dart';
class ItemDanhMuc extends StatelessWidget {
  final String typeDm;
  final VcDm vcDm;
  final GestureTapCallback onTap;
  const ItemDanhMuc({Key key,@required this.typeDm,@required this.vcDm,this.onTap})
      :assert(vcDm != null && typeDm!=null);
  @override
  Widget build(BuildContext context) {
    return Card(
        child:InkWell(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              child: _getWidget(context),
            ),
          ),
          onTap: onTap,
        )
    );
  }
  Widget _getWidget(BuildContext context){
    switch (typeDm){
      case "khoa_hoc":return _ItemKhoaHoc(context,vcDm);
      case "khoan_thu":return _ItemKhoanThu(context,vcDm);
      case "lop":return _ItemLop(context,vcDm);
      case "sinh_vien":return _ItemSinhVien(context,vcDm);
    }
    return SizedBox(width: 0.0,height: 0.0);
  }
}


Widget _ItemKhoaHoc(BuildContext context,VcDm vcDm){
  return Text(vcDm.jsonBase.toString());
}
Widget _ItemKhoanThu(BuildContext context,VcDm vcDm){
  return Text(vcDm.jsonBase.toString());
}
Widget _ItemLop(BuildContext context,VcDm vcDm){
  return Text(vcDm.jsonBase.toString());
}
Widget _ItemSinhVien(BuildContext context,VcDm vcDm){
  return Text(vcDm.jsonBase.toString());
}
