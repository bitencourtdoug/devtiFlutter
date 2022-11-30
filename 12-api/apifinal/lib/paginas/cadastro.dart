import 'package:apifinal/api/acesso_api.dart';
import 'package:apifinal/util/combo_cidade.dart';
import 'package:apifinal/util/componentes.dart';
import 'package:apifinal/util/radio_sexo.dart';
import 'package:flutter/material.dart';
import '../model/cidade.dart';
import '../model/cliente.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  TextEditingController txtNome = TextEditingController();
  TextEditingController txtSexo = TextEditingController();
  TextEditingController txtIdade = TextEditingController();
  TextEditingController txtCidade = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as List<String>;
    txtNome.text = args[1];
    txtSexo.text = args[2];
    txtIdade.text = args[3].toString();
    if (int.parse(txtIdade.text) == 0) {
      txtIdade.text = "";
    }
    txtCidade.text = args[4].toString();

    cadastrar() async {
      Cliente p = Cliente(int.parse(args[0]), txtNome.text, txtSexo.text,
          int.parse(txtIdade.text), Cidade(int.parse(txtCidade.text), "", ""));
      Navigator.of(context).pushReplacementNamed('/consulta');
      if (p.id == 0) {
        await AcessoApi().insereCliente(p.toJson());
      } else {
        await AcessoApi().alteraCliente(p.toJson());
      }
    }

    home() async {
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
                title: const Text('Consulta registros'),
                subtitle: const Text('Pessoas'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacementNamed('/consulta');
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
            Componentes().criaInputTexto(
                TextInputType.number, "Idade", txtIdade, "Informe a idade"),
            Center(child: RadioSexo(controller: txtSexo)),
            Center(child: ComboCidade(controller: txtCidade)),
            Componentes().criaBotao(formController, cadastrar, "Cadastrar"),
          ],
        ),
      ),
    );
  }
}
