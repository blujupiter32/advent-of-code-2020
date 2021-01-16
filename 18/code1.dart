import "dart:convert";
import "dart:io";

int evaluate(String expr) {
  final symbols = expr.replaceAll(" ", "").split("");
  return _evaluate(symbols);
}

int _evaluate(List<String> symbols) {
  final start = symbols.lastIndexOf("(");
  if (start == -1) return _evaluateFlat(symbols);
  final end = symbols.indexOf(")", start);
  final value = _evaluate(symbols.sublist(start + 1, end));
  return _evaluate([
    ...symbols.sublist(0, start),
    value.toString(),
    ...symbols.sublist(end + 1)
  ]);
}

int _evaluateFlat(List<String> symbols) => symbols.length > 3
    ? _evaluateFlat(
        [_evaluateSingle(symbols).toString(), ...symbols.sublist(3)])
    : _evaluateSingle(symbols);

int _evaluateSingle(List<String> symbols) {
  final a = int.parse(symbols[0]);
  final op = symbols[1];
  final b = int.parse(symbols[2]);
  return op == "+" ? a + b : a * b;
}

void main() async {
  final input = utf8.decoder
      .bind(File("input.txt").openRead())
      .transform(const LineSplitter());
  final result = await input.map(evaluate).fold(0, (a, b) => a + b);
  print(result);
}
