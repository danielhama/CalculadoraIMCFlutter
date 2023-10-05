import 'package:calculadoraimc/model/imc_model.dart';

class ImcRepository {
  final List<IMCModel> _imcs = [];

  Future<List<IMCModel>> listarImc() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _imcs;
  }

  void adicionarImc(IMCModel imc) async{
    await Future.delayed(const Duration(milliseconds: 100));
    _imcs.add(imc);
  }

  void removerImc(IMCModel imc) async{
    await Future.delayed(const Duration(milliseconds: 100));
    _imcs.remove(imc);
  }
}
