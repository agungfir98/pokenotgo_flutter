class Pokemon {
  final String name;
  final List<PokemonTypes> types;
  final Sprites sprites;
  // final List stats;
  // final List abilities;
  // final List moves;

  const Pokemon({
    required this.name,
    required this.types,
    required this.sprites,
    // required this.stats,
    // required this.abilities,
    // required this.moves,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final List<dynamic> typesJsonList = json['types'];
    final List<PokemonTypes> types =
        typesJsonList.map((value) => PokemonTypes.fromJson(value)).toList();

    return Pokemon(
      name: json['name'],
      types: types,
      sprites: Sprites.fromJson(json['sprites']),
      // stats: json['stats'],
      // abilities: json['abilities'],
      // moves: json['moves'],
    );
  }
}

class PokemonTypes {
  final Type type;

  const PokemonTypes({
    required this.type,
  });

  factory PokemonTypes.fromJson(Map<String, dynamic> json) {
    return PokemonTypes(type: Type.fromJson(json['type']));
  }
}

class Type {
  final String name;

  const Type({
    required this.name,
  });

  factory Type.fromJson(Map<String, dynamic> json) {
    return Type(name: json['name']);
  }
}

class Sprites {
  final String frontDefault;

  const Sprites({
    required this.frontDefault,
  });

  factory Sprites.fromJson(Map<String, dynamic> json) {
    return Sprites(frontDefault: json['front_default']);
  }
}
