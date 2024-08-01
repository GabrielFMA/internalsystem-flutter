import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:internalsystem/const/const.dart';
import 'package:internalsystem/firebase_options.dart';
import 'package:internalsystem/screens/login_screen.dart';
import 'package:internalsystem/screens/main_screen.dart';
import 'package:internalsystem/store/auth_store.dart';
import 'package:provider/provider.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void main() async {
  setUrlStrategy(PathUrlStrategy());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
            '/login': (_) => const LoginScreen(),
            '/home': (_) => const MainScreen(),
          },
          home: const AuthChecker(),
        ));
  }
}

class AuthChecker extends StatefulWidget {
  const AuthChecker({super.key});

  @override
  _AuthCheckerState createState() => _AuthCheckerState();
}

class _AuthCheckerState extends State<AuthChecker> {
  User? _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    final user = await _getCurrentUser();
    setState(() {
      _user = user;
      _isLoading = false;
    });

    await _handleNavigation();
  }

  Future<User?> _getCurrentUser() async {
    return FirebaseAuth.instance.currentUser;
  }

  Future<void> _handleNavigation() async {
    if (await Provider.of<AuthStore>(context, listen: false)
        .checkWebAccountAccess(_user?.uid)) {
      navigateTo('/home', context);
    } else {
      navigateTo('/login', context);
      FirebaseAuth.instance.signOut();
    }
  }

  Widget _buildLoadingScreen() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return _buildLoadingScreen();
    } else {
      // Não há necessidade de retornar nada aqui,
      // a navegação já foi tratada no método _handleNavigation
      return Container();
    }
  }
}
