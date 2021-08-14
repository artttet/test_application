import 'package:test_application/src/domain/entities/address.dart';
import 'package:test_application/src/domain/entities/company.dart';

class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final Address address;
  final String phone;
  final String website;
  final Company company;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
  });

  const User._empty()
      : id = 0,
        name = '',
        username = '',
        email = '',
        address = const AddressEmpty(),
        phone = '',
        website = '',
        company = const CompanyEmpty();
}

class UserEmpty extends User {
  const UserEmpty() : super._empty();
}