class ContaBancaria<T> {
  T numeroConta;
  double _saldo;

  ContaBancaria(this.numeroConta, this._saldo);

  double get saldo => _saldo;

  void depositar(double valor) {
    if (valor <= 0) {
      throw Exception('O valor do depósito deve ser positivo');
    }
    _saldo += valor;
  }

  void sacar(double valor) {
    if (valor <= 0) {
      throw Exception('O valor do saque deve ser positivo');
    }
    if (valor > _saldo) {
      throw Exception('Saldo insuficiente. Saldo atual: $_saldo');
    }
    _saldo -= valor;
  }

  @override
  String toString() {
    return 'Conta: $numeroConta, Saldo: $_saldo';
  }
}

void main() {
  var contaCorrente = ContaBancaria<int>(12345, 1000.0);
  var contaPoupanca = ContaBancaria<String>('ABC123', 500.0);

  contaCorrente.depositar(200.0);
  contaPoupanca.sacar(100.0);

  print(contaCorrente);
  print(contaPoupanca);

  // Testando exceções
  try {
    contaCorrente.sacar(1500.0); // Deve lançar exceção de saldo insuficiente
  } catch (e) {
    print(e);
  }

  try {
    contaPoupanca.depositar(-50.0); // Deve lançar exceção de depósito inválido
  } catch (e) {
    print(e);
  }
}
