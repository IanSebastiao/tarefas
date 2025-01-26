import 'package:flutter/material.dart';
import 'package:tarefas/data/models/tarefas_model.dart';
import 'package:tarefas/data/repositories/tarefas_repository.dart';
import 'package:tarefas/presentation/viewmodels/tarefas_viewmodels.dart';
import 'package:tarefas/presentation/pages/tarefas/tarefas_pages.dart';

class CriarTarefasPage extends StatefulWidget {
  const CriarTarefasPage({super.key});

  @override
  State<CriarTarefasPage> createState() => _CriarTarefasPageState();
}

class _CriarTarefasPageState extends State<CriarTarefasPage> {
  final _formKey = GlobalKey<FormState>();
  final nomeController = TextEditingController();
  final descricaoController = TextEditingController();
  final dataInicioController = TextEditingController();
  final dataFimController = TextEditingController();
  final TarefaViewModel _viewModel = TarefaViewModel(TarefasRepository());

  Future<void> addTarefa() async {
    if (_formKey.currentState!.validate()) {
      final tarefa = Tarefa(
        nome: nomeController.text,
        descricao: descricaoController.text,
        dataInicio: dataInicioController.text,
        dataFim: dataFimController.text,
      );
      await _viewModel.addTarefa(tarefa);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tarefa adicionada com sucesso!')),
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
        title: const Text('Cadastro de Tarefas'),
        backgroundColor: const Color.fromARGB(255, 0, 65, 150),
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
                        'Cadastrar uma nova Tarefa',
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
                        onPressed: addTarefa,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 0, 65, 150),
                          padding: const EdgeInsets.symmetric(
                            vertical: 15.0,
                            horizontal: 30.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          foregroundColor: Colors.black, // Cor do ícone e texto
                        ),
                        icon: const Icon(
                          Icons.save,
                          size: 24,
                          color: Colors.black,
                        ),
                        label: const Text(
                          'Salvar',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
