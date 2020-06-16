import 'package:flutter/material.dart';

class ColorProvider{
  Color colorFromHex(String sHexColor) {
  final hexCode = sHexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));
}

Map<String,int> createDocTypeMap(){

  Map<String,int> docTypeMap = {};
  List<String> lstDocType = ['Factura','Pedido médico','Informe médico','Detalle de factura','Historia clínica'];
  for (var item in lstDocType) { 
    docTypeMap[item]=0;
  }
  return docTypeMap;

}
  
}