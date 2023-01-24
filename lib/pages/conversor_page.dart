import 'package:conversor_de_moedas/api.dart';
import 'package:flutter/material.dart';

class ConversorPage extends StatefulWidget {
  const ConversorPage({super.key});

  @override
  State<ConversorPage> createState() => _ConversorPageState();
}

class _ConversorPageState extends State<ConversorPage> {
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
                return const Center(
                  child: Text(
                    'Funcionou',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.amber,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              }
          }
        }),
      ),
    );
  }
}
