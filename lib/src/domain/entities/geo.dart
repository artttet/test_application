class Geo {
  final double lat;
  final double lng;

  Geo({
    required this.lat,
    required this.lng
  });

  const Geo._empty()
    : lat = 0.0,
      lng = 0.0;
}

class GeoEmpty extends Geo {
  const GeoEmpty() : super._empty();
}