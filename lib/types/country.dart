import 'package:cloud_firestore/cloud_firestore.dart';

class Country {
  final String name;
  final String continent;
  final DocumentReference reference;

  Country.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['continent'] != null),
        name = map['name'],
        continent = map['continent'];

  Country.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Country<$name:$continent>";
}