import 'package:calculadoraimc/model/imc_model.dart';

class IMCServices {
  IMCModel imc = IMCModel();

  IMCServices(this.imc);

  String? categoria() {
    if (imc.imc < 18.5) {
      return "Magreza";
    } else if (imc.imc >= 18.5 && imc.imc < 24.9) {
      return "Normal";
    } else if (imc.imc >= 25 && imc.imc < 29.9) {
      return "Sobrepeso";
    } else if (imc.imc >= 30 && imc.imc < 34.9) {
      return "Obesidade Grau I";
    } else if (imc.imc >= 35 && imc.imc < 39.9) {
      return "Obesidade Grau II";
    } else if (imc.imc >= 40) {
      return "Obesidade Grau III";
    }
    return null;
  }
}
