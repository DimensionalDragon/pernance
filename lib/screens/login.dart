import 'package:auto_route/auto_route.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pernance/models/index.dart';

import 'package:pernance/routes/routes.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: LoginForm(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("Don't have an account?"),
                TextButton(
                  onPressed: () {
                    router.push(const RegisterRoute());
                  },
                  style: ButtonStyle(padding: WidgetStateProperty.all(EdgeInsets.zero)),
                  child: const Text("Register", style: TextStyle(color: Colors.blue),),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}


class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              } else if (!EmailValidator.validate(value)) {
                return 'Invalid email address';
              }
              return null;
            },
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
            ),
          ),
          TextFormField(
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            controller: _passwordController,
            decoration: const InputDecoration(
              labelText: 'Password',
            ),
          ),
          const SizedBox(height: 20),
          Column(
              children: <Widget>[
                if (_errorMessage != '') Text(_errorMessage, style: const TextStyle(color: Colors.red),),
                SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {                     
                          // Login
                          final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );

                          // Open Realm
                          final firebaseIDToken = await credential.user?.getIdToken();
                          if (firebaseIDToken != null) {
                            RealmProvider().initializeRealm(firebaseIDToken);
                          }
                          
                          // Redirect to dashboard
                          router.replace(const DashboardRoute());
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found' || e.code == 'wrong-password' || e.code == 'invalid-credential') {
                            setState(() {
                              _errorMessage = 'Invalid email or password';
                            });
                          } else {
                            _errorMessage = 'Something bad happened, please try again later';
                          }
                        }
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.blue),
                    ),
                    child: const Text('Login', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }
}
