import 'package:apifinal/api/acesso_api.dart';
import 'package:apifinal/model/cidade.dart';
import 'package:apifinal/util/componentes.dart';
import 'package:flutter/material.dart';
import '../model/cliente.dart';

class Consulta extends StatefulWidget {
  const Consulta({super.key});

  @override
  State<Consulta> createState() => _ConsultaState();
}

class _ConsultaState extends State<Consulta> {
  TextEditingController txtBusca = TextEditingController();
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  Cliente p = Cliente(0, "", "M", 0, Cidade(0, "", ""));
  List<Cliente> lista = [];

  listarTodas() async {
    List<Cliente> clientes = await AcessoApi().listaClientes();
    setState(() {
      lista = clientes;
    });
  }

  buscarTodos() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Filtrar Cliente'),
        content: Componentes()
            .criaInputTexto(TextInputType.text, 'Cidade', txtBusca, ''),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () async {
              List<Cliente> clientes =
                  await AcessoApi().buscaCidade(txtBusca.text);
              Navigator.of(context).pop();
              setState(() {
                lista = clientes;
              });
            },
          ),
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () async => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  // buscaCidade() async {
  //   List<Cliente> clientes = await AcessoApi().buscaCidade(txtBusca.text);
  //   setState(() {
  //     lista = clientes;
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   listarTodas();
  // }

  irTelaCadastro() async {
    Navigator.of(context).pushReplacementNamed('/cadastro', arguments: [
      p.id.toString(),
      p.nome.toString(),
      p.sexo.toString(),
      p.idade.toString(),
      p.cidade.id.toString(),
      p.cidade.nome.toString(),
      p.cidade.uf.toString()
    ]);
  }

  @override
  Widget build(BuildContext context) {
    home() {
      Navigator.of(context).pushReplacementNamed('/home');
    }

    sair() async {
      Navigator.of(context).pushReplacementNamed('/');
    }

    return Scaffold(
      drawer: Drawer(
        child: Center(
          child: Column(
            children: [
              Container(
                  width: 100,
                  height: 100,
                  child: const CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 10,
                    backgroundImage: AssetImage('assets/imgs/a.jpg'),
                  )),
              ListTile(
                leading: const Icon(Icons.keyboard_double_arrow_right_rounded,
                    color: Colors.black),
                title: const Text('Realize seu cadastro'),
                subtitle: const Text('Pessoa'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacementNamed(irTelaCadastro());
                },
              ),
              ListTile(
                leading: const Icon(Icons.keyboard_double_arrow_right_rounded,
                    color: Colors.black),
                title: const Text('Filtrar Cliente por Cidade'),
                subtitle: const Text('Pessoas'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacementNamed(buscarTodos());
                },
              ),
            ],
          ),
        ),
      ),
      appBar: Componentes().criaAppBar("Utilização API", home, sair),
      body: Form(
        key: formController,
        child: Column(
          children: [
            Componentes()
                .criaBotao(formController, listarTodas, "Listar Pessoas"),
            Expanded(
              child: ListView.builder(
                itemCount: lista.length,
                itemBuilder: (context, indice) {
                  return Card(
                    elevation: 6,
                    margin: const EdgeInsets.all(5),
                    child: criaItemCliente(lista[indice], context),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  criaItemCliente(Cliente p, context) {
    String sexo = p.sexo == 'M' ? "Masculino" : "Feminino";
    return ListTile(
      title: Text("${p.id} - ${p.nome} - ${p.idade} anos - ${sexo}"),
      subtitle: Text("${p.cidade.nome}/${p.cidade.uf}"),
      trailing: FittedBox(
        fit: BoxFit.fill,
        child: Row(
          children: [
            IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(
                    "/cadastro",
                    arguments: [
                      p.id.toString(),
                      p.nome.toString(),
                      p.sexo.toString(),
                      p.idade.toString(),
                      p.cidade.id.toString(),
                      p.cidade.nome.toString(),
                      p.cidade.uf.toString()
                    ],
                  );
                }),
            IconButton(
              icon: const Icon(Icons.delete),
              color: Colors.red,
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Excluir Cliente'),
                    content: const Text('Você tem certeza?'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Não'),
                        onPressed: () async => Navigator.of(context).pop(),
                      ),
                      TextButton(
                        child: const Text('Sim'),
                        onPressed: () async {
                          await AcessoApi().excluiCliente(p.id);
                          Navigator.of(context).pop();
                          setState(() {
                            listarTodas();
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
