import 'package:cloud_firestore/cloud_firestore.dart';

List<String> ingredients = [];

class FirestoreDB {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<String>> getData() async {
    QuerySnapshot<Map<String, dynamic>> qr =
        await FirebaseFirestore.instance.collection('ingredients').get();
    List<String> str = [];
    for (var element in qr.docs) {
      final m = element.data();
      str.add(m['Name']);
    }
    ingredients = str;
    return str;
  }
}
