import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:planning_poker_ifood/src/app/features/room/presentation/bloc/room_bloc.dart';

class CreateRoomPage extends StatefulWidget {
  const CreateRoomPage({super.key});

  @override
  State<CreateRoomPage> createState() => _CreateRoomPageState();
}

class _CreateRoomPageState extends State<CreateRoomPage> {
  TextEditingController roomNameController = TextEditingController();
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();
  GlobalKey<FormState> formTaskKey = GlobalKey<FormState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> tasks = [];

  @override
  Widget build(BuildContext context) {
    final roomBloc = GetIt.I<RoomBloc>();
    final firebaseAuth = GetIt.I<FirebaseAuth>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Room'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Create Room'),
                const SizedBox(height: 20),
                TextFormField(
                  controller: roomNameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'O nome da sala é obrigatório';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Room Name',
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Tasks'),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(tasks[index]['title']),
                      subtitle: Text(tasks[index]['description']),
                    );
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Form(
                            key: formTaskKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: taskTitleController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'O título da tarefa é obrigatório';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'Title',
                                  ),
                                ),
                                TextFormField(
                                  controller: taskDescriptionController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'A descrição da tarefa é obrigatória';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'Descrição',
                                  ),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      if (formTaskKey.currentState!.validate()) {
                                        setState(() {
                                          tasks.add({
                                            'title': taskTitleController.text.trim(),
                                            'description': taskDescriptionController.text.trim(),
                                          });
                                        });
                                        taskTitleController.clear();
                                        taskDescriptionController.clear();
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: const Text('Add Task')),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: const Text('Add Task')),
                ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        roomBloc.add(CreateRoomEvent(
                          data: {
                            'title': roomNameController.text.trim(),
                            'moderator': firebaseAuth.currentUser!.uid,
                            'status': 'open',
                          },
                          collection: 'rooms',
                        ));

                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Create Room')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
