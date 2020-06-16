import 'dart:convert';
import 'dart:io';

class Base64Provider{

Future<String> convertToBase64(String _imagePath) async {
try {
 // final imageFile = ImagePicker.pickImage(source: source);
  final File file = File(_imagePath);
 // final _imageFile = ImageProcess.decodeImage(file.readAsBytesSync());
  String base64Image = base64Encode(file.readAsBytesSync());
  return base64Image;

} catch (e) {
  print(e.toString());
  return 'error';
}
  }
}