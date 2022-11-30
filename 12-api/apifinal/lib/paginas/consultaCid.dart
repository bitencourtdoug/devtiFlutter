import 'package:apifinal/api/acesso_api.dart';
import 'package:apifinal/model/cidade.dart';
import 'package:apifinal/util/componentes.dart';
import 'package:flutter/material.dart';

class ConsultaCid extends StatefulWidget {
  const ConsultaCid({super.key});

  @override
  State<ConsultaCid> createState() => _ConsultaCidState();
}

class _ConsultaCidState extends State<ConsultaCid> {
  TextEditingController txtBusca = TextEditingController();
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  List<Cidade> lista = [];

  listarTodas() async {
    List<Cidade> cidades = await AcessoApi().listaCidades();
    setState(() {
      lista = cidades;
    });
  }

  buscar() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Filtrar por UF'),
        content: Componentes()
            .criaInputTexto(TextInputType.text, 'Filtrar', txtBusca, ''),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () async {
              List<Cidade> cidades =
                  await AcessoApi().buscarPorUf(txtBusca.text);
              Navigator.of(context).pop();
              setState(() {
                lista = cidades;
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

  buscarUf() async {
    List<Cidade> cidades = await AcessoApi().buscarPorUf(txtBusca.text);
    setState(() {
      lista = cidades;
    });
  }

  irTelaCadCidade() async {
    Navigator.of(context).pushReplacementNamed(
      "/cadCidade",
      arguments: Cidade(0, "", ""),
    );
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
                subtitle: const Text('Cidade'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacementNamed(irTelaCadCidade());
                },
              ),
              ListTile(
                leading: const Icon(Icons.keyboard_double_arrow_right_rounded,
                    color: Colors.black),
                title: const Text('Filtrar Cidade por UF'),
                subtitle: const Text('Cidade'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacementNamed(buscar());
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
                .criaBotao(formController, listarTodas, "Listar Cidades"),
            Expanded(
              child: ListView.builder(
                itemCount: lista.length,
                itemBuilder: (context, indice) {
                  return Card(
                    elevation: 6,
                    margin: const EdgeInsets.all(5),
                    child: criaItemCidade(lista[indice], context),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  criaItemCidade(Cidade c, context) {
    return ListTile(
      title: Text("${c.id} - ${c.nome} - ${c.uf}"),
      trailing: FittedBox(
        fit: BoxFit.fill,
        child: Row(
          children: [
            IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(
                    "/cadCidade",
                    arguments: c,
                  );
                }),
            IconButton(
                icon: const Icon(Icons.delete),
                color: Colors.red,
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Excluir Cidade'),
                      content: const Text('Você tem certeza?'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Não'),
                          onPressed: () async => Navigator.of(context).pop(),
                        ),
                        TextButton(
                          child: const Text('Sim'),
                          onPressed: () async {
                            await AcessoApi().excluiCidade(c.id);
                            Navigator.of(context).pop();
                            setState(() {
                              listarTodas();
                            });
                          },
                        ),
                      ],
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
