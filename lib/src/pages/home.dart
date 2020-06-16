import 'package:cam_scanner/utils/color_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String sFont = 'Oswald';
  Map<String,String> mapaLogueo = {'Prestador':'','Password':'','Expediente':''};
  List<Icon> lstIconos = [Icon(Icons.assignment),Icon(Icons.accessibility_new),Icon(Icons.vpn_key)];
  
  @override
  Widget build(BuildContext context) {
  final Color colorBlue = ColorProvider().colorFromHex('27A9E1');

  return Scaffold(
    resizeToAvoidBottomInset: false,
    body: Column(        
      
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children : <Widget>[
            Align(
              alignment: Alignment.center,
              child: Container(
              padding: EdgeInsets.symmetric(horizontal:30),
              width: 300,
              height: 330,
              decoration:_createBoxDecorator(),
              child:Column(    
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,          
                children:
                 <Widget>[
                   _createTextField(mapaLogueo.keys.elementAt(2),lstIconos[0]),
                  
                  _createTextField(mapaLogueo.keys.elementAt(0),lstIconos[1]),
                  
                  _createTextField(mapaLogueo.keys.elementAt(1),lstIconos[2]),
                  
                  _createButton(colorBlue),
                ]
            ,),),),  
            SvgPicture.asset('assets/logo.svg',height: 50,width: 400,),        
            
          // Positioned(
          //   child:RaisedButton(
          //     color:Colors.amber,
          //     onPressed: (){
          //       Navigator.pushNamed(context, 'Camarita');
          //     },
          //     child:Text('Camara')
          //   ),
          //   bottom : 50
          //   )
          // Positioned(
          //   bottom:100,
          //    child: Container(
          //    child: RaisedButton(
          //      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          //    color:Colors.red[800],
          //    child:Text('Login with Google',style: TextStyle(fontFamily: 'Gotham',color: Colors.white)),
          //    onPressed: () async {
          //      final FirebaseUser res = await AuthProvider().loginWithGoogle();
          //      final usuario = res.displayName;
          //      res != null ? Navigator.pushNamed(context, 'Menu',arguments: usuario) : Navigator.pushNamed(context, '/'); 
          //    }),),
          // )     

        ]
                
  ),
    );
}
// Color colorFromHex(String sHexColor) {
//   final hexCode = sHexColor.replaceAll('#', '');
//   return Color(int.parse('FF$hexCode', radix: 16));
// }

  _createGradient(colorBlue) {
    return Container(
             decoration: BoxDecoration(
               color: Colors.white,
               gradient: LinearGradient(
                 stops: [0.0,0.7],
                 begin: Alignment.topCenter,
                 end: Alignment.bottomCenter,
                 colors: [Colors.white, colorBlue,Colors.green])
              ));
  }

  _createBoxDecorator() {
    return BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 4.0,
                  ),
                ],
                color:Colors.white,
                borderRadius: BorderRadius.circular(10),border: Border.all(width:2,color: Colors.white));
  }

  _createButton(colorBlue) {
    return RaisedButton(
             elevation: 5,
             color: colorBlue,
             child: Text('Comenzar trámite',style: TextStyle(fontFamily:sFont,color: Colors.white,fontSize: 17),),
               onPressed: () async {
                 Navigator.pushNamed(context, 'Menu',arguments: mapaLogueo);
              });
  }

  _createTextField(sParametro,icono) {
    return TextField( 
             onChanged: (value){
              setState(() {
               // parametro = value;
                mapaLogueo.addAll({sParametro : value});
              });
              },
             obscureText: sParametro == 'Password' ? true : false,
             decoration:InputDecoration(          
               hintText: sParametro,
               prefixIcon: icono,
                  ));
  }

  //  _loguin() async {
  //    try {
  //    await _googleSignIn.signIn();
  //    setState(() {
  //      _isLogged = true;
  //    });
       
  //    } catch (e) {
  //      print('AUTENTICACION ERROR: $e');
  //    }
  //  }


}