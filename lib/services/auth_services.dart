import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  // Google Authentication

  static Future<User> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final User user = authResult.user;

    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);

      return user;
    }

    return null;
  }

  // Email Authentication

  static Future<User> signInWithEmailAndPassword(
      String email, String password) async {
    await Firebase.initializeApp();
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      User user = result.user;

      assert(user != null);
      assert(await user.getIdToken() != null);

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<User> signUpWithEmailAndPassword(
      String email, String password) async {
    await Firebase.initializeApp();
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      User user = result.user;

      assert(user != null);
      assert(await user.getIdToken() != null);

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Guest Authentication

  static Future<User> signInAnonymous() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      User user = userCredential.user;

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign out

  static Future<void> signOut() async {
    _auth.signOut();
  }

  static Future<String> getUserId() async {
    final User user = _auth.currentUser;
    return user.uid;
  }

  static Stream<User> get firebaseUserStream => _auth.authStateChanges();
}
