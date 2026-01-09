import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
class AuthService {
  AuthService(this._auth, this._googleSignIn);

  final FirebaseAuth? _auth;
  final GoogleSignIn _googleSignIn;

  Stream<User?> get authStateChanges => _auth?.authStateChanges() ?? const Stream<User?>.empty();
  User? get currentUser => _auth?.currentUser;

  Future<UserCredential> signInEmail({required String email, required String password}) {
    final auth = _ensureAuth();
    return auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> registerEmail({required String email, required String password}) {
    final auth = _ensureAuth();
    return auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> sendPasswordReset({required String email}) {
    final auth = _ensureAuth();
    return auth.sendPasswordResetEmail(email: email);
  }

  Future<UserCredential> signInGoogle() async {
    final authInstance = _ensureAuth();
    final account = await _googleSignIn.signIn();
    if (account == null) {
      throw FirebaseAuthException(code: 'google_sign_in_cancelled');
    }
    final auth = await account.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: auth.accessToken,
      idToken: auth.idToken,
    );
    return authInstance.signInWithCredential(credential);
  }

  Future<UserCredential> signInApple() async {
    final authInstance = _ensureAuth();
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.iOS) {
      throw FirebaseAuthException(code: 'apple_sign_in_unsupported');
    }
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [AppleIDAuthorizationScopes.email, AppleIDAuthorizationScopes.fullName],
    );
    final oauth = OAuthProvider('apple.com').credential(
      idToken: credential.identityToken,
      accessToken: credential.authorizationCode,
    );
    return authInstance.signInWithCredential(oauth);
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    if (_auth == null) {
      return;
    }
    await _auth.signOut();
  }

  FirebaseAuth _ensureAuth() {
    final auth = _auth ?? (Firebase.apps.isNotEmpty ? FirebaseAuth.instance : null);
    if (auth == null) {
      throw FirebaseAuthException(
        code: 'no_firebase_app',
        message: 'Firebase is not configured.',
      );
    }
    return auth;
  }
}
