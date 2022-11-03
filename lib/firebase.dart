import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDB {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<List<String>> getData() async {
    QuerySnapshot<Map<String, dynamic>> qr =
        await FirebaseFirestore.instance.collection('ingredients').get();
    List<String> str=[];
     for (var element in qr.docs) {
      final m = element.data();
      str.add(m['Name']);
    }

    return str;
  }

  Future<void> addData() async {
    await FirebaseFirestore.instance
        .collection('comments')
        .add({'data': 'hello'});
  }
}
