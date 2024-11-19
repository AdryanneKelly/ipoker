import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:planning_poker_ifood/src/app/features/room/domain/entities/room_entity.dart';
import 'package:planning_poker_ifood/src/app/features/room/presentation/bloc/room_bloc.dart';
import 'package:planning_poker_ifood/src/core/DI/dependence_injector.dart';
import 'package:planning_poker_ifood/src/core/features/task/data/models/task_model.dart';
import 'package:planning_poker_ifood/src/core/features/task/presentation/bloc/task_bloc.dart';
import 'package:planning_poker_ifood/src/core/features/user/data/models/user_model.dart';
import 'package:planning_poker_ifood/src/core/utils/loading_start.dart';
import 'package:planning_poker_ifood/src/routes.dart';

class JoinRoomPage extends StatefulWidget {
  const JoinRoomPage({super.key, required this.room});

  final RoomEntity room;

  @override
  State<JoinRoomPage> createState() => _JoinRoomPageState();
}

class _JoinRoomPageState extends State<JoinRoomPage> {
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();
  TextEditingController taskStoryPointController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  PageController pageController = PageController();
  TaskModel? currentTask;
  int vote = 0;
  List<UserModel> participants = [];
  List<int> fibonacci(int n) {
    List<int> sequence = [0, 1];
    for (int i = 2; i < n; i++) {
      sequence.add(sequence[i - 1] + sequence[i - 2]);
    }
    return sequence;
  }

