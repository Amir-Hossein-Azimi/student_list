class User {
  final String id;
  final String name;
  final String city;

  User({required this.id, required this.name, required this.city});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(),
      name: json['name'] ?? "",
      city: json['city'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'city': city};
  }
}
