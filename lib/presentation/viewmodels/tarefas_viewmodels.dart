import 'package:tarefas/data/models/tarefas_model.dart';
import '../../data/repositories/tarefas_repository.dart';

class TarefaViewModel {
  final TarefasRepository repository;

  TarefaViewModel(this.repository);

  // Adicionar uma nova tarefa
  Future<void> addTarefa(Tarefa tarefa) async {
    await repository.insertTarefa(tarefa);
  }

  // Buscar todas as tarefas
  Future<List<Tarefa>> getTarefas() async {
    return await repository.getTarefa();
  }

  // Atualizar uma tarefa existente
  Future<void> updateTarefa(Tarefa tarefa) async {
    await repository.updateTarefa(tarefa);
  }

  // Deletar uma tarefa pelo ID
  Future<void> deleteTarefa(int? id) async {
    if (id != null) {
      await repository.deleteTarefa(id);
    }
  }
}


// Explicação
// Construtor (TaskViewModel):

// Recebe uma instância de TaskRepository, que será usada para manipular os dados.
// addTask(Task task):

// Adiciona uma nova tarefa ao banco de dados, utilizando o método insertTask do repositório.
// getTasks():

// Busca todas as tarefas disponíveis no banco de dados por meio de getTasks no repositório.
// updateTask(Task task):

// Atualiza uma tarefa existente com base no ID da tarefa fornecida.
// deleteTask(int? id):

// Remove uma tarefa do banco de dados pelo ID fornecido, garantindo que o ID não seja nulo antes de tentar deletar.