  @override
  Widget build(BuildContext context) {
    final taskBloc = GetIt.I<TaskBloc>();
    final roomBloc = GetIt.I<RoomBloc>();
    final size = MediaQuery.sizeOf(context);
    final user = firebaseAuth.currentUser;
    final isModerator = user?.uid == widget.room.moderator.id;
    log('key room: ${widget.room.uid}');
    //final tasks = firebaseFirestore.collection('tasks').where('roomId', isEqualTo: widget.room.uid).snapshots();
    //vEO0rLrRlpIAjtf7PKJF
    return LoadingStart(
      onInit: () {
        taskBloc.add(GetTasks(roomId: widget.room.uid, collection: 'tasks'));
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Sala: ${widget.room.title}',
              style: GoogleFonts.nunito(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
          backgroundColor: Colors.red,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.personal_injury_sharp, color: Colors.red, size: 40),
                  BlocConsumer<TaskBloc, TaskState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is TaskError) {
                        return Center(child: Text(state.message));
                      }
                      if (state is TaskLoaded) {
                        final tasks = state.tasks;
                        return SizedBox(
                          height: size.height * 0.1,
                          width: size.width * 0.7,
                          child: PageView.builder(
                            controller: pageController,
                            itemCount: tasks.length,
                            scrollDirection: Axis.horizontal,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (ctx, index) {
                              final task = tasks[index];

                              firebaseFirestore.collection('rooms').doc(widget.room.uid).update({
                                'currentTask': (task as TaskModel).toMap(),
                              });

                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: SizedBox(
                                    width: size.width * 0.7,
                                    child: Column(
                                      children: [
                                        Text(
                                          'Task: ${task.title}',
                                          style: GoogleFonts.nunito(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          task.description,
                                          style: GoogleFonts.nunito(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ],
              ),
              if (isModerator)
                Padding(
                  padding: const EdgeInsets.only(right: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Form(
                                    key: formKey,
                                    child: Column(
                                      children: [
                                        Text(
                                          'Adicionar tarefa',
                                          style: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 20),
                                        TextFormField(
                                          controller: taskTitleController,
                                          decoration: const InputDecoration(
                                            labelText: 'Título',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        TextFormField(
                                          controller: taskDescriptionController,
                                          decoration: const InputDecoration(
                                            labelText: 'Descrição',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        BlocConsumer<TaskBloc, TaskState>(
                                          listener: (context, state) {
                                            if (state is TaskCreated) {
                                              taskTitleController.clear();
                                              taskDescriptionController.clear();
                                              taskBloc.add(GetTasks(roomId: widget.room.uid, collection: 'tasks'));
                                              Navigator.pop(context);
                                            }
                                            if (state is TaskError) {
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                content: Text(state.message),
                                                backgroundColor: Colors.red,
                                              ));
                                            }
                                          },
                                          builder: (context, state) {
                                            if (state is TaskLoading) {
                                              return const Center(child: CircularProgressIndicator());
                                            }
                                            return ElevatedButton(
                                              onPressed: () {
                                                if (formKey.currentState!.validate()) {
                                                  taskBloc.add(
                                                    CreateTask(
                                                      collection: 'tasks',
                                                      task: TaskModel(
                                                        title: taskTitleController.text,
                                                        description: taskDescriptionController.text,
                                                        roomId: widget.room.uid,
                                                      ),
                                                    ),
                                                  );
                                                }
                                              },
                                              child: const Text('Adicionar'),
                                            );
                                          },
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        SizedBox(
                                            height: size.height * 0.20,
                                            child: StreamBuilder<QuerySnapshot>(
                                              stream: firebaseFirestore
                                                  .collection('tasks')
                                                  .where('roomId', isEqualTo: widget.room.uid)
                                                  .snapshots(),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState == ConnectionState.waiting) {
                                                  return const Center(child: CircularProgressIndicator());
                                                }

                                                if (snapshot.hasError) {
                                                  return Center(child: Text('Erro: ${snapshot.error}'));
                                                }

                                                // Verifique se o snapshot possui dados
                                                if (!snapshot.hasData || snapshot.data == null) {
                                                  return const Center(child: Text('Sem dados.'));
                                                }

                                                // Obtenha os dados do documento
                                                final tasksData = snapshot.data!.docs.map((doc) {
                                                  final data = doc.data() as Map<String, dynamic>;
                                                  data['uid'] = doc.id;
                                                  return TaskModel.fromMap(data);
                                                }).toList();

                                                // Verifique se os participantes estão disponíveis
                                                if (tasksData.isEmpty) {
                                                  return const Center(child: Text('Nenhuma tarefa encontrada.'));
                                                }

                                                // Mapeie os participantes para objetos UserModel
                                                final tasks = tasksData.map((task) {
                                                  return TaskModel.fromMap(task.toMap());
                                                }).toList();

                                                return ListView.builder(
                                                  itemCount: tasks.length,
                                                  itemBuilder: (context, index) {
                                                    final task = tasks[index];
                                                    return ListTile(
                                                      title: Text(task.title),
                                                      subtitle: Text(task.description),
                                                    );
                                                  },
                                                );
                                              },
                                            )),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        icon: const Icon(Icons.add, color: Colors.red),
                      ),
                      IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    const Text('Votar na tarefa'),
                                    const SizedBox(height: 10),
                                    TextFormField(
                                      controller: taskStoryPointController,
                                      decoration: const InputDecoration(
                                        labelText: 'Story point',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        /// TODO : Refatorar para usar o bloc
                                        final snapshot =
                                            await firebaseFirestore.collection('rooms').doc(widget.room.uid).get();

                                        if (taskStoryPointController.text.isNotEmpty) {
                                          firebaseFirestore
                                              .collection('tasks')
                                              .doc(snapshot.data()!['currentTask']['uid'])
                                              .update({
                                            'storyPoint': taskStoryPointController.text,
                                          });

                                          firebaseFirestore.collection('rooms').doc(widget.room.uid).update({
                                            'participants': participants.map((participant) {
                                              return participant.copyWith(point: null).toMap();
                                            }).toList(),
                                          });

                                          taskStoryPointController.clear();
                                          Navigator.pop(context);
                                          pageController.nextPage(
                                            duration: const Duration(milliseconds: 500),
                                            curve: Curves.easeInOut,
                                          );
                                        }
                                      },
                                      child: const Text('Votar'),
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.plus_one_rounded, color: Colors.red),
                      ),
                      IconButton(
                        onPressed: () {
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        },
                        icon: const Icon(Icons.skip_next, color: Colors.red),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 50),
              SizedBox(
                height: size.height * 0.4,
                width: size.width,
                child: StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance.collection('rooms').doc(widget.room.uid).snapshots(),
                  builder: (context, snapshot) {
                    /// TODO: Refatorar para usar o bloc
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text('An error occurred: ${snapshot.error}'));
                    }

                    if (!snapshot.hasData || snapshot.data == null) {
                      return const Center(child: Text('No data found.'));
                    }

                    final roomData = snapshot.data?.data() as Map<String, dynamic>?;
                    if (roomData == null) {
                      return const Center(child: Text('Room data not available.'));
                    }

                    final participantsData = roomData['participants'] as List<dynamic>?;
                    if (participantsData == null || participantsData.isEmpty) {
                      return const Center(child: Text('No participants available.'));
                    }

                    final participants = participantsData.map((participant) {
                      return UserModel.fromMap(participant as Map<String, dynamic>);
                    }).toList();

                    this.participants = participants;

                    log('participants: $participants');

                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        mainAxisExtent: 170,
                      ),
                      itemCount: participants.length,
                      itemBuilder: (context, index) {
                        final participant = participants[index];
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(
                                  'https://cdn-icons-png.flaticon.com/512/49/49733.png',
                                  color: Colors.red,
                                  width: 50,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  participant.name,
                                  style: GoogleFonts.nunito(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  width: 50,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: Colors.red.shade100,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(
                                    child: Text(
                                      participant.point == null ? '?' : participant.point.toString(),
                                      style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              if (isModerator)
                BlocConsumer<RoomBloc, RoomState>(
                  listener: (context, state) {
                    if (state is RoomUpdated) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Votação finalizada com sucesso!'),
                        backgroundColor: Colors.green,
                      ));
                      router.go('/room');
                      roomBloc.add(GetRoomEvent(userId: user!.uid));
                    }
                  },
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () {
                        final updatedParticipants = participants.map((participant) {
                          return participant.copyWith(point: null).toMap();
                        }).toList();
                        roomBloc.add(UpdateRoomEvent(
                          collection: 'rooms',
                          data: {
                            'participants': updatedParticipants,
                            'currentTask': null,
                            'status': 'finished',
                            'title': widget.room.title,
                            'moderator': (widget.room.moderator as UserModel).toMap(),
                          },
                          documentId: widget.room.uid,
                        ));
                      },
                      child: const Text('Finalizar votação'),
                    );
                  },
                ),
            ],
          ),
        ),
        floatingActionButton: isModerator
            ? null
            : FloatingActionButton.extended(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      useRootNavigator: true,
                      builder: (context) {
                        return Container(
                          height: size.height * 0.3,
                          width: size.width,
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              const Text('Votar'),
                              const SizedBox(height: 20),
                              Expanded(
                                child: GridView.count(
                                  crossAxisCount: 6,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 12,
                                  children: fibonacci(12).map((value) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          vote = value;
                                        });

                                        /// TODO: Refatorar para usar o bloc
                                        firebaseFirestore.collection('rooms').doc(widget.room.uid).update({
                                          'participants': participants.map((participant) {
                                            if (participant.id == user!.uid) {
                                              participant = participant.copyWith(point: value);
                                            }
                                            return participant.toMap();
                                          }).toList(),
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.red.shade200,
                                        ),
                                        child: Center(
                                            child: Text(
                                          value.toString(),
                                          style: GoogleFonts.nunito(color: Colors.white),
                                        )),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              )
                            ],
                          ),
                        );
                      });
                },
                label: const Text('Votar'),
                icon: const Icon(Icons.check),
              ),
      ),
    );
  }
}
