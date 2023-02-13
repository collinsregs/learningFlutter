import 'package:flutter/material.dart';
import 'package:learning_dart/constants/routes.dart';
import 'package:learning_dart/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
      ),
      body: Column(children: [
        const Text(
            "we.ve sent you an email verification please open it and verify your acount"),
        const Text(
            "if you haven't recieved a verfication email press the button below"),
        TextButton(
            onPressed: () async {
              await AuthService.firebase().sendEmailVerification();
            },
            child: const Text('resend verification email')),
        TextButton(
          onPressed: () async {
            await AuthService.firebase().logOut();
            Navigator.of(context).pushNamedAndRemoveUntil(
              registerRoute,
              (route) => false,
            );
          },
          child: const Text('restart'),
        )
      ]),
    );
  }
}
