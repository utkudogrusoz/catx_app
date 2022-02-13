import 'package:catx_app/utilities/services/auth_service.dart';
import 'package:catx_app/utilities/ui/pages/auth/view/auth_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final AuthenticationService _authService = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();

            await _authService.signOut().then((value) {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => AuthView()), (route) => true);
            }).then((value) async => await prefs.remove('authWay'));
          },
          child: Text('Çıkış Yap'),
        ),
      ),
    );
  }
}
