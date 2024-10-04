import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthHelper {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> anonymousLogIn() async {
    UserCredential credential = await auth.signInAnonymously();

    return credential.user;
  }

  Future<User?> signUp(
      {required String email, required String password}) async {
    UserCredential credential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);

    return credential.user;
  }

  Future<User?> signIn(
      {required String email, required String password}) async {
    UserCredential credential =
        await auth.signInWithEmailAndPassword(email: email, password: password);

    return credential.user;
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> logOut() async {
    await auth.signOut();
    await GoogleSignIn().signOut();
  }

  // Future<UserCredential> signInWithFacebook() async {
  //   // Trigger the sign-in flow
  //   final LoginResult loginResult = await FacebookAuth.instance.login();
  //
  //   // Create a credential from the access token
  //   final OAuthCredential facebookAuthCredential =
  //       FacebookAuthProvider.credential(loginResult.accessToken.token);
  //
  //   // Once signed in, return the UserCredential
  //   return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  // }

  AuthHelper._();
  static final AuthHelper instance = AuthHelper._();
}
