class PokeList {
  final int id;
  final String name;
  final String image;

  const PokeList({
    required this.id,
    required this.name,
    required this.image,
  });

  factory PokeList.fromJson(Map<String, dynamic> json) {
    return PokeList(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}
