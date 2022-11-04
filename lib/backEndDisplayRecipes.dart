import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDB {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<List<List<String>>> getData() async {
    QuerySnapshot<Map<String, dynamic>> qr =
    await FirebaseFirestore.instance.collection('recipes').get();
    List<List<String>> str = [];
    // print(str[0]);
    List<String> fetchAllUrls = [];
    List<String> fetchRest = [];
    List<String> fetch_60 = [];
    List<String> fetch_70 = [];
    List<String> fetch_80 = [];
    List<String> fetch_90 = [];
    List<String> fetchAllNames = [];
    List<String> fetch60Name = [];
    List<String> fetch70Name = [];
    List<String> fetch80Name = [];
    List<String> fetch90Name = [];
    List<String> fetchAllIds = [];
    List<String> fetch60Id = [];
    List<String> fetch70Id = [];
    List<String> fetch80Id = [];
    List<String> fetch90Id = [];
    List<String> selectedIngredients = [
      'tomato',
      'salt',
      'cumin powder jeera',
      'pepper pepper',
      'cloves garlic',
      'virgin olive oil',
      'onion',
      'dry beans such cannellini soya beans',
      'red chilli powder cayenne pepper',
      'dried oregano'
    ];
    int mnj = 0;
    for (var element in qr.docs) {
      if (mnj > 1500) break;
      final m = element.data();
      int i = 0, j = 0;
      List<dynamic> pointList = m['Ingredients'];
      for (var p in pointList) {
        for (i = 0; i <= (selectedIngredients.length - 1); i++) {
          if (p == selectedIngredients[i]) j++;
        }
      }
      var k = (j * j) / (selectedIngredients.length * pointList.length);
      //print(mnj);
      mnj++;
      if (k >= 0.81) {
        //change
        fetch_90.add(m['image-url']);
        fetch90Name.add(m['Name']);
        fetch90Id.add(m['ID'].toString());
      } else if (k >= 0.64) {
        //change
        fetch_80.add(m['image-url']);
        fetch80Name.add(m['Name']);
        fetch80Id.add(m['ID'].toString());
      } else if (k >= 0.49) {
        //change
        fetch_70.add(m['image-url']);
        fetch70Name.add(m['Name']);
        fetch70Id.add(m['ID'].toString());
      } else if (k >= 0.36) {
        //change
        fetch_60.add(m['image-url']);
        fetch60Name.add(m['Name']);
        fetch60Id.add(m['ID'].toString());
      } else {
        fetchRest.add(m['image-url']);
      }
    }
    int i;
    for (i = 0; i < fetch_90.length; i++) {
      if (i == 0) {
        fetchAllUrls.add("fetch_90");
        fetchAllNames.add("fetch_90");
        fetchAllIds.add("fetch_90");
      }
      fetchAllUrls.add(fetch_90[i]);
      fetchAllNames.add(fetch90Name[i]);
      fetchAllIds.add(fetch90Id[i]);
    }
    for (i = 0; i < fetch_80.length; i++) {
      if (i == 0) {
        fetchAllUrls.add("fetch_80");
        fetchAllNames.add("fetch_80");
        fetchAllIds.add("fetch_80");
      }
      fetchAllUrls.add(fetch_80[i]);
      fetchAllNames.add(fetch80Name[i]);
      fetchAllIds.add(fetch80Id[i]);
    }
    for (i = 0; i < fetch_70.length; i++) {
      if (i == 0) {
        fetchAllUrls.add("fetch_70");
        fetchAllNames.add("fetch_70");
        fetchAllIds.add("fetch_70");
      }
      fetchAllUrls.add(fetch_70[i]);
      fetchAllNames.add(fetch70Name[i]);
      fetchAllIds.add(fetch70Id[i]);
    }
    for (i = 0; i < fetch_60.length; i++) {
      if (i == 0) {
        fetchAllUrls.add("fetch_60");
        fetchAllNames.add("fetch_60");
        fetchAllIds.add("fetch_60");
      }
      fetchAllUrls.add(fetch_60[i]);
      fetchAllNames.add(fetch60Name[i]);
      fetchAllIds.add(fetch60Id[i]);
    }
    for (int i = 0; i < fetchAllUrls.length; i++) {
      List<String> ls = [];
      ls.add(fetchAllUrls[i]);
      ls.add(fetchAllNames[i]);
      ls.add(fetchAllIds[i]);
      str.add(ls);
    }
    return str;
  }
}