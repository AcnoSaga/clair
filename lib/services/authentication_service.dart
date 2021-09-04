import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  User get currentUser => _firebaseAuth.currentUser!;

  Future<User> signInWithGoogle() async {
    GoogleSignInAccount googleSignInAccount = (await googleSignIn.signIn())!;
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final authResult = await _firebaseAuth.signInWithCredential(credential);
    return authResult.user!;
  }
}

final authenticationService = AuthenticationService();
