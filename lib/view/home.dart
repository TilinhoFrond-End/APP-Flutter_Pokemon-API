import 'dart:convert';
import 'package:projeto_poke/view/infopoke.dart';
import 'package:projeto_poke/view/pokemon.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Selecione um Pokemon"),
      ),
      body: Center(
        child: ListSearch(),
      ),
    );
  }
}

class ListSearch extends StatefulWidget {
  ListSearchState createState() => ListSearchState();
}

class ListSearchState extends State<ListSearch> {

  @override
  void initState() {
    super.initState();

    fetchData();
    //name;
    //image_id;
    //type;
  }

  fetchDatainfo(name, url) async {
    http.Response res = await http.get(url);
    String data = res.body;
    var decodedJson = jsonDecode(data);
    List list_type = [];
    for(var d in decodedJson['types']){
      list_type.add(d['type']['name']);
    }
    pokemons_info.add(infoPokemon(nome: name, height: decodedJson['height'], weight: decodedJson['weight'], id_image: decodedJson['sprites']['front_default'], type: list_type));
  }

  fetchData() async {
    http.Response res = await http.get(url);
    String data = res.body;
    var decodedJson = jsonDecode(data);

    for (var d in decodedJson['results']){
      nomes_pokemons.add(d['name']);
      var newurl = Uri.parse(d['url']);
      fetchDatainfo(d['name'], newurl);
    }
    setState(() {});
  }

  TextEditingController _textController = TextEditingController();
  var url = Uri.parse("https://pokeapi.co/api/v2/pokemon/");
  final tabela = infoPokemon.tabela;
  static final mainDataList = nomes_pokemons;
  List<String> newDataList = List.from(mainDataList);

  onItemChanged(String value) {
    setState(() {
      newDataList = mainDataList
          .where((string) => string.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      elevation: 5,
      padding: EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      backgroundColor: const Color(0xff0303ff),
    );
    return Scaffold(
      body: Column(
        children: <Widget>[
          /*Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Quantas disciplinas você \ndeseja cursar esse período ?',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3)),
            ],
          ),*/
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search Here...',
              ),
              onChanged: onItemChanged,
            ),
          ),
          Expanded(
            child: new GridView.builder(
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              padding: EdgeInsets.all(2.0),
              itemCount: tabela.length,
              itemBuilder: (BuildContext context, indice) {
                return Card(
                  child: InkWell(
                    splashColor: Colors.orange,
                    onTap: () {
                      print(indice);
                      name = tabela[indice].nome;
                      image_id = tabela[indice].id_image;
                      type = tabela[indice].type.join(', ');
                      height = (tabela[indice].height)/10;
                      weight = (tabela[indice].weight)/10;
                      Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => infopoke()),
                  );
                },
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget> [
                      Container(
                          height: 125,
                          width: 125,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(tabela[indice].id_image))),
                      ),
                      Text(
                      tabela[indice].nome,
                        style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        ),
                        )
                      ])
                  )
                );
              },
            ),
          ),
          /*SafeArea(
              child: Container(
                padding: EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    top: MediaQuery.of(context).size.height * 0.01),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          style: flatButtonStyle,
                          onPressed: () {
                            /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const count()),
                            );*/
                          },
                          child: Text(
                            'PROXIMO',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ))*/
        ],
      ),
    );
  }

}