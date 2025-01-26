class Tarefa {
  int? id; // ID da tarefa (opcional, usado para identificar a tarefa no banco)
  String nome; // Nome da tarefa (obrigatório)
  String? descricao; // Descrição da tarefa (opcional)
  String? status; // Status da tarefa (opcional, ex.: "pendente", "concluído")
  String dataInicio; // Data de início da tarefa (opcional)
  String dataFim; // Data de término da tarefa (opcional)

  // Construtor
  Tarefa({
    this.id,
    required this.nome,
    this.descricao,
    this.status,
    required this.dataInicio,
    required this.dataFim,
  });

  // Converte um Map (do banco de dados) para um objeto Task
  factory Tarefa.fromMap(Map<String, dynamic> map) {
    return Tarefa(
      id: map['id'],
      nome: map['nome'],
      descricao: map['descricao'],
      status: map['status'],
      dataInicio: map['data_inicio'],
      dataFim: map['data_fim'],
    );
  }

  // Converte um objeto Task para um Map (usado para inserção/atualização no banco de dados)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'status': status,
      'data_inicio': dataInicio,
      'data_fim': dataFim,
    };
  }
}


// Explicação:
// Propriedades:

// id: É opcional porque só será preenchido após a tarefa ser inserida no banco.
// nome: Obrigatório, é o nome da tarefa.
// descricao, status, dataInicio, dataFim: São opcionais e podem ser usados para mais informações.
// Construtor:

// Permite criar um objeto Task com as informações da tarefa. O nome é obrigatório, enquanto os outros campos são opcionais.
// Métodos:

// fromMap: Converte um Map (obtido do banco de dados) em um objeto Task.
// toMap: Converte um objeto Task em um Map (usado para inserir ou atualizar no banco).