import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pokenotgo/graphql/api_uri.dart';
import 'package:pokenotgo/model/pokeList.model.dart';
import 'package:pokenotgo/pages/collection.dart';
import 'package:pokenotgo/pages/poke_detail.dart';

class MyHomePage extends StatefulWidget {
  static String nameRoute = '/';
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<PokeList> _pokemonList = [];
  String searchInput = "";

  final pokemon = FetchPokemon();
  @override
  void initState() {
    super.initState();
    initialization();
    getData();
  }

  void getData() async {
    final QueryResult queryResult = await pokemon.getData(
      """query (\$limit: Int!, \$offset: Int!) {
    pokemons(limit: \$limit, offset: \$offset) {
      results {
        name
        id
        dreamworld
        image
      }
    }
  }""",
      {'limit': 5, 'offset': 1},
    );
    print(queryResult.data!['pokemons']!['results']);
    final List<dynamic> decodeJson = queryResult.data!['pokemons']!['results'];
    List<PokeList> pokemonList =
        decodeJson.map((json) => PokeList.fromJson(json)).toList();
    setState(() {
      _pokemonList = pokemonList;
    });
  }

  void initialization() async {
    FlutterNativeSplash.remove();
  }

  void submitSearch() {
    print(searchInput);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Center(
              child: Container(
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                alignment: Alignment.center,
                width: 300,
                child: TextFormField(
                  onChanged: (value) => setState(() {
                    searchInput = value;
                  }),
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      color: Colors.black26,
                      onPressed: submitSearch,
                    ),
                  ),
                ),
              ),
            ),
            GridView.builder(
                itemCount: _pokemonList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                shrinkWrap: true,
                padding: const EdgeInsets.all(8.0),
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              PokeDetail(name: _pokemonList[index].name),
                        ),
                      );
                    },
                    child: pokeCard(
                      _pokemonList[index].image,
                      _pokemonList[index].name,
                    ),
                  );
                }),
            ElevatedButton(
              onPressed: () {
                // getData();
                print(_pokemonList);
              },
              child: const Text('console'),
            ),
          ],
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, PokeCollection.nameRoute);
              },
              tooltip: 'Pokemon ku',
              child: const Icon(
                Icons.catching_pokemon,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ));
  }

  Card pokeCard(String imgUrl, String pokeName) {
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Color.fromARGB(255, 208, 208, 208),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Image(
            fit: BoxFit.cover,
            height: 100,
            image: NetworkImage(imgUrl),
          ),
          const SizedBox(),
          Text(pokeName)
        ],
      ),
    );
  }
}
