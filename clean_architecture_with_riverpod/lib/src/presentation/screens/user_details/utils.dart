import 'package:test_application/src/domain/entities/address.dart';

class UserDetailsUtils {
  static String getFullAddress(Address address) {
    return address.city + ', ' +
           address.street + ', ' +
           address.suite + ', ' +
           address.zipcode +
           ' (${address.geo.lat}, ${address.geo.lng})';
  }
}