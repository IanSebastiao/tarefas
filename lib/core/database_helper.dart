import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Future<Database> initDb() async {
    return openDatabase(
      join(await getDatabasesPath(), 'tarefas.db'),
      onCreate: (db, version) async {
        // Criação da tabela tarefas
        await db.execute('CREATE TABLE tarefas ('
            'id INTEGER PRIMARY KEY, '
            'nome TEXT NOT NULL, '
            'descricao TEXT, '
            'status TEXT, '
            'data_inicio TEXT, '
            'data_fim TEXT'
            ');');
      },
      version: 1, // Versão inicial do banco
    );
  }
}

// Estrutura do código:
// Banco de Dados:
// Nome: tarefas.db.
// Versão inicial definida como 1.
// Tabela tarefas:
// id (chave primária, tipo INTEGER).
// nome (não nulo, tipo TEXT).
// descricao (opcional, tipo TEXT).
// status (opcional, tipo TEXT).
// data_inicio e data_fim (opcional, tipo TEXT para armazenar as datas).
