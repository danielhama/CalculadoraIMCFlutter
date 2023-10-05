import 'dart:ffi';

import 'package:flutter/material.dart';

class IMCModel {
  final _id = UniqueKey().toString();
  DateTime _data = DateTime.now();
  double _altura = 0.0;
  double _peso = 0.0;
  double _imc = 0.0;

  IMCModel(this._altura, this._peso);

  String get id => _id;

  double get altura => _altura;

  double get peso => _peso;

  double get imc => _imc;

  DateTime get data => _data;

  void setimc(double imc) {
    _imc = imc;
  }

  void calculaImc() {
    if (_altura != 0 && _peso != 0) {
      setimc(_peso / (_altura * _altura));
    }
  }
}
