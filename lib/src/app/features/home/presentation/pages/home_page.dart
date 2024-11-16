import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:planning_poker_ifood/src/routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseAuth = GetIt.I.get<FirebaseAuth>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Planning Poker iFood'),
        actions: [
          IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                firebaseAuth.signOut();
                router.go('/login');
              })
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Bem-vindo ao Planning Poker iFood'),
          ],
        ),
      ),
    );
  }
}
