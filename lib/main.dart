// ignore_for_file: library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:internalsystem/constants/constants.dart';
import 'package:internalsystem/firebase_options.dart';
import 'package:internalsystem/screens/login_screen.dart';
import 'package:internalsystem/screens/main_screen.dart';
import 'package:internalsystem/store/auth_store.dart';
import 'package:internalsystem/store/register_store.dart';
import 'package:internalsystem/store/request_store.dart';
import 'package:internalsystem/store/update_store.dart';
import 'package:internalsystem/utils/navigation_utils.dart';
import 'package:internalsystem/widgets/main/loading_screen.dart';
import 'package:internalsystem/widgets/register/register_widget.dart';
import 'package:internalsystem/widgets/home/home_widget.dart';
import 'package:internalsystem/widgets/users/user_widget.dart';
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
        Provider<UpdateStore>(create: (_) => UpdateStore()),
      ],
      child: MaterialApp(
        title: "StoreCar",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: backgroundColor,
          brightness: Brightness.dark,
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: selectionTextColor,
            selectionColor: selectionTextColor,
            selectionHandleColor: selectionTextColor,
          ),
          pageTransitionsTheme: PageTransitionsTheme(
            builders: {
              TargetPlatform.android: NoTransitionPageTransitionsBuilder(),
              TargetPlatform.iOS: NoTransitionPageTransitionsBuilder(),
              TargetPlatform.macOS: NoTransitionPageTransitionsBuilder(),
              TargetPlatform.windows: NoTransitionPageTransitionsBuilder(),
              TargetPlatform.fuchsia: NoTransitionPageTransitionsBuilder(),
              TargetPlatform.linux: NoTransitionPageTransitionsBuilder(),
            },
          ),
        ),
        routes: {
          '/login': (context) => RouteGuard(
                isAuthenticated: (user) => user != null,
                redirectIfAuthenticated: true,
                child: const LoginScreen(),
              ),
          '/home': (_) => RouteGuard(
                child: const MainScreen(screen: HomeWidget()),
                isAuthenticated: (user) => user != null,
              ),
          '/register': (_) => RouteGuard(
                child: const MainScreen(screen: RegisterWidget()),
                isAuthenticated: (user) => user != null,
              ),
          '/settings': (_) => RouteGuard(
                child: const MainScreen(screen: HomeWidget()),
                isAuthenticated: (user) => user != null,
              ),
          '/users': (_) => RouteGuard(
                child: const MainScreen(screen: UserWidget()),
                isAuthenticated: (user) => user != null,
              )
        },
        home: const AuthChecker(),
      ),
    );
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
        .checkWebAccountAccess(user?.uid, context)) {
      print('Usuário logado: ${user?.uid}');
      navigateTo('/home', context);
    } else {
      FirebaseAuth.instance.signOut();
      print(user?.uid == null
          ? 'Nenhum usuário logado: ${user?.uid}'
          : 'Sem permissão para entrada desse usuário: ${user?.uid}');
      navigateTo('/login', context);
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

    final Map<String, bool Function()> routes = {
      //LOGADO
      '/home': () => redirectIfAuthenticated && isAuthenticated(user),
      '/register': () => redirectIfAuthenticated && isAuthenticated(user),
      '/settings': () => redirectIfAuthenticated && isAuthenticated(user),
      '/users': () => redirectIfAuthenticated && isAuthenticated(user),

      //Não LOGADO
      '/login': () => !redirectIfAuthenticated && !isAuthenticated(user),
    };

    for (final entry in routes.entries) {
      if (entry.value()) {
        navigateTo(entry.key, context);
        return buildLoadingScreen();
      }
    }

    return child;
  }
}

class NoTransitionPageTransitionsBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }
}
