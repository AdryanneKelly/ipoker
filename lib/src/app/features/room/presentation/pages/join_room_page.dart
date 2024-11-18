import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JoinRoomPage extends StatelessWidget {
  const JoinRoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Sprint 12345',
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
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: SizedBox(
                      width: size.width * 0.7,
                      child: Text(
                        'Tarefa tal pra fazer isso e aquilo e mais aquilo outro e mais um pouco disso e daquilo ',
                        style: GoogleFonts.nunito(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add, color: Colors.red),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.plus_one_rounded, color: Colors.red),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.skip_next, color: Colors.red),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            SizedBox(
              height: size.height * 0.4,
              width: size.width,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10, mainAxisExtent: 150),
                itemCount: 9,
                itemBuilder: (context, index) {
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
                          Text('Fulano $index'),
                          const SizedBox(height: 10),
                          Container(
                            width: 50,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.red.shade100,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Center(
                              child: Text(
                                '10',
                                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () {}, child: const Text('Finalizar votação')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  height: size.height * 0.3,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Text('Votar'),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('0'),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('1'),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('2'),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('3'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('5'),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('8'),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('13'),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('21'),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              });
        },
        label: const Text('Votar'),
        icon: const Icon(Icons.check),
      ),
    );
  }
}
