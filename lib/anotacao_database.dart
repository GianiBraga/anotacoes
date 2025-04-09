import 'package:anotacoes/anotacao.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AnotacaoDataBase {
  // Banco de dados com a tabela anotações
  final database = Supabase.instance.client.from('anotacoes');

  // Criação de anotações no banco de dados
  Future criarAnotacao(Anotacao novaAnotacao) async {
    await database.insert(novaAnotacao.toMap());
  }

  // Listar as anotações no banco de dados
  final Stream<List<Anotacao>> stream = Supabase.instance.client
      .from('anotacoes')
      .stream(primaryKey: ['id']).map((data) =>
          data.map((anotacaoMap) => Anotacao.fromMap(anotacaoMap)).toList());

  // Atualizar as anotações no banco de dados
  Future atualizarAnotacoes(
      Anotacao antigaAnotacao, String novoConteudo) async {
    await database
        .update({'conteudo': novoConteudo}).eq('id', antigaAnotacao.id!);
  }

  // Deletar as anotações no banco de dados
  Future deletarAnotacoes(Anotacao anotacao) async {
    await database.delete().eq('id', anotacao.id!);
  }
}
