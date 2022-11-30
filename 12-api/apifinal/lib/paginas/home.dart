import 'package:apifinal/model/cidade.dart';
import 'package:apifinal/model/cliente.dart';

import 'package:apifinal/util/componentes.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();

  Cliente p = Cliente(0, "", "M", 0, Cidade(0, "", ""));

  cadastro() {
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

  cadCidade() {
    Navigator.of(context).pushReplacementNamed(
      '/cadCidade',
      arguments: Cidade(0, "", ""),
    );
  }

  @override
  Widget build(BuildContext context) {
    home() {
      Navigator.of(context).pushReplacementNamed('/home');
    }

    sair() {
      Navigator.of(context).pushReplacementNamed('/');
    }

    consulta() {
      Navigator.of(context).pushReplacementNamed('/consulta');
    }

    consultaCid() {
      Navigator.of(context).pushReplacementNamed('/consultaCid');
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
                  Navigator.of(context).pushReplacementNamed(cadastro());
                },
              ),
              ListTile(
                leading: const Icon(Icons.keyboard_double_arrow_right_rounded,
                    color: Colors.black),
                title: const Text('Realize sua Consulta'),
                subtitle: const Text('Pessoas'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacementNamed('/consulta');
                },
              ),
              ListTile(
                leading: const Icon(Icons.keyboard_double_arrow_right_rounded,
                    color: Colors.black),
                title: const Text('Realize seu cadastro'),
                subtitle: const Text('Cidade'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacementNamed(cadCidade());
                },
              ),
              ListTile(
                leading: const Icon(Icons.keyboard_double_arrow_right_rounded,
                    color: Colors.black),
                title: const Text('Realize sua Consulta'),
                subtitle: const Text('Cidade'),
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          // decoration: Componentes().configuraFundo('naruto.jpg'),
          key: formController,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                padding: const EdgeInsets.all(50.0),
                icon: const Icon(Icons.person_add,
                    size: 100.0, color: Colors.white),
                onPressed: cadastro,
              ),
              IconButton(
                padding: const EdgeInsets.all(50.0),
                icon: const Icon(Icons.add_home,
                    size: 100.0, color: Colors.white),
                onPressed: cadCidade,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
