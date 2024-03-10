
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<User?> createUserWithEmailAndPassword({required String email, required String password}) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await credential.user?.sendEmailVerification();
      return credential.user; 
    } catch (e) {
      return null;
    }
  }

  static Future<User?> signInWithEmailAndPassword({required String email, required String password}) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user; 
    } catch (e) {
      return null;
    }
  }

  static void signOut() {
    _auth.signOut();
  } 

  static bool isUserConnected() {
    bool isConnected = false;
    _auth.userChanges().listen((User? user) {
      if (user == null) {
        isConnected = false;
      } else {
        isConnected = true;
      }
    });
    return isConnected;
  }
}