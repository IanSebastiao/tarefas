import 'package:flutter/material.dart';
import 'package:tarefas/data/models/tarefas_model.dart';
import 'package:tarefas/data/repositories/tarefas_repository.dart';
import 'package:tarefas/presentation/viewmodels/tarefas_viewmodels.dart';
import 'package:tarefas/presentation/pages/tarefas/tarefas_pages.dart';

class EditarTarefasPage extends StatefulWidget {
  final Tarefa tarefa; // Recebe a tarefa para edição

  const EditarTarefasPage({super.key, required this.tarefa});

  @override
  State<EditarTarefasPage> createState() => _EditarTarefasPageState();
}

class _EditarTarefasPageState extends State<EditarTarefasPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nomeController;
  late TextEditingController descricaoController;
  late TextEditingController statusController;
  late TextEditingController dataInicioController;
  late TextEditingController dataFimController;
  final TarefaViewModel _viewModel = TarefaViewModel(TarefasRepository());

  @override
  void initState() {
    super.initState();
    // Inicializa os controladores com os dados da tarefa
    nomeController = TextEditingController(text: widget.tarefa.nome);
    descricaoController = TextEditingController(text: widget.tarefa.descricao);
    statusController = TextEditingController(text: widget.tarefa.status);
    dataInicioController = TextEditingController(text: widget.tarefa.dataInicio);
    dataFimController = TextEditingController(text: widget.tarefa.dataFim);
  }

  Future<void> editarTarefa() async {
    if (_formKey.currentState!.validate()) {
      final tarefaAtualizada = Tarefa(
        id: widget.tarefa.id, // Mantém o id da tarefa original
        nome: nomeController.text,
        descricao: descricaoController.text,
        status: statusController.text,
        dataInicio: dataInicioController.text,
        dataFim: dataFimController.text,
      );

      await _viewModel.updateTarefa(tarefaAtualizada); // Atualiza a tarefa

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tarefa Atualizada com sucesso!')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => TarefasPages()),
        );
      }
    }
  }

  Future<void> _selectDate(TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        controller.text = "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Tarefa'),
        backgroundColor: const Color.fromARGB(255, 0, 65, 150),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Text(
                        'Editar Tarefa',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 65, 150),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: nomeController,
                        decoration: const InputDecoration(
                          labelText: 'Nome',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor entre com um nome';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: descricaoController,
                        decoration: const InputDecoration(
                          labelText: 'Descrição',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: statusController.text.isEmpty
                            ? null
                            : statusController.text,
                        onChanged: (String? newValue) {
                          setState(() {
                            statusController.text = newValue!;
                          });
                        },
                        items: <String>[
                          'Pendente',
                          'Em andamento',
                          'Concluído'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: const InputDecoration(
                          labelText: 'Status',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor selecione o status';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: dataInicioController,
                        readOnly: true,
                        decoration: const InputDecoration(
                          labelText: 'Data de Início',
                          border: OutlineInputBorder(),
                        ),
                        onTap: () => _selectDate(dataInicioController),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor selecione a data de início';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: dataFimController,
                        readOnly: true,
                        decoration: const InputDecoration(
                          labelText: 'Data de Fim',
                          border: OutlineInputBorder(),
                        ),
                        onTap: () => _selectDate(dataFimController),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor selecione a data de fim';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton.icon(
                        onPressed: editarTarefa,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 0, 65, 150),
                          padding: const EdgeInsets.symmetric(
                            vertical: 15.0,
                            horizontal: 30.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          foregroundColor: Colors.black,
                        ),
                        icon: const Icon(Icons.save, size: 24, color: Colors.black),
                        label: const Text(
                          'Salvar Alterações',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
