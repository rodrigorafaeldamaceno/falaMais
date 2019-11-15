import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';

class ResultBloc implements BlocBase {
  final _resController = StreamController<double>();

  Stream<double> get outRes => _resController.stream;
  Sink get inRes => _resController.sink;

  void calcRes(double origem, double destino, int tempo, int plano) {
    // print(origem);
    double priceMin;
    if (origem == 11) {
      if (destino == 16) priceMin = 1.90;
      if (destino == 17) priceMin = 1.70;
      if (destino == 18) priceMin = 0.90;
    }
    if (origem == 16 && destino == 11) priceMin = 2.90;
    if (origem == 17 && destino == 11) priceMin = 2.70;
    if (origem == 18 && destino == 11) priceMin = 1.90;

    double juros = 0;
    int dif = 0;
    if (tempo > plano) {
      dif = tempo - plano;
      juros = dif * priceMin * 1.1;
    }
    double result = (tempo - dif) * priceMin + juros;
    inRes.add(result);
  }

  @override
  void addListener(listener) {
    // TODO: implement addListener
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _resController.close();
  }

  @override
  // TODO: implement hasListeners
  bool get hasListeners => null;

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
  }

  @override
  void removeListener(listener) {
    // TODO: implement removeListener
  }
}
