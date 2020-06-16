import 'package:cam_scanner/src/pages/camera_page.dart';
import 'package:cam_scanner/src/pages/display.dart';
import 'package:cam_scanner/src/pages/home.dart';
import 'package:cam_scanner/src/pages/menu.dart';
import 'package:cam_scanner/src/pages/pickdocument_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes:  <String,WidgetBuilder>{
         "/" : (BuildContext context) => Home(),
         "Menu" : (BuildContext context) => Menu(),
         "Camera" : (BuildContext context) => Camera(),
         "Display" : (BuildContext context) => DisplayPicture(),
         "PickDocument" : (BuildContext context) => PickDocument(),
         },  
      title: 'Docapix',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates:[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [ 
        const Locale('es'), // Spanish   
      ],
    );
    
  }
}
