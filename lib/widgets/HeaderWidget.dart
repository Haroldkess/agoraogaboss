import 'package:flutter/material.dart';

AppBar header(context ,{ bool isAppTittle  = false, String strTittle,disapearedBackButton=false}) {
  return AppBar(
    iconTheme: IconThemeData(
      color: Colors.white,

    ),

    automaticallyImplyLeading: disapearedBackButton ? false : true,
    title: Text(
      isAppTittle ? " Agora" : strTittle,
      style: TextStyle(color: Colors.white, fontFamily: isAppTittle ? "Signatra": "",fontSize: isAppTittle ? 45.0: 22.0),

      overflow: TextOverflow.ellipsis,
    ),

    centerTitle:  true,
    backgroundColor: Theme.of(context).accentColor,
  );
}
