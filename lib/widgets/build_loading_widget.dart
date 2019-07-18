import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// https://github.com/jogboms/flutter_spinkit
enum TypeLoading {
  DoubleBounce,Wave,ThreeBounce,CubeGrid,FadingCircle,PumpingHeart,Ripple
}
Widget BuildLoadingWidget({typeLoading:TypeLoading.DoubleBounce,color=const Color(0xFFBA68C8)}) {
  return Center(
    child: _getWidget(typeLoading,color),
  );
}

Widget _getWidget(typeLoading,color){
  Widget _loading=SpinKitDoubleBounce(color: color);
  switch(typeLoading){
    case TypeLoading.DoubleBounce:{
      _loading=SpinKitDoubleBounce(color: color);
    }
    break;
    case TypeLoading.Wave:{
      _loading=SpinKitWave(color: color);
    }
    break;
    case TypeLoading.ThreeBounce:{
      _loading=SpinKitThreeBounce(color: color);
    }
    break;
    case TypeLoading.CubeGrid:{
      _loading=SpinKitCubeGrid(color: color);
    }
    break;
    case TypeLoading.FadingCircle:{
      _loading=SpinKitFadingCircle(color: color);
    }
    break;
    case TypeLoading.PumpingHeart:{
      _loading=SpinKitPumpingHeart(color: color);
    }
    break;
    case TypeLoading.Ripple:{
      _loading=SpinKitRipple(color: color);
    }
    break;
  }
  return _loading;
}