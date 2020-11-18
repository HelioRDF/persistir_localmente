import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model/Pessoa.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _controleNome = TextEditingController();
  TextEditingController _controleSexo = TextEditingController();
  TextEditingController _controleIdade = TextEditingController();
  String _info = "Nenhuma info salva";
  String _retorno = "...";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Persistir Localmente"),
          backgroundColor: Colors.teal,
        ),
        body: SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        children: [
                          TextField(
                            controller: _controleNome,
                            decoration: InputDecoration(labelText: "Nome"),
                          ),
                          TextField(
                            controller: _controleSexo,
                            decoration: InputDecoration(labelText: "Sexo"),
                          ),
                          TextField(
                            controller: _controleIdade,
                            decoration: InputDecoration(labelText: "Idade"),
                          ),
                        ],
                      )),
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(
                          child: Text("Salvar"),
                          color: Colors.deepOrange,
                          textColor: Colors.white,
                          onPressed: () => {_salvar()},
                        ),
                        RaisedButton(
                          child: Text("Recuperar"),
                          color: Colors.deepOrange,
                          textColor: Colors.white,
                          onPressed: () => {_recuperar()},
                        ),
                        RaisedButton(
                          child: Text("Remover"),
                          color: Colors.deepOrange,
                          textColor: Colors.white,
                          onPressed: () => {_remover()},
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Text(_info),
                      Text(_retorno),
                    ],
                  )
                ],
              ),
            ),
        )
    );
  }

  _salvar() async {
    Pessoa pessoa = Pessoa(
        _controleNome.text, _controleSexo.text, int.parse(_controleIdade.text));
    final _preferencias = await SharedPreferences.getInstance();
    _preferencias.setString("nome", pessoa.nome);
    _preferencias.setString("sexo", pessoa.sexo);
    _preferencias.setString("idade", pessoa.idade.toString());
    setState(() =>
    {
      _controleNome.text = "",
      _controleIdade.text = "",
      _controleSexo.text = "",
      _info = pessoa.nome
    });
  }

  _recuperar() async {
    final _preferencias = await SharedPreferences.getInstance();
    String nome = _preferencias.getString("nome") ?? "Sem valor";
    String sexo = _preferencias.getString("sexo") ?? "Sem valor";
    String idade = _preferencias.getString("idade") ?? "0";
    Pessoa pessoa = Pessoa(nome, sexo, int.parse(idade));
    setState(() {
      _retorno =
          pessoa.nome + " - " + pessoa.sexo + " - " + pessoa.idade.toString();
    });
  }

  _remover() async {
    final _preferencias = await SharedPreferences.getInstance();
    _preferencias.remove("nome");
    _preferencias.remove("sexo");
    _preferencias.remove("idade");
  }
}