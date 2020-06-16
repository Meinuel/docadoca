import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';


class Camera extends StatefulWidget {
  Camera({Key key}) : super(key: key);

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {

  bool bLintern=false;
  CameraController controller; 
  Future<void> initializeControllerFuture;
  Icon icono = Icon(Icons.flash_on);
  final AsyncMemoizer _memoizer = AsyncMemoizer();
  @override

  Widget build(BuildContext context) {

    final List<dynamic> lstParametrosCameraPage = ModalRoute.of(context).settings.arguments;
    final List<CameraDescription> cameras = lstParametrosCameraPage[0];
   // final String sExpediente = lstParametrosCameraPage[2];
    final String sUsuario = lstParametrosCameraPage[3];
    final String sDocType = lstParametrosCameraPage[4];
    controller = new CameraController(cameras[0], ResolutionPreset.max);
    initializeCamera();

   // controller.dispose();

    return Scaffold(
      body: _returnCamera(sUsuario,sDocType,lstParametrosCameraPage)
    );
  }

  _returnCamera(String sUsuario,String sDocType,List<dynamic>argumentos) {
    return FutureBuilder<void>(
      future: initializeControllerFuture,
      builder: (context,snapshot){
        if (snapshot.connectionState == ConnectionState.done) {
      // If the Future is complete, display the preview.
      return Stack(
        alignment: Alignment.bottomCenter,
              children:<Widget>[
               OrientationBuilder(builder: (context,orientation){
                 if(orientation == Orientation.portrait){
                    return 
                    AspectRatio(
                      aspectRatio: controller.value.aspectRatio,
                      child: CameraPreview(controller));
                  }else{
                   return RotatedBox(
                     child: CameraPreview(controller),
                     quarterTurns: 3);
                 }

               }),
                  Positioned(
                    bottom: 50,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,              
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Colors.white,width: 3),),
                      width: 80,
                      height: 80,
                      child:RaisedButton(   
                        color: Colors.transparent,                 
                        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(100),),
                      onPressed: () async {
                        //DirectoryProvider().setPicture(sUsuario,sDocType).then((sFilePicture) async {
                       // await controller.takePicture(sFilePicture);
                      //  argumentos.add(sFilePicture);
                               //controller.dispose();
                      //  Navigator.pushNamed(context, "Display",arguments: argumentos);
                         //    });               
                      },)),
                  )
                   //child:AspectRatio(
                      //aspectRatio: 16.0/27.0,
                      // child: CameraPreview(controller)),
                // ),          
                  //  GestureDetector(
                  //    child: Container(      
                  //      alignment: Alignment.center,
                  //      child: Container(
                  //        child:IconButton(
                  //         icon: Icon(Icons.camera_alt,color: Colors.black,size: 30,),
                  //         onPressed:() async {
                  //            DirectoryProvider().setPicture(sUsuario,sDocType).then((sFilePicture) async {
                  //              await controller.takePicture(sFilePicture);
                  //              argumentos.add(sFilePicture);
                  //              //controller.dispose();
                  //              Navigator.pushNamed(context, "Display",arguments: argumentos);
                  //            });               
                  //         }                     
                  //        ),
                  //        width: 60,
                  //        height: 60,
                  //        decoration: BoxDecoration(color:Colors.white,borderRadius:BorderRadius.circular(60)),),
                  //      height: 90, 
                  //      color:Colors.black),
                  //  ),
      ])
              ;} else {
      // Otherwise, display a loading indicator.
      return Center(child: CircularProgressIndicator());
    }
      });
  }

  initializeCamera() async {
    return this._memoizer.runOnce(() async{
      initializeControllerFuture = controller.initialize();
    });
    }
}