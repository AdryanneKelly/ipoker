import 'package:go_router/go_router.dart';
import 'package:planning_poker_ifood/src/app/features/auth/presentation/pages/login_page.dart';
import 'package:planning_poker_ifood/src/app/features/auth/presentation/pages/register_page.dart';
import 'package:planning_poker_ifood/src/app/features/room/domain/entities/room_entity.dart';
import 'package:planning_poker_ifood/src/app/features/room/presentation/pages/create_room_page.dart';
import 'package:planning_poker_ifood/src/app/features/room/presentation/pages/join_room_page.dart';
import 'package:planning_poker_ifood/src/app/features/room/presentation/pages/room_page.dart';
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
    GoRoute(
      path: '/room',
      builder: (context, state) => const RoomPage(),
      routes: [
        GoRoute(path: 'create-room', builder: (context, state) => const CreateRoomPage()),
        GoRoute(
            path: 'join-room',
            builder: (context, state) {
              final room = state.extra as RoomEntity;
              return JoinRoomPage(room: room);
            }),
      ],
    ),
  ],
);
