import 'cidade.dart';

class Cliente {
  int id;
  String nome;
  String sexo;
  int idade;
  Cidade cidade;

  Cliente(this.id, this.nome, this.sexo, this.idade, this.cidade);

  factory Cliente.fromJson(dynamic json) {
    return Cliente(
        json["id"] as int,
        json["nome"] as String,
        json["sexo"] as String,
        json["idade"] as int,
        Cidade.fromJson(json["cidade"]));
  }

  Map<String, dynamic> toJson() => {
        if (id != 0) 'id': id,
        'nome': nome,
        'sexo': sexo,
        'idade': idade,
        'cidade': cidade.toJson()
      };
}
