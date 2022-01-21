import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class FirebaseServices {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn(); 
 
 

  signInWithGoogle() async {
    // final _auth = FirebaseAuth.instance;
    // final _googleSignIn = GoogleSignIn(); 
    
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
         
          print(googleSignInAccount);
         

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);
        await _auth.signInWithCredential(authCredential);
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }
  

  googleSignOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    

  }
  // child: ElevatedButton(
  //         child: Text("Logout"),
  //         onPressed: () {
  //           FirebaseServices().googleSignOut();
  //             Navigator.push(context,
  //                 MaterialPageRoute(builder: (context) => SignInScreen()));
  //           }
          
  //       ),
}
