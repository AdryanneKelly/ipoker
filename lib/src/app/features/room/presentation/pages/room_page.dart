import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:planning_poker_ifood/src/app/features/room/data/models/room_model.dart';
import 'package:planning_poker_ifood/src/app/features/room/presentation/bloc/room_bloc.dart';
import 'package:planning_poker_ifood/src/core/DI/dependence_injector.dart';
import 'package:planning_poker_ifood/src/core/features/user/data/models/user_model.dart';
import 'package:planning_poker_ifood/src/core/utils/loading_start.dart';
import 'package:planning_poker_ifood/src/routes.dart';

class RoomPage extends StatefulWidget {
  const RoomPage({super.key});

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  TextEditingController roomNameController = TextEditingController();
  TextEditingController roomCodeController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final firebaseAuth = GetIt.I.get<FirebaseAuth>();
    final size = MediaQuery.sizeOf(context);
    final roomBloc = GetIt.I.get<RoomBloc>();
    return LoadingStart(
      onInit: () {
        roomBloc.add(GetRoomEvent(userId: firebaseAuth.currentUser!.uid));
      },
      child: Scaffold(
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
                            child: Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  Text('Criar sala',
                                      style: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 40),
                                  TextFormField(
                                    controller: roomNameController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Nome da sala é obrigatório';
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                      labelText: 'Nome da sala',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  BlocConsumer<RoomBloc, RoomState>(
                                    listener: (context, state) {
                                      if (state is RoomCreated) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Sala ${state.room.title} criada com sucesso!'),
                                          ),
                                        );
                                        roomBloc.add(GetRoomEvent(userId: firebaseAuth.currentUser!.uid));
                                        Navigator.pop(context);
                                      }

                                      if (state is RoomError) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(state.message),
                                          ),
                                        );
                                      }
                                    },
                                    builder: (context, state) {
                                      if (state is RoomLoading) {
                                        return const CircularProgressIndicator();
                                      }
                                      return ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          minimumSize: Size(size.width, 50),
                                        ),
                                        onPressed: () {
                                          if (formKey.currentState!.validate()) {
                                            roomBloc.add(
                                              CreateRoomEvent(
                                                collection: 'rooms',
                                                data: {
                                                  'title': roomNameController.text.trim(),
                                                  'moderator': {
                                                    'name': firebaseAuth.currentUser!.displayName,
                                                    'email': firebaseAuth.currentUser!.email,
                                                    'uid': firebaseAuth.currentUser!.uid,
                                                  },
                                                  'status': 'open',
                                                },
                                              ),
                                            );
                                            //router.go('/room/create-room');
                                          }
                                        },
                                        child: Text('Criar sala',
                                            style: GoogleFonts.nunito(
                                                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                                      );
                                    },
                                  ),
                                ],
                              ),
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
                                    controller: roomCodeController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Código da sala é obrigatório';
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                        labelText: 'Código da sala', border: OutlineInputBorder()),
                                  ),
                                  const SizedBox(height: 20),
                                  BlocConsumer<RoomBloc, RoomState>(
                                    listener: (context, state) {
                                      if (state is RoomJoined) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Você entrou na sala ${state.room.title}'),
                                          ),
                                        );
                                        router.pop();
                                        router.go('/room/join-room', extra: state.room);
                                      }

                                      if (state is RoomError) {
                                        router.pop();
                                        roomBloc.add(GetRoomEvent(userId: firebaseAuth.currentUser!.uid));
                                        log(state.message);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text("Sala não encontrada"),
                                          ),
                                        );
                                      }
                                    },
                                    builder: (context, state) {
                                      if (state is RoomLoading) {
                                        return const CircularProgressIndicator();
                                      }
                                      return ElevatedButton(
                                        onPressed: () async {
                                          /// TODO: Refatorar
                                          final rooms = firebaseFirestore.collection('rooms');

                                          final snapshot = await rooms.doc(roomCodeController.text.trim()).get();
                                          final data = snapshot.data();
                                          data!['uid'] = snapshot.id;

                                          final room = RoomModel.fromMap(data);

                                          final participants = room.participants;

                                          final user = UserModel.fromMap({
                                            'name': firebaseAuth.currentUser!.displayName,
                                            'email': firebaseAuth.currentUser!.email,
                                            'uid': firebaseAuth.currentUser!.uid,
                                          });

                                          if (participants?.contains(user) ?? false) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                content: Text("Você já está na sala"),
                                              ),
                                            );
                                            router.go('/room/join-room', extra: room);
                                            return;
                                          } else {
                                            roomBloc.add(JoinRoomEvent(
                                              collection: 'rooms',
                                              roomId: roomCodeController.text.trim(),
                                              user: user,
                                            ));
                                          }
                                        },
                                        child: Text(
                                          'Entrar na sala',
                                          style: GoogleFonts.nunito(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      );
                                    },
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
                child: BlocConsumer<RoomBloc, RoomState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    if (state is GetRoomLoaded) {
                      if (state.rooms.isEmpty) {
                        return const Center(
                          child: Text('Você ainda não possui salas'),
                        );
                      }
                      return ListView.builder(
                        itemCount: state.rooms.length,
                        itemBuilder: (context, index) {
                          final room = state.rooms[index];
                          return Card(
                            color: Colors.red[50],
                            child: ListTile(
                              leading: const Icon(
                                Icons.meeting_room,
                                color: Colors.red,
                                size: 30,
                              ),
                              title: Text(room.title),
                              subtitle: Text('Código: ${room.uid}'),
                              trailing: IconButton(
                                icon: const Icon(Icons.arrow_forward_ios),
                                onPressed: () {
                                  router.go('/room/join-room', extra: room);
                                },
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
