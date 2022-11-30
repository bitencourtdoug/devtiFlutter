import 'package:apifinal/api/acesso_api.dart';
import 'package:apifinal/model/cidade.dart';
import 'package:apifinal/util/componentes.dart';
import 'package:flutter/material.dart';

class CadastroCid extends StatefulWidget {
  const CadastroCid({super.key});

  @override
  State<CadastroCid> createState() => _CadastroCidState();
}

class _CadastroCidState extends State<CadastroCid> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  TextEditingController txtNome = TextEditingController();
  TextEditingController txtUf = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Cidade;
    txtNome.text = args.nome;
    txtUf.text = args.uf;

    cadastrar() async {
      Cidade c = Cidade(args.id, txtNome.text, txtUf.text);
      Navigator.of(context).pushReplacementNamed('/consultaCid');

      if (c.id == 0) {
        await AcessoApi().inserirCidade(c.toJson());
      } else {
        await AcessoApi().alteraCidade(c.toJson());
      }
    }

    home() {
      Navigator.of(context).pushReplacementNamed('/home');
    }

    sair() {
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
                title: const Text('Consulta registros'),
                subtitle: const Text('Cidades'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacementNamed('/consultaCid');
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
            Componentes().criaInputTexto(
                TextInputType.text, "Nome", txtNome, "Informe o nome"),
            Componentes().criaInputTexto(TextInputType.text, "UF", txtUf,
                "Informe a Unidade federativa"),
            Componentes().criaBotao(formController, cadastrar, "cadastrar"),
          ],
        ),
      ),
    );
  }
}
