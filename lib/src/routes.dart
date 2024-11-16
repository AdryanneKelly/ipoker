import 'package:go_router/go_router.dart';
import 'package:planning_poker_ifood/src/app/features/auth/presentation/pages/login_page.dart';
import 'package:planning_poker_ifood/src/app/features/auth/presentation/pages/register_page.dart';
import 'package:planning_poker_ifood/src/app/features/home/presentation/pages/home_page.dart';
import 'package:planning_poker_ifood/src/core/features/splash/pages/splash_page.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    GoRoute(path: '/register', builder: (context, state) => const RegisterPage()),
    GoRoute(path: '/home', builder: (context, state) => const HomePage()),
  ],
);