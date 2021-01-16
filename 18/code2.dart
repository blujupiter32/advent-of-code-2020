import "dart:convert";
import "dart:io";

int evaluate(String expr) {
  final symbols = expr.replaceAll(" ", "").split("");
  return _evaluate(symbols);
}

int _evaluate(List<String> symbols) {
  final start = symbols.lastIndexOf("(");
  if (start == -1) {
    final plus = symbols.indexOf("+");
    final mult = symbols.indexOf("*");
    if (mult == -1 || plus == -1) return _evaluateFlat(symbols);
    symbols.insert(mult, ")");
    symbols.insert(mult + 2, "(");
    symbols.insert(0, "(");
    symbols.add(")");
    return _evaluate(symbols);
  }
  final end = symbols.indexOf(")", start);
  final value = _evaluate(symbols.sublist(start + 1, end));
  return _evaluate([
    ...symbols.sublist(0, start),
    value.toString(),
    ...symbols.sublist(end + 1)
  ]);
}

int _evaluateFlat(List<String> symbols) {
  switch (symbols.length) {
    case 1:
      return int.parse(symbols[0]);
    case 3:
      return _evaluateSingle(symbols);
    default:
      return _evaluateFlat(
          [_evaluateSingle(symbols).toString(), ...symbols.sublist(3)]);
  }
}

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
