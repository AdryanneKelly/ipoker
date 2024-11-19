import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planning_poker_ifood/src/app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:planning_poker_ifood/src/app/features/room/presentation/bloc/room_bloc.dart';
import 'package:planning_poker_ifood/src/core/DI/dependence_injector.dart';
import 'package:planning_poker_ifood/src/core/features/task/presentation/bloc/task_bloc.dart';
import 'package:planning_poker_ifood/src/core/themes/app_theme.dart';
import 'package:planning_poker_ifood/src/routes.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => injector<AuthBloc>(),
        ),
        BlocProvider(
          create: (context) => injector<RoomBloc>(),
        ),
        BlocProvider(
          create: (context) => injector<TaskBloc>(),
        ),
      ],
      child: MaterialApp.router(
        title: 'iPoker',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        routerConfig: router,
      ),
    );
  }
}
