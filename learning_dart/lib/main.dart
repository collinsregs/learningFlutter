import 'package:flutter/material.dart';
import 'package:learning_dart/constants/routes.dart';
import 'package:learning_dart/services/auth/auth_service.dart';
import 'package:learning_dart/views/login_views.dart';
import 'package:learning_dart/views/notes_view.dart';
import 'package:learning_dart/views/register_view.dart';
import 'package:learning_dart/views/verify_email_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const HomePage(),
    routes: {
      loginRoute: (context) => const LoginView(),
      registerRoute: (context) => const RegisteView(),
      notesRoute: (context) => const NotesView(),
      verifyEmailRoute: (context) => const VerifyEmailView(),
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AuthService.firebase().initialize(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = AuthService.firebase().currentUser;
              if (user != null) {
                if (user.isEmailVerified) {
                  return const NotesView();
                } else {
                  return const VerifyEmailView();
                }
              } else {
                return const LoginView();
              }

            default:
              return const Scaffold(
                  body: Center(child: CircularProgressIndicator()));
          }
        });
  }
}
