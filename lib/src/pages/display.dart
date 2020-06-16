import 'dart:io';
import 'package:cam_scanner/utils/base64_provider.dart';
import 'package:cam_scanner/utils/scanplanillas_provider.dart';
import 'package:flutter/material.dart';

class DisplayPicture extends StatefulWidget {
  DisplayPicture({Key key}) : super(key: key);

  @override
  _DisplayPictureState createState() => _DisplayPictureState();
}

class _DisplayPictureState extends State<DisplayPicture> {

  @override
  Widget build(BuildContext context) {

    double dWidth = MediaQuery. of(context). size. width;
    final List<dynamic> _lstParametrosDisplay = ModalRoute.of(context).settings.arguments;
   //final argumentos = ModalRoute.of(context).settings.arguments;
    //argumentos.add('');
    String _sImageFile = _lstParametrosDisplay[5];

    return Scaffold(
      body: Column(  
        children: <Widget>[
          Expanded(
            child: Container(
              width: dWidth,
              child: _sImageFile == '' ?  Container(height:0) : Image.file(File(_sImageFile),fit: BoxFit.fill,),
           ),),
          Container(
            decoration: BoxDecoration(
              border:Border(top:BorderSide(color: Colors.white)) ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:<Widget>[
                Container(
                    child: RaisedButton(
                      color: Colors.black,
                      child: Icon(Icons.clear,color: Colors.white,),
                      onPressed: (){
                        try {
                        final File file = File(_sImageFile);
                        file.delete();
                        //argumentos.removeRange(argumentos.length -2, argumentos.length);
                        List<dynamic> lstParametrosPickDocument = [_lstParametrosDisplay[0],_lstParametrosDisplay[1],_lstParametrosDisplay[2],_lstParametrosDisplay[3]];
                        Navigator.pushNamed(context, 'PickDocument',arguments: lstParametrosPickDocument);
                        } catch (e) {
                          print(e);
                        }              
                
                      }),
                    height: 70,
                    width: dWidth/2,
                    ),
                
                Container(
                  decoration: BoxDecoration(border:Border(left: BorderSide(color: Colors.white)) ),
                  child: RaisedButton(
                      color: Colors.black,
                      child: Icon(Icons.check,color: Colors.white,),
                      onPressed: (){
                        try {
                        print(_sImageFile.toString());
                        Base64Provider().convertToBase64(_sImageFile).then((sBase64){
                          final String sNombreArchivo = _sImageFile;
                          final sOperador = sNombreArchivo.split('-')[1];
                          ScanPlanillas().scanearPlanillas(sBase64, sOperador, sNombreArchivo).then((onValue){
                            List<dynamic> lstParametrosPickDocument = [_lstParametrosDisplay[0],_lstParametrosDisplay[1],_lstParametrosDisplay[2],_lstParametrosDisplay[3]];
                            Navigator.pushNamed(context, 'PickDocument',arguments: lstParametrosPickDocument);
                          });

                        });
                       // Navigator.pushNamed(context, 'PickDocument');
                        } catch (e) {
                          print(e);
                        }
                                             }),
                  width: dWidth/2,
                  height: 70,
                  ),
            ]),
            height: 70,
            ),
          
           
        ],
      ),
    );
  }
}