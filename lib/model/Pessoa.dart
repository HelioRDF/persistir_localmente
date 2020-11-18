class Pessoa {
  String _nome;
  String _sexo;
  int _idade;

  Pessoa(this._nome, this._sexo, this._idade);

  int get idade => _idade;

  set idade(int value) {
    _idade = value;
  }

  String get sexo => _sexo;

  set sexo(String value) {
    _sexo = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }
}
