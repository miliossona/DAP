import 'package:myapp/presentation/screens/edit_screen.dart';
import 'package:myapp/presentation/screens/home_screen.dart';
import 'package:myapp/presentation/screens/login_screen.dart';
import 'package:myapp/presentation/screens/card_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
  GoRoute(
    path: '/login',
    builder: ((context, state) => const LoginScreen())
  ),
  GoRoute(
    path: '/home',
    builder: ((context, state) => const HomeScreen())
  ),
  GoRoute(
      path: '/card',
      builder: ((context, state) => const CardScreen()),
    ),
    GoRoute(
      path: '/edit',
      builder: ((context, state) => const EditScreen()),
    ),
  ],
);
