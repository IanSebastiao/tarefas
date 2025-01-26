import 'package:flutter/material.dart';
import 'package:tarefas/presentation/pages/tarefas/criar_tarefas_page.dart';
import 'package:tarefas/presentation/pages/tarefas/tarefas_pages.dart';
import 'main_home_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Lista de páginas, com HomePage como inicial
  final List<Widget> _pages = [
    const MainHomePage(),
    const TarefasPages(),
    const CriarTarefasPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciamento de Tarefas'),
        backgroundColor: Color.fromARGB(255, 0, 65, 150),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 0, 65, 150),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('images/tarefas.png'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Bem-vindo!',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
                color: Color.fromARGB(255, 0, 65, 150),
              ),
              title: const Text('Home'),
              onTap: () {
                _onItemTapped(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.task,
                color: Color.fromARGB(255, 0, 65, 150),
              ),
              title: const Text('Acessar Tarefas'),
              onTap: () {
                _onItemTapped(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.task_alt,
                color: Color.fromARGB(255, 0, 65, 150),
              ),
              title: const Text('Criar Tarefas'),
              onTap: () {
                _onItemTapped(2);
                Navigator.pop(context);
              },
            ),
            // const Divider(),
            // ListTile(
            //   leading: const Icon(Icons.exit_to_app, color: Colors.red),
            //   title: const Text('Sair'),
            //   onTap: () {
            //     Navigator.pushReplacement(
            //       context,
            //       MaterialPageRoute(builder: (context) => const LoginPage()),
            //     );
            //   },
            // ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task),
            label: 'Acessar Tarefas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task_alt),
            label: 'Criar Tarefas',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 0, 65, 150),
        onTap: _onItemTapped,
      ),
    );
  }
}
