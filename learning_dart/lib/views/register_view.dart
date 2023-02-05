import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learning_dart/constants/routes.dart';

import '../utillities/show_error_dialog.dart';

class RegisteView extends StatefulWidget {
  const RegisteView({super.key});

  @override
  State<RegisteView> createState() => _RegisteViewState();
}

class _RegisteViewState extends State<RegisteView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Column(
        children: [
          TextField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            decoration:
                const InputDecoration(hintText: 'enter your email here'),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration:
                const InputDecoration(hintText: 'enter your password here'),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                final user = FirebaseAuth.instance.currentUser;
                await user?.sendEmailVerification();
                Navigator.of(context).pushNamed(verifyEmailRoute);
              } on FirebaseAuthException catch (e) {
                if (e.code == 'weak-password') {
                  await showErrorDialog(
                    context,
                    'password is week',
                  );
                } else if (e.code == 'email-already-in-use') {
                  await showErrorDialog(
                    context,
                    'email is already in use',
                  );
                } else if (e.code == 'invalid-email') {
                  await showErrorDialog(
                    context,
                    'invalid email address',
                  );
                } else {
                  await showErrorDialog(
                    context,
                    'Error:${e.code}',
                  );
                }
              } catch (e) {
                await showErrorDialog(
                  context,
                  e.toString(),
                );
              }
            },
            child: const Text('register'),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(loginRoute, (route) => false);
              },
              child: const Text('Already registerd? Login hear'))
        ],
      ),
    );
  }
}
