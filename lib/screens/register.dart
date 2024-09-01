import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:pernance/models/index.dart';
import 'package:pernance/models/user.dart';

import 'package:pernance/routes/routes.dart';
import 'package:realm/realm.dart';

@RoutePage()
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
              child: RegisterForm(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("Already have an account?"),
                TextButton(
                  onPressed: () {
                    router.push(const LoginRoute());
                  },
                  style: ButtonStyle(padding: WidgetStateProperty.all(EdgeInsets.zero)),
                  child: const Text("Login", style: TextStyle(color: Colors.blue)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  RegisterFormState createState() {
    return RegisterFormState();
  }
}


class RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _displayNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();
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
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              } else if (value.length > 20) {
                return 'Your display name should be less than 20 characters';
              }
              return null;
            },
            controller: _displayNameController,
            decoration: const InputDecoration(
              labelText: 'Display Name',
            ),
          ),
          TextFormField(
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              } else if (value.length < 8) {
                return 'Password is too short, please enter more than 8 characters';
              }
              return null;
            },
            controller: _passwordController,
            decoration: const InputDecoration(
              labelText: 'Password',
            ),
          ),
          TextFormField(
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              } else if (value.length < 8) {
                return 'Password is too short, please enter more than 8 characters';
              } else if (value != _passwordController.text) {
                return 'Your password confirmation must be the same as your password';
              }
              return null;
            },
            controller: _passwordConfirmationController,
            decoration: const InputDecoration(
              labelText: 'Confirm Password',
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
                          // Register
                          final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                          await credential.user!.updateDisplayName(_displayNameController.text);
                          await realm.writeAsync(() {
                            realm.add(
                              AppUser(
                                ObjectId(),
                                credential.user!.uid,
                                credential.user!.displayName!,
                                credential.user!.email!,
                              )
                            );
                          });
                          router.push(const LoginRoute());
                        } on FirebaseAuthException catch (_) {
                          _errorMessage = 'Something bad happened, please try again later';
                        }
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.blue),
                    ),
                    child: const Text('Register', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }
}