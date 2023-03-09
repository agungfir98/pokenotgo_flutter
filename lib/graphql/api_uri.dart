import 'package:graphql_flutter/graphql_flutter.dart';

class FetchPokemon {
  final HttpLink _apiUri = HttpLink('https://graphql-pokeapi.graphcdn.app/');

  Future getData(String gqlString, dynamic variables) async {
    GraphQLClient qlClient = GraphQLClient(
      link: _apiUri,
      cache: GraphQLCache(store: HiveStore()),
    );
    QueryResult queryResult = await qlClient.query(
      QueryOptions(document: gql(gqlString), variables: variables),
    );
    if (queryResult.hasException) {
      throw queryResult.exception!;
    } else {
      return queryResult;
    }
  }
}
