import 'package:apifinal/paginas/cadCidade.dart';
import 'package:apifinal/paginas/cadastro.dart';
import 'package:apifinal/paginas/consulta.dart';
import 'package:apifinal/paginas/consultaCid.dart';
import 'package:apifinal/paginas/home.dart';
import 'package:apifinal/paginas/login.dart';
import 'package:apifinal/util/tema.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Tema().criaTema(),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/home': (context) => const Home(),
        '/consulta': (context) => const Consulta(),
        '/cadastro': (context) => const Cadastro(),
        '/consultaCid': (context) => const ConsultaCid(),
        '/cadCidade': (context) => const CadastroCid(),
      },
    );
  }
}
