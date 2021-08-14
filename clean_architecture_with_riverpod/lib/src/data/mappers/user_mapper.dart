import 'package:test_application/src/data/api/models/api_user.dart';
import 'package:test_application/src/domain/entities/address.dart';
import 'package:test_application/src/domain/entities/company.dart';
import 'package:test_application/src/domain/entities/geo.dart';
import 'package:test_application/src/domain/entities/user.dart';

class UserMapper {

  static Geo _geoFromJson(Map<String, dynamic> json) {
    return Geo(
      lat: double.parse(json['lat']),
      lng: double.parse(json['lng'])
    );
  }

  static Address _addressFromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'],
      suite: json['suite'],
      city: json['city'],
      zipcode: json['zipcode'],
      geo: _geoFromJson(json['geo'])
    );
  }

  static Company _companyFromJson(Map<String, dynamic> json) {
    return Company(
      name: json['name'],
      catchPhrase: json['catchPhrase'],
      bs: json['bs']
    );
  }

  static User fromApi(ApiUser apiUser) {
    return User(
      id: apiUser.id,
      name: apiUser.name,
      username: apiUser.username,
      email: apiUser.email,
      address: _addressFromJson(apiUser.address),
      phone: apiUser.phone,
      website: apiUser.website,
      company: _companyFromJson(apiUser.company)
    );
  }
}