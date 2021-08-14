class ApiUser {
  static const dataKey = 'ApiUser';

  final int id;
  final String name;
  final String username;
  final String email;
  final Map<String, dynamic> address;
  final String phone;
  final String website;
  final Map<String, dynamic> company;

  ApiUser({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
  });

  ApiUser.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        username = json['username'],
        email = json['email'],
        address = json['address'],
        phone = json['phone'],
        website = json['website'],
        company = json['company'];

  Map<String, dynamic> toJson() => {
    'id': this.id,
    'name': this.name,
    'username': this.username,
    'email': this.email,
    'address': this.address,
    'phone': this.phone,
    'website': this.website,
    'company': this.company,
  };
}