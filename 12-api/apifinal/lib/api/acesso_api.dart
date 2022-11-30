import 'dart:convert';
import 'package:apifinal/model/cliente.dart';
import 'package:http/http.dart';
import '../model/cidade.dart';

class AcessoApi {
  Future<List<Cliente>> listaClientes() async {
    String url = 'http://localhost:8080/cliente';
    Response resposta = await get(Uri.parse(url));
    String jsonFormatadUft8 = (utf8.decode(resposta.bodyBytes));
    Iterable l = json.decode(jsonFormatadUft8);
    List<Cliente> clientes =
        List<Cliente>.from(l.map((p) => Cliente.fromJson(p)));
    return clientes;
  }

  Future<List<Cidade>> listaCidades() async {
    String url = 'http://localhost:8080/cidade';
    Response resposta = await get(Uri.parse(url));
    String jsonFormatadUft8 = (utf8.decode(resposta.bodyBytes));
    Iterable l = json.decode(jsonFormatadUft8);
    List<Cidade> cidades = List<Cidade>.from(l.map((c) => Cidade.fromJson(c)));
    return cidades;
  }

  Future<void> insereCliente(Map<String, dynamic> cliente) async {
    String url = 'http://localhost:8080/cliente';
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8'
    };
    await post(Uri.parse(url), headers: headers, body: json.encode(cliente));
  }

  Future<void> inserirCidade(Map<String, dynamic> cidade) async {
    String url = 'http://localhost:8080/cidade';
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8'
    };
    await post(Uri.parse(url), headers: headers, body: json.encode(cidade));
  }

  Future<void> alteraCidade(Map<String, dynamic> cidade) async {
    String url = 'http://localhost:8080/cidade';
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8'
    };
    await put(Uri.parse(url), headers: headers, body: json.encode(cidade));
  }

  Future<void> excluiCidade(int id) async {
    String url = "http://localhost:8080/cidade/$id";
    await delete(Uri.parse(url));
  }

  Future<void> alteraCliente(Map<String, dynamic> cliente) async {
    String url = "http://localhost:8080/cliente";
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8'
    };
    await put(Uri.parse(url), headers: headers, body: json.encode(cliente));
  }

  Future<void> excluiCliente(int id) async {
    String url = "http://localhost:8080/cliente/$id";
    await delete(Uri.parse(url));
  }

  Future<List<Cidade>> buscarPorUf(String uf) async {
    String url = 'http://localhost:8080/cidade/buscauf/$uf';
    Response resposta = await get(Uri.parse(url));
    String jsonFormatadUft8 = (utf8.decode(resposta.bodyBytes));
    Iterable l = json.decode(jsonFormatadUft8);
    List<Cidade> cidades = List<Cidade>.from(l.map((c) => Cidade.fromJson(c)));
    return cidades;
  }

  Future<List<Cliente>> buscaCidade(String cidade) async {
    String url = 'http://localhost:8080/cliente/buscanome/$cidade';
    Response resposta = await get(Uri.parse(url));
    String jsonFormatadUft8 = (utf8.decode(resposta.bodyBytes));
    Iterable l = json.decode(jsonFormatadUft8);
    List<Cliente> clientes =
        List<Cliente>.from(l.map((p) => Cliente.fromJson(p)));
    return clientes;
  }
}
