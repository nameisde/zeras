import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser user;

  Future<FirebaseUser> getUser() {
    return _auth.currentUser();
  }

  Future logout() {
    var result = _auth.signOut();
    notifyListeners();
    return result;
  }

  Future createUser({
    String firstName,
    String lastName,
    String email,
    String password,
    int saldo,
    String role,
    String alamat,
    String photoUrl,
    String uid,
  }) async {
    AuthResult u = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = u.user;
    UserUpdateInfo updateInfo = UserUpdateInfo();
    updateInfo.displayName = firstName;
    user.updateProfile(updateInfo);
    await Firestore.instance.collection('users').document(user.uid).setData(
      {
        'firstname': firstName,
        'lastname': lastName,
        'email': email,
        'password': password,
        'saldo': 0,
        'role': 'user',
        'alamat': '',
        'photoUrl': '',
        'uid': user.uid,
      },
    ).then((value) => Firestore.instance.collection('transaksi').document());
    notifyListeners();
    return u.user;
  }

  Future<FirebaseUser> loginUser({String email, String password}) async {
    var result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    notifyListeners();
    print(result.user);
    return result.user;
  }

  static String getExceptionText(Exception e) {
    if (e is PlatformException) {
      switch (e.message) {
        case 'There is no user record corresponding to this identifier. The user may have been deleted.':
          return 'User with this email address not found.';
          break;
        case 'The password is invalid or the user does not have a password.':
          return 'Invalid password.';
          break;
        case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
          return 'No internet connection.';
          break;
        case 'The email address is already in use by another account.':
          return 'This email address already has an account.';
          break;
        default:
          return 'Unknown error occured.';
      }
    } else {
      return 'Unknown error occured.';
    }
  }
}
