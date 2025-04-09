import 'package:anotacoes/anotacao_database.dart';
import 'package:flutter/material.dart';

class AnotacaoPage extends StatefulWidget {
  const AnotacaoPage({super.key});

  @override
  State<AnotacaoPage> createState() => _AnotacaoPageState();
}

class _AnotacaoPageState extends State<AnotacaoPage> {
  // Carregar o banco de dados
  final anotacaoDatabase = AnotacaoDataBase();

  // Controller para o texto digitado
  final anotacaoController = TextEditingController();

  // Função para adicionar uma nova anotação
  void addNovaAnotacao() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Nova Anotação"),
              content: TextField(
                controller: anotacaoController,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    anotacaoController.clear();
                  },
                  child: const Text("Cancelar"),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anotações'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNovaAnotacao,
        child: const Icon(Icons.add),
      ),
    );
  }
}
