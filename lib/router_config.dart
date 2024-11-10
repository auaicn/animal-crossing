import 'package:animal_crossing/features/home/screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/home',
      builder: (context, state) => const Screen$Home(),
    ),
  ],
);
