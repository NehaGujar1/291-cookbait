import 'package:cloud_firestore/cloud_firestore.dart';

class DisplayOptions {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<List<String>> getData(List<String> test_ing) async {
    QuerySnapshot<Map<String, dynamic>> qr =
        await FirebaseFirestore.instance.collection('recipes').get();
    List<String> str = [];
    List<String> str2 = [];
    List<String> fetch_60 = [];
    List<String> fetch_70 = [];
    List<String> fetch_80 = [];
    List<String> fetch_90 = [];
    int i = 0, j = 0;
    for (var element in qr.docs) {
      final m = element.data();
      // str.add(m['Ingredients']);
      for (var p in m['Ingredients']) {
        for (i = 0; i <= (test_ing.length - 1); i++) {
          if (p.data() == test_ing[i]) j++;
        }
      }
      var k = (j * j) / (test_ing.length * m['Ingredients'].length);
      if (k >= 0.9) {
        fetch_90.add(m['image-url']);
        fetch_90.add(m['ID']);
        fetch_90.add(m['Name']);
      } else if (k >= 0.8) {
        fetch_80.add(m['image-url']);
        fetch_80.add(m['ID']);
        fetch_80.add(m['Name']);
      } else if (k >= 0.7) {
        fetch_70.add(m['image-url']);
        fetch_70.add(m['ID']);
        fetch_70.add(m['Name']);
      } else if (k >= 0.6) {
        fetch_60.add(m['image-url']);
        fetch_60.add(m['ID']);
        fetch_60.add(m['Name']);
      }
      j = 0;
      // str2.add(m['ID']);
    }
    str.add("fetch_90");
    for (var t = 0; t < fetch_90.length; t++) {
      str.add(fetch_90[t]);
    }
    str.add("fetch_80");
    for (var t = 0; t < fetch_80.length; t++) {
      str.add(fetch_80[t]);
    }
    str.add("fetch_70");
    for (var t = 0; t < fetch_70.length; t++) {
      str.add(fetch_70[t]);
    }
    str.add("fetch_60");
    for (var t = 0; t < fetch_60.length; t++) {
      str.add(fetch_60[t]);
    }
    return str;
  }
}
