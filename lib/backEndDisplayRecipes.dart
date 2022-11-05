import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDB {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<List<String>>> getData(List<String?> selectedIngredients) async {
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
    int mnj = 0;
    for (var element in qr.docs) {
      if (mnj > 100) break;
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
      if (k >= 0.40) {
        //change
        fetch_90.add(m['image-url']);
        fetch90Name.add(m['Name']);
        fetch90Id.add(m['ID'].toString());
      } else if (k >= 0.30) {
        //change
        fetch_80.add(m['image-url']);
        fetch80Name.add(m['Name']);
        fetch80Id.add(m['ID'].toString());
      } else if (k >= 0.20) {
        //change
        fetch_70.add(m['image-url']);
        fetch70Name.add(m['Name']);
        fetch70Id.add(m['ID'].toString());
      } else if (k >= 0.10) {
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
        fetchAllUrls.add(">=90");
        fetchAllNames.add(">=90");
        fetchAllIds.add(">=90");
        fetchAllUrls.add(" ");
        fetchAllNames.add(">=90");
        fetchAllIds.add(" ");
        fetchAllUrls.add(" ");
        fetchAllNames.add(">=90");
        fetchAllIds.add(" ");
      }
      fetchAllUrls.add(fetch_90[i]);
      fetchAllNames.add(fetch90Name[i]);
      fetchAllIds.add(fetch90Id[i]);
    }
    if (fetchAllIds.length % 3 != 0) {
      int rem = 3 - (fetchAllIds.length % 3);
      while (rem > 0) {
        fetchAllUrls.add("text");
        fetchAllNames.add(" ");
        fetchAllIds.add(" ");
        rem--;
      }
    }
    for (i = 0; i < fetch_80.length; i++) {
      if (i == 0) {
        fetchAllUrls.add(">=80");
        fetchAllNames.add(">=80");
        fetchAllIds.add(">=80");
        fetchAllUrls.add(" ");
        fetchAllNames.add(">=80");
        fetchAllIds.add(" ");
        fetchAllUrls.add(" ");
        fetchAllNames.add(">=80");
        fetchAllIds.add(" ");
      }
      fetchAllUrls.add(fetch_80[i]);
      fetchAllNames.add(fetch80Name[i]);
      fetchAllIds.add(fetch80Id[i]);
    }
    if (fetchAllIds.length % 3 != 0) {
      int rem = 3 - (fetchAllIds.length % 3);
      while (rem > 0) {
        fetchAllUrls.add("text");
        fetchAllNames.add(" ");
        fetchAllIds.add(" ");
        rem--;
      }
    }
    for (i = 0; i < fetch_70.length; i++) {
      if (i == 0) {
        fetchAllUrls.add(">=70");
        fetchAllNames.add(">=70");
        fetchAllIds.add(">=70");
        fetchAllUrls.add(" ");
        fetchAllNames.add(">=70");
        fetchAllIds.add(" ");
        fetchAllUrls.add(" ");
        fetchAllNames.add(">=70");
        fetchAllIds.add(" ");
      }
      fetchAllUrls.add(fetch_70[i]);
      fetchAllNames.add(fetch70Name[i]);
      fetchAllIds.add(fetch70Id[i]);
    }
    if (fetchAllIds.length % 3 != 0) {
      int rem = 3 - (fetchAllIds.length % 3);
      while (rem > 0) {
        fetchAllUrls.add("text");
        fetchAllNames.add(" ");
        fetchAllIds.add(" ");
        rem--;
      }
    }
    for (i = 0; i < fetch_60.length; i++) {
      if (i == 0) {
        fetchAllUrls.add(">=60");
        fetchAllNames.add(">=60");
        fetchAllIds.add(">=60");
        fetchAllUrls.add(" ");
        fetchAllNames.add(">=60");
        fetchAllIds.add(" ");
        fetchAllUrls.add(" ");
        fetchAllNames.add(">=60");
        fetchAllIds.add(" ");
      }
      fetchAllUrls.add(fetch_60[i]);
      fetchAllNames.add(fetch60Name[i]);
      fetchAllIds.add(fetch60Id[i]);
    }
    if (fetchAllIds.length % 3 != 0) {
      int rem = 3 - (fetchAllIds.length % 3);
      while (rem > 0) {
        fetchAllUrls.add("text");
        fetchAllNames.add(" ");
        fetchAllIds.add(" ");
        rem--;
      }
    }
    for (int i = 0; i < fetchAllUrls.length; i++) {
      List<String> ls = [];
      ls.add(fetchAllUrls[i]);
      ls.add(fetchAllNames[i]);
      ls.add(fetchAllIds[i]);
      str.add(ls);
    }
    if (str[0].isEmpty) {
      fetchAllIds.add("Basic");
      fetchAllUrls.add('');
      fetchAllNames.add('');
      fetchAllIds.add("Text");
      fetchAllUrls.add('');
      fetchAllNames.add('');
      fetchAllIds.add("Text");
      fetchAllUrls.add('');
      fetchAllNames.add('');
      //Start filling from here on
      fetchAllIds.add('1');
      fetchAllUrls.add('');
      fetchAllNames.add('');
      fetchAllIds.add('1');
      fetchAllUrls.add('');
      fetchAllNames.add('');
      fetchAllIds.add('1');
      fetchAllUrls.add('');
      fetchAllNames.add('');
    }
    return str;
  }
}
