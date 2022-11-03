import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDB {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<List<List<String>>> getData() async {
    QuerySnapshot<Map<String, dynamic>> qr =
        await FirebaseFirestore.instance.collection('recipes').get();
    List<List<String>> str = [];
    // print(str[0]);
    List<String> fetch_all_urls = [];
    List<String> fetch_rest = [];
    List<String> fetch_60 = [];
    List<String> fetch_70 = [];
    List<String> fetch_80 = [];
    List<String> fetch_90 = [];
    List<String> fetch_all_names = [];
    List<String> fetch_60_name = [];
    List<String> fetch_70_name = [];
    List<String> fetch_80_name = [];
    List<String> fetch_90_name = [];
    List<String> fetch_all_ids = [];
    List<String> fetch_60_id = [];
    List<String> fetch_70_id = [];
    List<String> fetch_80_id = [];
    List<String> fetch_90_id = [];
    List<String> test_ing = [
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
      List<dynamic> pointlist = m['Ingredients'];
      for (var p in pointlist) {
        for (i = 0; i <= (test_ing.length - 1); i++) {
          if (p == test_ing[i]) j++;
        }
      }
      var k = (j * j) / (test_ing.length * pointlist.length);
      print(mnj);
      mnj++;
      if (k >= 0.49) {
        //change
        fetch_90.add(m['image-url']);
        fetch_90_name.add(m['Name']);
        fetch_90_id.add(m['ID'].toString());
      } else if (k >= 0.25) {
        //change
        fetch_80.add(m['image-url']);
        fetch_80_name.add(m['Name']);
        fetch_80_id.add(m['ID'].toString());
      } else if (k >= 0.20) {
        //change
        fetch_70.add(m['image-url']);
        fetch_70_name.add(m['Name']);
        fetch_70_id.add(m['ID'].toString());
      } else if (k >= 0.16) {
        //change
        fetch_60.add(m['image-url']);
        fetch_60_name.add(m['Name']);
        fetch_60_id.add(m['ID'].toString());
      } else {
        fetch_rest.add(m['image-url']);
      }
    }
    int i;
    for (i = 0; i < fetch_90.length; i++) {
      if (i == 0) {
        fetch_all_urls.add("fetch_90");
        fetch_all_names.add("fetch_90");
        fetch_all_ids.add("fetch_90");
      }
      fetch_all_urls.add(fetch_90[i]);
      fetch_all_names.add(fetch_90_name[i]);
      fetch_all_ids.add(fetch_90_id[i]);
    }
    for (i = 0; i < fetch_80.length; i++) {
      if (i == 0) {
        fetch_all_urls.add("fetch_80");
        fetch_all_names.add("fetch_80");
        fetch_all_ids.add("fetch_80");
      }
      fetch_all_urls.add(fetch_80[i]);
      fetch_all_names.add(fetch_80_name[i]);
      fetch_all_ids.add(fetch_80_id[i]);
    }
    for (i = 0; i < fetch_70.length; i++) {
      if (i == 0) {
        fetch_all_urls.add("fetch_70");
        fetch_all_names.add("fetch_70");
        fetch_all_ids.add("fetch_70");
      }
      fetch_all_urls.add(fetch_70[i]);
      fetch_all_names.add(fetch_70_name[i]);
      fetch_all_ids.add(fetch_70_id[i]);
    }
    for (i = 0; i < fetch_60.length; i++) {
      if (i == 0) {
        fetch_all_urls.add("fetch_60");
        fetch_all_names.add("fetch_60");
        fetch_all_ids.add("fetch_60");
      }
      fetch_all_urls.add(fetch_60[i]);
      fetch_all_names.add(fetch_60_name[i]);
      fetch_all_ids.add(fetch_60_id[i]);
    }
    // str.add(fetch_all_urls);
    // str.add(fetch_all_names);
    // str.add(fetch_all_ids);
    for (int i = 0; i < fetch_all_urls.length; i++) {
      List<String> ls = [];
      ls.add(fetch_all_urls[i]);
      ls.add(fetch_all_names[i]);
      ls.add(fetch_all_ids[i]);
      str.add(ls);
    }
    print(fetch_all_urls.length);
    print(fetch_all_names.length);
    print(fetch_all_ids.length);
    print(str[0].length);
    return str;
  }

  // Future<void> getData() async {
  //   getDataURL();
  //   getDataName();
  // }

  //
  int addData(String txt) {
    print(txt);
    return 0;
  }
}
