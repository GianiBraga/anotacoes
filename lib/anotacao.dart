class Anotacao{
  int? id;
  String conteudo;

  Anotacao({
    this.id,
    required this.conteudo,
  });

  // Responsável por passar de Map para Anotações
  factory Anotacao.fromMap(Map<String, dynamic> map){
    return Anotacao(id: map['id'] as int, conteudo: ['conteudo'] as String,);
  }

  // Responsável por passar de Anotações para Map
  Map<String, dynamic> toMap(){
    return{
      'conteudo': conteudo,
    };
  }
  
}