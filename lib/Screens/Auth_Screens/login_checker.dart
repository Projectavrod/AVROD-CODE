



import 'package:avrod/features/home/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class LoginChecker extends StatelessWidget {
  const LoginChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Checking Authstate Changes
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {

          if (snapshot.hasData) {
            // print('{-----------------------------}');
            // print(snapshot.data?.email);
            return const HomeScreen();

          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}