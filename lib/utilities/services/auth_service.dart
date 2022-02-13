import 'package:catx_app/utilities/functions/show_custom_dialog.dart';
import 'package:catx_app/utilities/models/user_model.dart';
import 'package:catx_app/utilities/ui/pages/home/view/home_view.dart';
import 'package:catx_app/utilities/ui/pages/welcome/view/welcome_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _userCollection = FirebaseFirestore.instance.collection('users');
  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

  Future<void> registerEmailAndPassword({
    @required BuildContext? context,
    @required GlobalKey<FormState>? formKey,
    @required TextEditingController? controllerEmail,
    @required TextEditingController? controllerName,
    @required TextEditingController? controllerPassword,
    @required String? email,
    @required String? name,
    @required String? password,
  }) async {
    if (formKey!.currentState!.validate()) {
      email = controllerEmail!.text.toLowerCase().trim();
      password = controllerPassword!.text;
      name = controllerName!.text;
      try {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        var userUid = userCredential.user!.uid;

        CollectionReference users = FirebaseFirestore.instance.collection('users');

        await users
            .doc(userUid)
            .set(
              UserModel(
                email: email,
                name: name,
                uid: userUid,
                picture: '',
                role: 'Öğrenci',
              ).toJson(),
            )
            .then(
              (value) => showCustomDialog(
                context: context,
                content: 'Başarılı Kayıt.',
                backgroundColor: Colors.greenAccent,
              ),
            );
      } catch (e) {
        showCustomDialog(
          context: context,
          content: 'Hatalı Email ya da Şifre.',
          backgroundColor: Colors.orangeAccent,
        );
      }
    } else {
      showCustomDialog(
        context: context,
        content: 'Gerekli Alanları Doldurunuz.',
        backgroundColor: Colors.redAccent,
      );
    }
  }

  Future<void> signInEmailAndPassword({
    @required BuildContext? context,
    @required GlobalKey<FormState>? formKey,
    @required TextEditingController? controllerEmail,
    @required TextEditingController? controllerPassword,
    @required String? email,
    @required String? password,
  }) async {
    if (formKey!.currentState!.validate()) {
      email = controllerEmail!.text.toLowerCase().trim();
      password = controllerPassword!.text;
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then(
              (value) => showCustomDialog(
                context: context,
                content: 'Başarılı Giriş.',
                backgroundColor: Colors.greenAccent,
              ),
            )
            .then(
              (value) => Navigator.push(
                context!,
                MaterialPageRoute(
                  builder: (context) => const WelcomeView(),
                ),
              ),
            );
      } catch (e) {
        showCustomDialog(
          context: context,
          content: 'Hatalı Email ya da Şifre.',
          backgroundColor: Colors.orangeAccent,
        );
      }
    } else {
      showCustomDialog(
        context: context,
        content: 'Gerekli Alanları Doldurunuz.',
        backgroundColor: Colors.redAccent,
      );
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final googleAuth = await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential).then((user) {
      FirebaseFirestore.instance.collection('users').where('mail', isEqualTo: user.user!.email).get().then((value) {
        if (value.docs.isNotEmpty) {
          //Get.offAll(MyStatefulWidget());
        } else {
          updateUser(
            user.user!.email!,
            user.user!.displayName!,
            user.user!.photoURL!,
            'öğrenci',
            user.user!.uid,
          );
          // Get.offAll(MyStatefulWidget());
        }
      });

      return user;
    });
  }

  void updateUser(
    String mail,
    String name,
    String picture,
    String role,
    String uid,
  ) {
    _userCollection.doc(_auth.currentUser!.uid).set(
          UserModel(
            name: name,
            email: mail,
            picture: picture,
            uid: uid,
            role: role,
          ).toJson(),
        );
  }

  Future<void> resetDatas({
    required TextEditingController? controllerEmail,
    required TextEditingController? controllerPassword,
    required TextEditingController? controllerName,
    required String? email,
    required String? password,
    required String? name,
  }) async {
    controllerEmail!.text = '';
    controllerPassword!.text = '';
    controllerName!.text = '';
    email = '';
    name = '';
    password = '';
  }

  
  Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    var authWayPrefs = prefs.getString('authWay');
    CollectionReference users = _firestore.collection('users');
    if (authWayPrefs == '') {
      await users.doc(_auth.currentUser!.uid).update({'isOnline': false});
      await _auth.signOut();
    } else if (authWayPrefs == 'google') {
      await googleSignIn.signOut();
    }
  }

    bool isUserActive() {
    if (_auth.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }


}
