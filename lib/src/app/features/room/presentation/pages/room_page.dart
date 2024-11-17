import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:planning_poker_ifood/src/routes.dart';

class RoomPage extends StatelessWidget {
  const RoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseAuth = GetIt.I.get<FirebaseAuth>();
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/logo_ipoker.png',
          width: 50,
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                firebaseAuth.signOut();
                router.go('/login');
              })
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to iPoker'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                router.go('/room/create-room');
              },
              child: const Text('Create Room'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                router.go('/join-room');
              },
              child: const Text('Join Room'),
            ),
          ],
        ),
      ),
    );
  }
}
