import 'dart:io';
import 'package:cam_scanner/utils/base64_provider.dart';
import 'package:cam_scanner/utils/scanplanillas_provider.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

class DirectoryProvider {

   Directory directoryPath;

   Future<String> setPicture (File file,String sUsuario,String sDocType,int iNroPic) async {
      String albumName = 'DocapixMedia';
      Directory path = file.parent;
      directoryPath = path;
      String sNroPic = iNroPic.toString();
      final String sFile = path.path + '/$sUsuario-60-$sDocType-$sNroPic.jpg';
      final File sFinalFile = await file.rename(sFile);
      String sBase64 = await Base64Provider().convertToBase64(sFile);
      String rsp = await ScanPlanillas().scanearPlanillas(sBase64, '60', '/$sUsuario-60-$sDocType-$sNroPic.jpg');
     // Uint8List decodedBytes = base64Decode(sBase64);
      //final result = await ImageGallerySaver.saveImage(decodedBytes);
      GallerySaver.saveImage(sFinalFile.path, albumName :albumName).then((bool success){
          success ? print('Imagen guardada con exito') : print('Error');
      });
      return rsp;
   }

   deleteImages() async {

     Directory directoryPath = await getExternalStorageDirectory();
    // final String sDirectoryPathAbsolute = directoryPath.path + '/Pictures/DocapixMedia';
     final List lstDirectory = await directoryPath.list().toList();
     for (Directory item in lstDirectory) {
       final List pictureDirectory = await item.list().toList();
       for (File item in pictureDirectory) {
         item.delete();
       }
     }
   }
}