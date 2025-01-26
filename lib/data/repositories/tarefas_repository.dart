import 'package:sqflite/sqflite.dart';
import 'package:tarefas/data/models/tarefas_model.dart';
import '../../core/database_helper.dart';

class TarefasRepository {
  // Inserir uma nova tarefa
  Future<void> insertTarefa(Tarefa tarefa) async {
    final db = await DatabaseHelper.initDb();
    await db.insert(
      'tarefas',
      tarefa.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Buscar todas as tarefas
  Future<List<Tarefa>> getTarefa() async {
    final db = await DatabaseHelper.initDb();
    final List<Map<String, Object?>> taskMaps = await db.query('tarefas');
    return taskMaps.map((map) {
      return Tarefa(
        id: map['id'] as int?,
        nome: map['nome'] as String,
        descricao: map['descricao'] as String?,
        status: map['status'] as String,
        dataInicio: map['data_inicio'] as String,
        dataFim: map['data_fim'] as String,
      );
    }).toList();
  }

  // Atualizar uma tarefa
  Future<void> updateTarefa(Tarefa tarefa) async {
    final db = await DatabaseHelper.initDb();
    await db.update(
      'tarefas',
      tarefa.toMap(),
      where: 'id = ?',
      whereArgs: [tarefa.id],
    );
  }

  // Deletar uma tarefa
  Future<void> deleteTarefa(int id) async {
    final db = await DatabaseHelper.initDb();
    await db.delete(
      'tarefas',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}


// Explicação
// insertTask(Tarefa tarefa):

// Insere uma nova tarefa na tabela tarefas.
// Usa ConflictAlgorithm.replace para substituir caso o ID já exista.
// getTasks():

// Retorna todas as tarefas como uma lista de objetos Task.
// Cada Map retornado pela consulta é convertido em uma instância de Task.
// updateTask(Task task):

// Atualiza uma tarefa existente com base no ID fornecido.
// deleteTask(int id):

// Remove uma tarefa do banco de dados com base no ID.