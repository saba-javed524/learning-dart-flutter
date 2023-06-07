import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:learningdart/firebase_options.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //formkey
  final _formKey = GlobalKey<FormState>();

  //editing controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    void initState() {
      super.initState();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: FutureBuilder(
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          builder: (context, snapshot) {
            return Column(
              children: <Widget>[
                TextFormField(
                  controller: emailController,
                  enableSuggestions: true,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: "Enter Email",
                  ),
                ),
                TextFormField(
                  controller: passwordController,
                  enableSuggestions: false,
                  autocorrect: false,
                  // keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(
                    hintText: "Enter Password",
                  ),
                ),
                TextButton(
                    onPressed: () async {
                      final email = emailController.text;
                      final password = passwordController.text;

                      try {
                        final UserCredential = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: email, password: password);
                        print(UserCredential);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          print("User Not Found");
                        } else {
                          print("Something else happened");
                          print(e.code);
                        }
                      }
                    },
                    child: Text("Login"))
              ],
            );
          }),
    );
  }
}
