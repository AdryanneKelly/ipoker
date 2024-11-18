import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:planning_poker_ifood/src/routes.dart';

class RoomPage extends StatelessWidget {
  const RoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseAuth = GetIt.I.get<FirebaseAuth>();
    final size = MediaQuery.sizeOf(context);
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
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                'Olá, ${firebaseAuth.currentUser!.displayName}!',
                style: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Text('Criar sala', style: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 40),
                              TextFormField(
                                decoration:
                                    const InputDecoration(labelText: 'Nome da sala', border: OutlineInputBorder()),
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  minimumSize: Size(size.width, 50),
                                ),
                                onPressed: () {},
                                child: Text('Criar sala',
                                    style: GoogleFonts.nunito(
                                        fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                    // router.go('/room/create-room');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: size.width * 0.4,
                    height: size.height * 0.2,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/poker_game.png',
                          width: 80,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text('Criar sala'),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Text('Entrar em uma sala',
                                    style: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 40),
                                TextFormField(
                                  decoration:
                                      const InputDecoration(labelText: 'Código da sala', border: OutlineInputBorder()),
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    minimumSize: Size(size.width, 50),
                                  ),
                                  onPressed: () {
                                    router.go('/room/join-room');
                                  },
                                  child: Text('Entrar na sala',
                                      style: GoogleFonts.nunito(
                                          fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                                ),
                              ],
                            ),
                          );
                        });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: size.width * 0.4,
                    height: size.height * 0.2,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/meeting.png',
                          width: 100,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text('Entrar em uma sala'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Text('Suas salas', style: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.red[50],
                    child: ListTile(
                      leading: const Icon(
                        Icons.meeting_room,
                        color: Colors.red,
                        size: 30,
                      ),
                      title: Text('Sprint $index'),
                      subtitle: const Text('Código: 123456'),
                      trailing: IconButton(
                        icon: const Icon(Icons.arrow_forward_ios),
                        onPressed: () {},
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
