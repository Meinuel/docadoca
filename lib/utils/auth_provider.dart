import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider{
  final FirebaseAuth _auth =FirebaseAuth.instance;
  

   registerWithEmail (String email, String password) async {
    //await _auth.verifyPhoneNumber(phoneNumber: null, timeout: null, verificationCompleted: null, verificationFailed: null, codeSent: null, codeAutoRetrievalTimeout: null)
    
    AuthResult authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    print(authResult);
   }

   signInWithEmail (String email, String password) async {
      try {
        
        AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
        FirebaseUser user = result.user;
        AdditionalUserInfo data = result.additionalUserInfo;
        print(data);
        if(user != null){
          return true;
        }else{
          return false;
        }
      } catch (e) {
        print(e);
        return false;
      }
  }

  singOut () async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  loginWithGoogle() async {
    try {
      GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],);
      GoogleSignInAccount account = await _googleSignIn.signIn(); 
      if(account == null)
        return false;
       AuthResult res = await _auth.signInWithCredential(GoogleAuthProvider.getCredential(
         idToken: (await account.authentication).idToken,
         accessToken: (await account.authentication).accessToken));
         
         if(res.user == null)
           return false;
           return true;
    } catch (e) {
      print(e);
    }

  }
  
}