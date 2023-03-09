import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pokenotgo/graphql/api_uri.dart';
import 'package:pokenotgo/model/pokemon.model.dart';

class PokeDetail extends StatefulWidget {
  static String nameRoute = '/detail';
  const PokeDetail({super.key, required this.name});

  final String name;

  @override
  State<PokeDetail> createState() => _PokeDetailState();
}

class _PokeDetailState extends State<PokeDetail> {
  final getPokemon = FetchPokemon();
  late Pokemon _pokemon = const Pokemon(name: '', types: []);

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    QueryResult queryResult = await getPokemon.getData(
      """query (\$name: String!) {
  pokemon(name: \$name) {
    name
    sprites {
      front_default
    }
    types {
      type {
        name
      }
    }
    stats {
      stat {
        name
      }
      base_stat
    }
    abilities {
      ability {
        name
      }
    }
    moves {
      move {
        name
      }
    }
  }
}""",
      {"name": widget.name},
    );

    print(queryResult.data!['pokemon']);
    final dynamic pokemonJSON = queryResult.data!['pokemon'];
    final Pokemon pokemon = Pokemon.fromJson(pokemonJSON);
    _pokemon = pokemon;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Details'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'detail pokemon ${_pokemon.name} ${_pokemon.types.map((e) => "${e.type.name} ")}',
                style: const TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w800,
                  fontSize: 30,
                ),
                textAlign: TextAlign.center,
              ),
              ElevatedButton(
                  onPressed: () {
                    print(_pokemon);
                  },
                  child: const Text('Print'))
            ],
          ),
        ));
  }
}
