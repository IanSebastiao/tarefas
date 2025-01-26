import 'package:flutter/material.dart';
import 'package:tarefas/presentation/pages/tarefas/criar_tarefas_page.dart';
import 'package:tarefas/presentation/pages/tarefas/tarefas_pages.dart';

class MainHomePage extends StatelessWidget {
  const MainHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Bem-vindo ao App de Tarefas!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Text(
              'Gerencie suas tarefas de forma fácil e rápida.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.grey.shade700),
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            icon: const Icon(
              Icons.task,
              color: Colors.black,
            ),
            label: const Text('Acessar Tarefas'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 0, 65, 150),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              foregroundColor:
                  Colors.black, // Definindo a cor do texto como preto
              textStyle: const TextStyle(fontSize: 18),
            ),
            onPressed: () {
              // Navegar para TarefasPages
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TarefasPages()),
              );
            },
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            icon: const Icon(
              Icons.task_alt_outlined,
              color: Colors.black, // Definindo a cor do ícone como preto
            ),
            label: const Text('Criar Tarefas'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 0, 65, 150),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              foregroundColor:
                  Colors.black, // Definindo a cor do texto como preto
              textStyle: const TextStyle(fontSize: 18),
            ),
            onPressed: () {
              // Navegar para CriarTarefasPage
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CriarTarefasPage()),
              );
            },
          )
        ],
      ),
    );
  }
}
