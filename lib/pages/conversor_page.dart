import 'package:conversor_de_moedas/api.dart';
import 'package:flutter/material.dart';

class ConversorPage extends StatefulWidget {
  const ConversorPage({super.key});

  @override
  State<ConversorPage> createState() => _ConversorPageState();
}

class _ConversorPageState extends State<ConversorPage> {
  final TextEditingController realController = TextEditingController();
  final TextEditingController dolarController = TextEditingController();
  final TextEditingController euroController = TextEditingController();

  double euro = 0;
  double dolar = 0;

  void realChanged(String text) {
    if (text != '') {
      double real = double.parse(text);
      dolarController.text = (real / dolar).toStringAsFixed(2);
      euroController.text = (real / euro).toStringAsFixed(2);
    } else {
      dolarController.clear();
      euroController.clear();
    }
  }

  void dolarChanged(String text) {
    if (text != '') {
      double dolar = double.parse(text);
      realController.text = (dolar * this.dolar).toStringAsFixed(2);
      euroController.text = (dolar * this.dolar / euro).toStringAsFixed(2);
    } else {
      realController.clear();
      euroController.clear();
    }
  }

  void euroChanged(String text) {
    if (text != '') {
      double euro = double.parse(text);
      realController.text = (euro * this.euro).toStringAsFixed(2);
      dolarController.text = (euro * this.euro / euro).toStringAsFixed(2);
    } else {
      realController.clear();
      dolarController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('\$ Conversor de Moedas \$'),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: FutureBuilder<Map>(
        future: API().getData(),
        builder: ((context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.amber,
                ),
              );
            default:
              if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    'Erro ao carregar os dados :D',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.amber,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                dolar = snapshot.data?['results']['currencies']['USD']['buy'];
                euro = snapshot.data?['results']['currencies']['EUR']['buy'];

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const Icon(
                        Icons.monetization_on,
                        color: Colors.amber,
                        size: 128,
                      ),
                      const Divider(),
                      buildTextField(
                          'Reais', 'R\$', realController, realChanged),
                      const Divider(),
                      buildTextField(
                          'Dólares', 'USD\$', dolarController, dolarChanged),
                      const Divider(),
                      buildTextField('Euros', '€', euroController, euroChanged),
                    ],
                  ),
                );
              }
          }
        }),
      ),
    );
  }
}

Widget buildTextField(
  String label,
  String prefix,
  TextEditingController controller,
  Function function,
) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.amber),
      prefixText: prefix,
    ),
    style: const TextStyle(
      color: Colors.amber,
    ),
    onChanged: (value) => function(value),
    keyboardType: TextInputType.number,
  );
}
