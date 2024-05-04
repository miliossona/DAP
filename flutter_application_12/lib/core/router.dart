
import 'package:flutter_application_12/screens/home.dart';
import 'package:flutter_application_12/screens/login.dart';
import 'package:go_router/go_router.dart';


final appRouter = GoRouter(routes: [
  GoRoute(
    name: LoginView.name,
    path: '/',
    builder: (context, state) =>  LoginView(),
  ),
  GoRoute(
    name: RegisterView.name,
    path: '/home',
    builder: (context, state) => RegisterView(userName: state.extra as String),
  ),
]);