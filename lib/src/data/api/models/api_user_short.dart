class ApiUserShort {
  static const dataKey = 'ApiUserShort';
  
  final int id;
  final String username;
  final String name;

  ApiUserShort({
    required this.id,
    required this.username,
    required this.name
  });

  ApiUserShort.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        name = json['name'];

  Map<String, dynamic> toJson() => {
    'id': this.id,
    'username': this.username,
    'name': this.name,
  };
}
