import 'package:flutter/material.dart';
import 'package:anotacoes/anotacao.dart';
import 'package:anotacoes/anotacao_database.dart';

class AnotacaoPage extends StatefulWidget {
  const AnotacaoPage({super.key});

  @override
  State<AnotacaoPage> createState() => _AnotacaoPageState();
}

class _AnotacaoPageState extends State<AnotacaoPage> {
  final anotacaoDatabase = AnotacaoDataBase();
  final anotacaoController = TextEditingController();

  void addNovaAnotacao() {
    anotacaoController.clear();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 20,
          right: 20,
          top: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Nova Anotação",
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            TextField(
              controller: anotacaoController,
              maxLines: null,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: "Digite sua anotação aqui...",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  final nova =
                      Anotacao(conteudo: anotacaoController.text.trim());
                  anotacaoDatabase.criarAnotacao(nova);
                  Navigator.pop(context);
                },
                child: const Text("Salvar"),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void editarAnotacao(Anotacao anotacao) {
    anotacaoController.text = anotacao.conteudo;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Editar Anotação"),
        content: TextField(
          controller: anotacaoController,
          maxLines: null,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar")),
          FilledButton(
            onPressed: () {
              anotacaoDatabase.atualizarAnotacoes(
                  anotacao, anotacaoController.text);
              Navigator.pop(context);
            },
            child: const Text("Atualizar"),
          ),
        ],
      ),
    );
  }

  void confirmarExclusao(Anotacao anotacao) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Excluir Anotação"),
        content: const Text("Tem certeza que deseja excluir esta anotação?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          FilledButton(
            onPressed: () {
              anotacaoDatabase.deletarAnotacoes(anotacao);
              Navigator.pop(context);
            },
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("Excluir"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Minhas Anotações"),
        centerTitle: true, 
        elevation: 1,
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNovaAnotacao,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<Anotacao>>(
        stream: anotacaoDatabase.stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Erro ao carregar anotações."));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Nenhuma anotação por enquanto."));
          }

          final anotacoes = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: anotacoes.length,
            itemBuilder: (context, index) {
              final anotacao = anotacoes[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                elevation: 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            anotacao.conteudo,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(width: 160,),
                          IconButton(
                            onPressed: () => editarAnotacao(anotacao),
                            icon: const Icon(Icons.edit_outlined),
                            tooltip: "Editar",
                          ),
                          IconButton(
                            onPressed: () => confirmarExclusao(anotacao),
                            icon: const Icon(Icons.delete_outline),
                            tooltip: "Excluir",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
