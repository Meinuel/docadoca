import 'dart:io';
import 'package:cam_scanner/utils/color_provider.dart';
import 'package:cam_scanner/utils/directory_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class PickDocument extends StatefulWidget {
  PickDocument({Key key}) : super(key: key);

  @override
  _PickDocumentState createState() => _PickDocumentState();
}

class _PickDocumentState extends State<PickDocument> {

  List<String> listaArg = [];
  List<String> lstDocType = ['Factura','Pedido médico','Informe médico','Detalle de factura','Historia clínica'];
  Map<String,int> docTypeMap = ColorProvider().createDocTypeMap();
  bool currentState = true;
  Icon icono = Icon(Icons.keyboard_arrow_down);
  bool bCurrentState = false ;
  List<FileSystemEntity> lstImagesInCache = [];
  bool bRsp;
  final Color colorBlue = ColorProvider().colorFromHex('27A9E1');

  @override
  Widget build(BuildContext context) {
    
    List<dynamic> lstParametros = ModalRoute.of(context).settings.arguments;
   // parametros.length == 3 ? parametros = parametros : parametros.removeRange(parametros., parametros.length);
    final String sSelectedDate = lstParametros[1].toString();
    final String sExpediente = lstParametros[2];
    final String sUsuario = lstParametros[3];
    final String sFecha = _handleFecha(sSelectedDate);
    double height = MediaQuery.of(context).size.height;
    //_getPermissions();
    return Scaffold(
      appBar: _createAppBar(),
      backgroundColor: Colors.white,
      body:Column( 
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:<Widget>[
           //Container(color: Colors.transparent,height: height/50),
          Column(
            children: <Widget>[
              Container(
                color:Colors.transparent,
                child: Align( 
                  alignment: Alignment.center,
                  child: Text('Expediente : $sExpediente',style: TextStyle(fontFamily: 'Oswald',fontSize: 20,color: Colors.black),)),
              ),
              Container(
                color:Colors.transparent,
                child: Align(
                  alignment: Alignment.center,
                  child: Text('Fecha : $sFecha',style: TextStyle(fontFamily: 'Oswald',fontSize: 20,color: Colors.black),)),
              ),
            ],
          ),     
          Container(  
            child: _createButtons(lstParametros,sUsuario),
          ),
          Container(
            decoration: _boxDecoration(),
            width: 70,
            height: 70,
            child:_raisedButton()
              )
          ]),
       );
  }

  _handleFecha(String sFecha) {
    sFecha = sFecha.substring(0,11);
    return sFecha;
  }

  _createAppBar(){
    return AppBar(
      elevation: 5,
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      leading: IconButton(
        onPressed: () async {
         await ImagePicker.pickImage(source: ImageSource.gallery);
        },
        icon:Icon(Icons.collections,color:Colors.blueGrey)),
      centerTitle: true,
      title: SvgPicture.asset('assets/logo.svg',height: 25,width: 200),
    );
  }

  _createButtons(lstParametros,sUsuario){
    List<Widget> lstButtons = [];   
    for (var sDocType in lstDocType) {
      final tempWidget = Container( 
        margin: EdgeInsets.only(bottom:20),
        width: 250,
        child:RaisedButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: Colors.grey[200],
          child: Text(sDocType + ' (' + docTypeMap[sDocType].toString()+')',style: TextStyle(color:Colors.black)),
          onPressed: () async {
            File foto = await ImagePicker.pickImage(source: ImageSource.camera);  
            if(foto==null){
            }else{
              final rsp = await DirectoryProvider().setPicture(foto,sUsuario, sDocType,docTypeMap[sDocType]);
              if(rsp == 'True'){
                int i = docTypeMap[sDocType];
                i++;
                docTypeMap.addAll({sDocType:i});
                setState(() {
                      
                });
              }else{
                _createDialog();
              }
            }
          })); 
      lstButtons.add(tempWidget);       
    } 
    return Column(children:lstButtons);
  }

  _raisedButton(){
    return RaisedButton(
      padding: EdgeInsets.only(left:2),
      color:colorBlue,
      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(100),),
      child: Icon(Icons.check,size: 50,color: Colors.white,),
      onPressed: (){
        DirectoryProvider().deleteImages();
      });
  }

  _createDialog() {
    return showDialog(
      context: context,
      builder:(context){
        return Dialog(
          shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child:Container(
            alignment: Alignment.center,
            height: 50,
            width: 50,
            child: Text('ERROR AL ENVIAR IMAGEN')));
      } 
    );
  }

  //-------------------------------styles------------------------------

  _boxDecoration(){
    return BoxDecoration(
      boxShadow:[
      BoxShadow(
        color: Colors.black,
        offset: Offset(0.0, 1.5), //(x,y)
        blurRadius: 6.0,
      ),
      ],
      borderRadius: BorderRadius.circular(100),
      border: Border.all(color: Colors.white,width: 5),);
  }

  // void _getPermissions() async {
  //   await Permission.storage.request().isGranted;
  // }

  }
