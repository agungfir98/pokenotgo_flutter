import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'pages/collection.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await initHiveForFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemon Not Go',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: 'Poke Not GO'),
        '/collections': (context) => const PokeCollection()
      },
      // home: const MyHomePage(title: 'Poke Not GO'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> pokemonList = [];
  @override
  void initState() {
    super.initState();
    initialization();
    fetchData();
  }

  void fetchData() async {
    HttpLink apiUri = HttpLink('https://graphql-pokeapi.graphcdn.app/');
    GraphQLClient qlClient = GraphQLClient(
      link: apiUri,
      cache: GraphQLCache(
        store: HiveStore(),
      ),
    );

    String qlString = """query (\$limit: Int!, \$offset: Int!) {
    pokemons(limit: \$limit, offset: \$offset) {
      results {
        name
        id
        dreamworld
        image
      }
    }
  }""";

    QueryResult queryResult = await qlClient.query(QueryOptions(
        document: gql(qlString), variables: const {'limit': 5, 'offset': 1}));

    setState(() {
      pokemonList = queryResult.data!["pokemons"]!["results"];
    });
  }

  void initialization() async {
    FlutterNativeSplash.remove();
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
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: pokemonList.length,
              itemBuilder: (context, index) {
                return Cards(pokemonList[index]);
              },
            ),
          ],
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/collections');
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

  Widget Cards(item) {
    return Card(
      child: Text(item!["name"]),
    );
  }
}
