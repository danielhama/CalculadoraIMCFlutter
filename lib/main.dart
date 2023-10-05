import 'package:calculadoraimc/model/imc_model.dart';
import 'package:calculadoraimc/repository/imc_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      theme: ThemeData(
        primaryColor: const Color(0x35757575),
        primaryColorLight: const Color(0x35757575),
        primaryTextTheme: const TextTheme(
            titleLarge: TextStyle(color: Color.fromARGB(255, 237, 237, 243))),
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 19, 8, 100)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Calculadora IMC'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ImcRepository repository = ImcRepository();
  String imcText = "";
  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();
  var _listaIMC = const <IMCModel>[];

  String calcularIMC(double peso, double altura) {
    IMCModel imc = IMCModel(altura = altura, peso = peso);
    imc.calculaImc();
    repository.adicionarImc(imc);
    return imc.imc.toStringAsFixed(2);
  }

  @override
  void initState() {
    super.initState();
    obterimc();
  }

  String formataData(DateTime data) {
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    String formatted = formatter.format(data);
    return formatted;
  }

  void obterimc() async {
    _listaIMC = await repository.listarImc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: const Color(0x35757575),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          widget.title,
          style: const TextStyle(color: Color(0xFFDBE2E7)),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const Text(
            "IMC",
            style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 25,
                fontWeight: FontWeight.w700),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              style: const TextStyle(
                  color: Color.fromARGB(255, 0, 26, 93),
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
              imcText,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Informe seu Peso',
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
              TextField(
                textAlign: TextAlign.center,
                controller: _pesoController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Informe sua altura',
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
              TextField(
                textAlign: TextAlign.center,
                controller: _alturaController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 5, 60, 0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "IMC",
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Altura",
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Peso",
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Data",
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ]),
          ),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * .50 -
                MediaQuery.of(context).viewInsets.bottom,
            margin: EdgeInsets.all(16),
            child: ListView.builder(
              itemCount: _listaIMC.length,
              itemBuilder: (BuildContext context, int index) {
                var imc = _listaIMC[index];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(imc.imc.toStringAsFixed(2)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(imc.altura.toStringAsFixed(2)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(imc.peso.toStringAsFixed(2)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(formataData(imc.data)),
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          imcText = calcularIMC(double.parse(_pesoController.text),
              double.parse(_alturaController.text));
          setState(() {});
        },
        tooltip: 'Calcular',
        child: const Icon(Icons.calculate),
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
