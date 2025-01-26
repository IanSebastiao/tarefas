import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tarefas/data/models/tarefas_model.dart';
import 'package:tarefas/data/repositories/tarefas_repository.dart';
import 'package:tarefas/presentation/pages/home_page.dart';
import 'package:tarefas/presentation/pages/tarefas/criar_tarefas_page.dart';
import 'package:tarefas/presentation/pages/tarefas/editar_tarefas_page.dart';
import 'package:tarefas/presentation/viewmodels/tarefas_viewmodels.dart';

class TarefasPages extends StatefulWidget {
  const TarefasPages({super.key});

  @override
  State<TarefasPages> createState() => _TarefasPagesState();
}

class _TarefasPagesState extends State<TarefasPages> {
  List<Tarefa> _tarefa = [];
  final TarefaViewModel _viewModel = TarefaViewModel(TarefasRepository());
  Tarefa? _lastDeletedTarefa;

  @override
  void initState() {
    super.initState();
    _loadTarefa();
  }

  Future<void> _loadTarefa() async {
    _tarefa = await _viewModel.getTarefas();
    _updateTarefaStatus();
    if (mounted) {
      setState(() {});
    }
  }

  void _updateTarefaStatus() {
    final now = DateTime.now();
    for (var tarefa in _tarefa) {
      final dataInicio = DateTime.parse(tarefa.dataInicio);
      final dataFim = DateTime.parse(tarefa.dataFim);

      if (dataInicio.isAfter(now)) {
        tarefa.status = 'Pendente';
      } else if (dataInicio.isAtSameMomentAs(now) || (dataInicio.isBefore(now) && dataFim.isAfter(now))) {
        tarefa.status = 'Em andamento';
      } else if (dataFim.isBefore(now)) {
        tarefa.status = 'Concluído';
      }
    }
  }

  Future<void> _deleteTarefa(Tarefa tarefa) async {
    await _viewModel.deleteTarefa(tarefa.id);
    _lastDeletedTarefa = tarefa;

    final snackBar = SnackBar(
      content: Text('${tarefa.nome} deletado'),
      action: SnackBarAction(
        label: 'Desfazer',
        onPressed: () {
          if (_lastDeletedTarefa != null && mounted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Desfeta a exclusão de ${_lastDeletedTarefa!.nome}'),
            ));
            _viewModel.addTarefa(_lastDeletedTarefa!);
            setState(() {
              _tarefa.add(_lastDeletedTarefa!);
              _lastDeletedTarefa = null;
            });
          }
        },
      ),
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    await _loadTarefa();
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'pendente':
        return Colors.red;
      case 'em andamento':
        return Colors.orange;
      case 'concluído':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  // Função para formatar a data
  String formatDate(String date) {
    try {
      final parsedDate = DateTime.parse(date);
      return DateFormat('dd/MM/yyyy').format(parsedDate); // Formato brasileiro
    } catch (e) {
      return date; // Retorna a data original caso haja erro de formatação
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tarefas'),
        backgroundColor: const Color.fromARGB(255, 0, 65, 150),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_sharp),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _tarefa.isEmpty
            ? const Center(child: Text('Nenhuma Tarefa Disponvel.'))
            : ListView.builder(
                itemCount: _tarefa.length,
                itemBuilder: (context, index) {
                  final tarefa = _tarefa[index];
                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: const Color.fromARGB(255, 0, 65, 150),
                        child: Text(
                          tarefa.nome[0],
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(
                        tarefa.nome,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Descrição: ${tarefa.descricao}'),
                          const SizedBox(height: 4),
                          Text(
                            'Data Início: ${formatDate(tarefa.dataInicio)}', // Usando o formato brasileiro
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Data Fim: ${formatDate(tarefa.dataFim)}', // Usando o formato brasileiro
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Status: ${tarefa.status}',
                            style: TextStyle(
                              color: _getStatusColor(tarefa.status),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.orange),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditarTarefasPage(tarefa: tarefa),
                                ),
                              ).then((_) => _loadTarefa());
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              _deleteTarefa(tarefa);
                            },
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CriarTarefasPage()),
          ).then((_) => _loadTarefa());
        },
        backgroundColor: const Color.fromARGB(255, 0, 65, 150),
        tooltip: 'Adicionar tarefa',
        child: const Icon(Icons.add, size: 30),
      ),
    );
  }
}
