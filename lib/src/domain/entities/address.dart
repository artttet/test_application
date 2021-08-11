import 'package:test_application/src/domain/entities/geo.dart';

class Address {
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final Geo geo;

  Address({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.geo, 
  });

  const Address._empty()
    : street = '',
      suite = '',
      city = '',
      zipcode = '',
      geo = const GeoEmpty();
}

class AddressEmpty extends Address {
  const AddressEmpty() : super._empty();
}