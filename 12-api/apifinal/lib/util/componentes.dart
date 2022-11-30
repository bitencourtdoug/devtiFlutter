import 'package:flutter/material.dart';

class Componentes {
  criaAppBar(texto, acao, sair) {
    return AppBar(
      title: criatexto(texto),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: acao,
        ),
        IconButton(
          icon: const Icon(Icons.logout_rounded),
          onPressed: sair,
        ),
      ],
    );
  }

  criamenu(texto, acao) {
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
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.keyboard_double_arrow_right_rounded,
                    color: Colors.black),
                title: const Text('Realize sua Consulta'),
                subtitle: const Text('Pessoas'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.keyboard_double_arrow_right_rounded,
                    color: Colors.black),
                title: const Text('Realize seu cadastro'),
                subtitle: const Text('Cidade'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.keyboard_double_arrow_right_rounded,
                    color: Colors.black),
                title: const Text('Realize sua Consulta'),
                subtitle: const Text('Cidade'),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  configuraFundo(imagem) {
    return BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/imgs/${imagem}'),
        fit: BoxFit.cover,
      ),
    );
  }

  criatexto(texto, [cor]) {
    if (cor != null) {
      return Text(
        texto,
        style: TextStyle(color: cor),
      );
    }
    return Text(texto);
  }

  iconGrande() {
    return const Icon(
      Icons.maps_home_work_outlined,
      size: 180.0,
    );
  }

  criaInputTexto(tipoTeclado, textoEtiqueta, controlador, msgValidacao) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: tipoTeclado,
        decoration: InputDecoration(
          labelText: textoEtiqueta,
          labelStyle: const TextStyle(
            fontSize: 20,
          ),
        ),
        textAlign: TextAlign.left,
        style: const TextStyle(fontSize: 30),
        controller: controlador,
        validator: (value) {
          if (value!.isEmpty) {
            return msgValidacao;
          }
        },
      ),
    );
  }

  criaBotao(controladorFormulario, funcao, titulo) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 5, 10),
            height: 100,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
              ),
              onPressed: () {
                if (controladorFormulario.currentState!.validate()) {
                  funcao();
                }
              },
              child: Text(
                titulo,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  criaBotao4(controladorFormulario, acao) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 5, 10),
              height: 75,
              child: IconButton(
                icon: const TextField(
                  decoration: InputDecoration(prefixIcon: Icon(Icons.search)),
                ),
                onPressed: () {
                  if (controladorFormulario.currentState!.validate()) {
                    acao();
                  }
                },
              ),
            ))
      ],
    );
  }

  criaContainerDados(rua, complemento, bairro, cidade, estado) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 250,
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 1, child: criatexto(rua, Colors.black)),
            Expanded(flex: 1, child: criatexto(complemento, Colors.black)),
            Expanded(flex: 1, child: criatexto(bairro, Colors.black)),
            Expanded(flex: 1, child: criatexto(cidade, Colors.black)),
            Expanded(flex: 1, child: criatexto(estado, Colors.black)),
          ],
        ),
      ),
    );
  }

  criaTexto2(conteudo, tamanho, cor) {
    return Text(
      conteudo,
      style: TextStyle(
        fontSize: tamanho,
        color: cor,
      ),
    );
  }

  criaBotao2(rotulo, funcao, altura, largura) {
    return SizedBox(
      height: altura,
      width: largura,
      child: ElevatedButton(
        onPressed: funcao,
        child: criaTexto2(rotulo, 20, Colors.white),
      ),
    );
  }

  criaTextoField(titulo, senha, tipoTeclado, controlador) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: controlador,
        keyboardType: tipoTeclado,
        obscureText: senha,
        decoration: InputDecoration(
          labelText: titulo,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
