import 'package:borefts2020/ext/types.dart';

class Brewers {
  final List<Brewer> brewers;

  Brewers(this.brewers);

  factory Brewers.fromJson(Map<String, dynamic> json) {
    Iterable brewers = json['brewers'];
    return Brewers(new List<Brewer>.from(
      brewers.map((brewer) => Brewer.fromJson(brewer)).toList(),
    ));
  }
}

class Brewer {
  final int id;
  final String name;
  final String shortName;
  final String sortName;
  final String logoUrl;
  final String city;
  final String country;
  final String website;
  final String twitter;
  final double latitude;
  final double longitude;

  Brewer(
      this.id,
      this.name,
      this.shortName,
      this.sortName,
      this.logoUrl,
      this.city,
      this.country,
      this.website,
      this.twitter,
      this.latitude,
      this.longitude);

  factory Brewer.fromJson(Map<String, dynamic> json) {
    return Brewer(
        json['id'],
        json['name'],
        json['shortName'],
        json['sortName'],
        json['logoUrl'],
        json['city'],
        json['country'],
        json['website'],
        json['twitter'],
        cst(json['latitude']),
        cst(json['longitude']));
  }
}
