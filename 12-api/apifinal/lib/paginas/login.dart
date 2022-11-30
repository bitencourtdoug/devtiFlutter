import 'package:apifinal/util/componentes.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    fazLogin() {
      if (txtEmail.text == 'douglas' && txtSenha.text == '1988') {
        // Navigator.of(context).pushReplacementNamed('/home');
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Bem Vindo ${txtEmail.text}'),
            content: const Text('Deseja Fazer login?'),
            actions: <Widget>[
              TextButton(
                child: const Text('No'),
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Yes'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacementNamed('/home');
                },
              ),
            ],
          ),
        );
        print('SIM ${txtEmail.text} - ${txtSenha.text}');
      } else {
        print('NÂO ${txtEmail.text} - ${txtSenha.text}');
      }
    }

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 200,
                height: 200,
                child: const CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 70,
                  backgroundImage: AssetImage('assets/imgs/a.jpg'),
                )),
            Container(height: 30),
            Componentes().criaTextoField(
                'Email', false, TextInputType.emailAddress, txtEmail),
            Componentes()
                .criaTextoField('Senha', true, TextInputType.none, txtSenha),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Componentes()
                  .criaBotao2('Entrar', fazLogin, 50, double.infinity),
            ),
          ],
        ),
      ),
    );
  }
}
