import 'package:auth_buttons/auth_buttons.dart';
import 'package:firestoreapp/pages/home_page.dart';
import 'package:firestoreapp/pages/register_page.dart';
import 'package:firestoreapp/services/auth_service.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final _formKey = GlobalKey<FormState>;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 320,
                      child: Column(
                        children: [
                          buildEmailInput(),
                          buildPasswordInput(),
                        ],
                      ),
                    ),
                    buildEmailSignin(),
                    buildEmailSignup(),
                  ],
                ),
              ),
              const Divider(
                thickness: 2,
                color: Colors.grey,
              ),
              buildGoogleSignin(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildGoogleSignin() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GoogleAuthButton(
        onPressed: () {
          AuthService().signInWithGoogle().then((value) {
            // Check UID, if it doesn't exists in FireStore, go to AddInfo Page

            // if it exist in FireStore, go to HomePage
          });
        },
      ),
    );
  }

  Widget buildEmailSignup() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Don't have an account?"),
          TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegisterPage(),
                  ));
            },
            child: const Text("Register now !"),
          )
        ],
      ),
    );
  }

  Widget buildEmailSignin() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: EmailAuthButton(
        onPressed: () {
          AuthService()
              .signInWithEmail(_email.text, _password.text)
              .then((value) => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  )));
        },
      ),
    );
  }

  TextFormField buildEmailInput() {
    return TextFormField(
      controller: _email,
      decoration: const InputDecoration(
        labelText: "E-mail",
      ),
    );
  }

  TextFormField buildPasswordInput() {
    return TextFormField(
      controller: _password,
      obscureText: true,
      decoration: const InputDecoration(
        labelText: "Password",
      ),
    );
  }
}
