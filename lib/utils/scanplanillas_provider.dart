import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class ScanPlanillas{
  String _url = 'http://apligem.activiaweb.com.ar:9090/Service1.asmx?';
  String rsp;

  Future<String> scanearPlanillas(sBase64,sOperador,sNombreArchivo) async {

    String requestBody = 
 '''<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <ScanPlanillas xmlns="http://tempuri.org/">
      <base64>$sBase64</base64>
      <Operador>$sOperador</Operador>
      <NombreArchivo>$sNombreArchivo</NombreArchivo>
    </ScanPlanillas>
  </soap:Body>
</soap:Envelope>''';

 try {
 
  http.Response response = await http.post(
    _url,
    headers: {
        'Host'        : 'apligem.activiaweb.com.ar',
        'Content-Type': 'text/xml; charset=utf-8',
        'SOAPAction'  : 'http://tempuri.org/ScanPlanillas'
      },
      body: utf8.encode(requestBody),
  );

  rsp =response.body;
  
  final raw = xml.parse(rsp);
  final elements = raw.findAllElements('ScanPlanillasResult');
  var respuesta = elements.single.text;
  
  return respuesta;
   } catch (e) {
     return 'Error, chequea tu conexión';
  }

  }
}