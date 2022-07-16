/*class Pokemon {
  late String url;
  late String nome;

  Pokemon({
    required this.url,
    required this.nome,
  });
}*/

class infoPokemon {
  late String nome;
  late int height; //altura
  late int weight; //peso
  late String id_image;
  late  List type;
  static List<infoPokemon> tabela = pokemons_info;

  infoPokemon({
    required this.nome,
    required this.height,
    required this.weight,
    required this.id_image,
    required this.type
});
}

List<String> nomes_pokemons = [];

List<infoPokemon> pokemons_info = [];
var name;
var image_id;
var type;
var height;
var weight;