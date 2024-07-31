import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:internalsystem/const/const.dart';
import 'package:internalsystem/store/auth_store.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AuthStore>(create: (_) => AuthStore()),
        ],
        child: MaterialApp(
          title: "Web system study",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: backgroundColor,
            brightness: Brightness.dark,
            textSelectionTheme: const TextSelectionThemeData(
              cursorColor: selectionTextColor,
              selectionColor: selectionTextColor,
              selectionHandleColor: selectionTextColor,
            ),
          ),
          routes: {
            '/login': (_) => const MainScreen(),
            '/Home': (_) => const testScreen(),
          },
          home: const AuthChecker(),
        ));
  }
}

class AuthChecker extends StatelessWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context) {
    final authStore = Provider.of<AuthStore>(context);
    return FutureBuilder<User?>(
      future: _getCurrentUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (snapshot.hasData && snapshot.data != null) {
            final currentUser = snapshot.data!;
            //authStore.recoveryData(currentUser.uid);
            print('Usuário logado: ${currentUser.uid}');
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacementNamed('/home');
            });
            return Container();
          } else {
            print('Sem usuário');
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacementNamed('/login');
            });
            return Container();
          }
        }
      },
    );
  }

  Future<User?> _getCurrentUser() async {
    final user = FirebaseAuth.instance.currentUser;
    return user;
  }
}
