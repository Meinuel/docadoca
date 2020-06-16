import 'package:cam_scanner/utils/color_provider.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:numberpicker/numberpicker.dart';

class Menu extends StatefulWidget {
  Menu({Key key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {

  List<CameraDescription> lstCameras;
  Icon iconoFlecha = Icon(Icons.keyboard_arrow_down);
  String sFont = 'Oswald';
  final dFormat = DateFormat("yyyy-MM-dd");
  DateTime dSelectedDate = DateTime.now();
  int iSelectedNumber = 5;
  final Color colorBlue = ColorProvider().colorFromHex('27A9E1');

  @override
  Widget build(BuildContext context) {
    
    final Map<String,String> _map = ModalRoute.of(context).settings.arguments;

    return _createBuild(_map);
  }
   
   _createBuild(_map)  {

     final String sUsuario = _map.values.elementAt(0);
     final String sExpediente = _map.values.elementAt(2);
     double width = MediaQuery.of(context).size.width/8;
     double height = MediaQuery.of(context).size.height;
     
     getCameras();
    
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
            backgroundColor: Colors.white,
            leading: Container(height:0),
            centerTitle: true,
            title: SvgPicture.asset('assets/logo.svg',height: 25,width: 200),
            ),
          body:Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    margin:EdgeInsets.only(bottom:10),
                    child: Text('Usuario : $sUsuario',style: TextStyle(fontFamily: sFont ,fontSize: 25,color: Colors.black),)
                  ),
                  Container(
                    child: Text('Expediente : $sExpediente',style: TextStyle(fontFamily: sFont ,fontSize: 25,color:Colors.black),)
                    )],),
              Column(
                children: <Widget>[
                  Container(
                    margin:EdgeInsets.only(bottom:10),
                    child: Text('Fecha:',style: TextStyle(fontFamily: sFont ,fontSize: 25,color: Colors.black),)
                    ),
                   _createContainerTimeField(width),],),
              Column(
                children: <Widget>[
                  Container(
                    margin:EdgeInsets.only(bottom:10),
                    child: Text('Partición:',style: TextStyle(fontFamily: sFont ,fontSize: 25,color: Colors.black),)
                  ),
                  _createContainerNumberPicker(width), 
                ],),      
               // SizedBox(height: height/15),
              _createArrowButton(sExpediente,sUsuario,width),

              ],),
        );
      }

  getCameras() async {
    lstCameras = await availableCameras();
  }
    
 //-------------------------------Date Time Field------------------------------------

  _createContainerTimeField(width) {
    return Container(
      decoration: _numberPickerDecoration(Colors.white, true),
      padding: EdgeInsets.only(left:width/3),
      margin: EdgeInsets.symmetric(horizontal:width),
      child: _createTimeField());
  }
  _createTimeField(){
    return DateTimeField(
      onChanged: (value){
        setState(() {
          dSelectedDate = value;
        });
        },
      initialValue: DateTime.now(),
      format: dFormat,
      onShowPicker: (context, currentValue){                                       
      return showDatePicker(     
        context: context,
        initialDate: currentValue ?? DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100)
      );
      });
  }

//-------------------------------Number Picker----------------------------------

  _createContainerNumberPicker(width){
    return Container(
      decoration: _numberPickerDecoration(Colors.black,true),
      margin: EdgeInsets.symmetric(horizontal:width),
      alignment: Alignment.center,
      height:50,
      child:_createNumberPicker());
  }
  _createNumberPicker(){
    return NumberPicker.horizontal(
      zeroPad: true,
      decoration: _numberPickerDecoration(colorBlue,false),
      highlightSelectedValue: false,
      initialValue: 5, 
      minValue: 1, 
      maxValue: 10, 
      onChanged: (value){                   
        iSelectedNumber = value ;
        setState(() {
            
        });
        });
  }

//---------------------------------Raised Button-----------------------------------

  _createArrowButton(sExpediente,sUsuario,width) {
    return Container(
      decoration: _arrowButtonDecoration(),
          //margin: EdgeInsets.symmetric(horizontal:width*3.2),
      width: 70,
      height: 70,
      child:RaisedButton(
        padding: EdgeInsets.only(left:2),
        color:colorBlue,
        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(100),),
        child: Icon(Icons.arrow_forward,size: 50,color: Colors.white,),
        onPressed: ()async{               
        List<dynamic> lstParametros = [lstCameras,dSelectedDate,sExpediente,sUsuario];
        Navigator.pushNamed(context, 'PickDocument',arguments: lstParametros);         
            },));
  }
  //----------------------------Styles-------------------------------
  
  _numberPickerDecoration(color,bContainer) { 
    BorderSide wBorder = new BorderSide(style: BorderStyle.solid,color: bContainer == true ? Colors.black : color);
    return BoxDecoration( 
      borderRadius: BorderRadius.circular(10),
      color: bContainer == true ? Colors.white : null,
      border: new Border(
        right: wBorder,
        left: wBorder,
        top: wBorder,
        bottom: wBorder
    ),);
  }

  _arrowButtonDecoration(){
    return BoxDecoration(
      border: Border.all(color: Colors.white,width: 5),
      boxShadow:  [
        BoxShadow(
          color: Colors.black,
          offset: Offset(0.0, 1.5), //(x,y)
          blurRadius: 6.0,
        ),],
      borderRadius: BorderRadius.circular(100),
    );
  }
}