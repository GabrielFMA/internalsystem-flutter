import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:internalsystem/const/const.dart';
import 'package:internalsystem/firebase_options.dart';
import 'package:internalsystem/screens/login_screen.dart';
import 'package:internalsystem/screens/main_screen.dart';
import 'package:internalsystem/store/auth_store.dart';
import 'package:internalsystem/store/register_store.dart';
import 'package:internalsystem/store/request_store.dart';
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
          Provider<RegisterStore>(create: (_) => RegisterStore()),
          Provider<RequestStore>(create: (_) => RequestStore()),
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
            '/login': (context) => RouteGuard(
                  isAuthenticated: (user) => user != null,
                  redirectIfAuthenticated: true,
                  child: const LoginScreen(),
                ),
            '/home': (_) => RouteGuard(
                  child: const MainScreen(),
                  isAuthenticated: (user) => user != null,
                ),
            '/register': (_) => RouteGuard(
                  child: const MainScreen(),
                  isAuthenticated: (user) => user != null,
                ),
            '/settings': (_) => RouteGuard(
                  child: const MainScreen(),
                  isAuthenticated: (user) => user != null,
                ),
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
  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    final user = FirebaseAuth.instance.currentUser;

    if (await Provider.of<AuthStore>(context, listen: false)
        .checkWebAccountAccess(user?.uid)) {
      setState(() {
        print('Usuário logado: ${user?.uid}');
        navigateTo('/home', context);
      });
      
    } else {
      FirebaseAuth.instance.signOut();
      setState(() {
        print('Nenhum usuário logado: ${user?.uid}');
        navigateTo('/login', context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildLoadingScreen();
  }
}

class RouteGuard extends StatelessWidget {
  final Widget child;
  final bool Function(User?) isAuthenticated;
  final bool redirectIfAuthenticated;

  const RouteGuard({
    super.key,
    required this.child,
    required this.isAuthenticated,
    this.redirectIfAuthenticated = false,
  });

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (redirectIfAuthenticated && isAuthenticated(user)) {
      navigateTo('/home', context);
      return buildLoadingScreen();
    } else if (redirectIfAuthenticated && isAuthenticated(user)) {
      navigateTo('/register', context);
      return buildLoadingScreen();
    } else if (redirectIfAuthenticated && isAuthenticated(user)) {
      navigateTo('/settings', context);
      return buildLoadingScreen();
    } else if (!redirectIfAuthenticated && !isAuthenticated(user)) {
      navigateTo('/login', context);
      return buildLoadingScreen();
    } else {
      return child;
    }
  }
}
