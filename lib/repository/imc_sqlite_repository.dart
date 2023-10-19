import 'package:calculadoraimc/model/imc_model.dart';
import 'package:calculadoraimc/repository/sqlite_repository.dart';

class IMCSQLiteRepository {
  Future<List<IMCModel>> obterDados() async {
    List<IMCModel> imcs = [];
    var db = await SQLiteDataBase().obterDataBase();
    var result = await db.rawQuery("SELECT id, altura, peso, data FROM imcs");
    for (var element in result) {
      IMCModel novo = IMCModel();
      novo.fromMap(element);
      //IMCModel(element["altura"] as double,
      //element["peso"] as double, element["data"] as String?);
      // novo.setId(element["id"] as int);
      imcs.add(novo);
    }
    return imcs;
  }

  Future<void> salvar(IMCModel IMCSQLiteModel) async {
    var db = await SQLiteDataBase().obterDataBase();
    await db.rawInsert(
        'INSERT INTO imcs (altura, peso, imc, data) values(?,?,?,?)', [
      IMCSQLiteModel.altura,
      IMCSQLiteModel.peso,
      IMCSQLiteModel.imc,
      IMCSQLiteModel.data.toString()
    ]);
  }

  // Future<void> atualizar(IMCModel tarefaSQLiteModel) async {
  //   var db = await SQLiteDataBase().obterDataBase();
  //   await db.rawInsert(
  //       'UPDATE tarefas SET descricao = ?, concluido = ? WHERE id = ?', [
  //     tarefaSQLiteModel.descricao,
  //     tarefaSQLiteModel.concluido ? 1 : 0,
  //     tarefaSQLiteModel.id
  //   ]);
  // }

  Future<void> remover(int id) async {
    var db = await SQLiteDataBase().obterDataBase();
    await db.rawInsert('DELETE FROM tarefas WHERE id = ?', [id]);
  }
}
