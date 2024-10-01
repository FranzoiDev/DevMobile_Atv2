import 'package:flutter_test/flutter_test.dart';
import 'package:atv_3/main.dart';


void main() {
  group('ContaBancaria', () {
    test('Deve depositar o valor corretamente', () {
      var conta = ContaBancaria<int>(12345, 1000.0);
      conta.depositar(200.0);
      expect(conta.saldo, 1200.0);
    });

    test('Deve lançar exceção ao tentar depositar valor negativo', () {
      var conta = ContaBancaria<int>(12345, 1000.0);
      expect(() => conta.depositar(-50.0), throwsA(isA<Exception>()));
    });

    test('Deve sacar o valor corretamente', () {
      var conta = ContaBancaria<int>(12345, 1000.0);
      conta.sacar(200.0);
      expect(conta.saldo, 800.0);
    });

    test('Deve lançar exceção ao tentar sacar mais do que o saldo', () {
      var conta = ContaBancaria<int>(12345, 1000.0);
      expect(() => conta.sacar(2000.0), throwsA(predicate((e) => 
          e is Exception && e.toString() == 'Exception: Saldo insuficiente. Saldo atual: 1000.0')));
    });

    test('Deve lançar exceção ao tentar sacar valor negativo', () {
      var conta = ContaBancaria<int>(12345, 1000.0);
      expect(() => conta.sacar(-100.0), throwsA(predicate((e) => 
          e is Exception && e.toString() == 'Exception: O valor do saque deve ser positivo')));
    });

    test('Deve manter o saldo inalterado após falha no saque', () {
      var conta = ContaBancaria<int>(12345, 1000.0);
      try {
        conta.sacar(2000.0);
      } catch (_) {
        // Ignorando a exceção
      }
      expect(conta.saldo, 1000.0);
    });
  });
}
