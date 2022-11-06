import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDB {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<List<String>>> getData(List<String?> selectedIngredients) async {
    QuerySnapshot<Map<String, dynamic>> qr =
        await FirebaseFirestore.instance.collection('recipes').get();
    List<List<String>> str = [];
    // print(str[0]);
    List<String> fetchAllUrls = [];
    List<String> fetchAllBools = [];
    List<String> fetchAllTexts = [];
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
      if (k >= 0.49) {
        //change
        fetch_90.add(m['image-url']);
        fetch90Name.add(m['Name']);
        fetch90Id.add(m['ID'].toString());
      } else if (k >= 0.36) {
        //change
        fetch_80.add(m['image-url']);
        fetch80Name.add(m['Name']);
        fetch80Id.add(m['ID'].toString());
      } else if (k >= 0.25) {
        //change
        fetch_70.add(m['image-url']);
        fetch70Name.add(m['Name']);
        fetch70Id.add(m['ID'].toString());
      } else if (k >= 0.16) {
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
        fetchAllBools.add('1');
        // fetchAllUrls.add(">=90");
        // fetchAllNames.add(">=90");
        // fetchAllIds.add(">=90");
        // fetchAllUrls.add(" ");
        // fetchAllNames.add(">=90");
        // fetchAllIds.add(" ");
        // fetchAllUrls.add(" ");
        // fetchAllNames.add(">=90");
        // fetchAllIds.add(" ");
        fetchAllTexts.add(">=90");
      } else if(i==1){
        fetchAllBools.add('1');
        fetchAllTexts.add(" ");
      } else {
        fetchAllBools.add('0');
        fetchAllTexts.add(">=90");
      }
      fetchAllUrls.add(fetch_90[i]);
      fetchAllNames.add(fetch90Name[i]);
      fetchAllIds.add(fetch90Id[i]);
    }
    if (fetchAllIds.length % 2 != 0) {
      int rem = 2 - (fetchAllIds.length % 2);
      while (rem > 0) {
        fetchAllBools.add('0');
        fetchAllUrls.add("text");
        fetchAllNames.add(" ");
        fetchAllIds.add(" ");
        fetchAllTexts.add(">=90");
        rem--;
      }
    }
    for (i = 0; i < fetch_80.length; i++) {
      if (i == 0) {
        fetchAllBools.add('1');
        // fetchAllUrls.add(">=80");
        // fetchAllNames.add(">=80");
        // fetchAllIds.add(">=80");
        // fetchAllUrls.add(" ");
        // fetchAllNames.add(">=80");
        // fetchAllIds.add(" ");
        // fetchAllUrls.add(" ");
        // fetchAllNames.add(">=80");
        // fetchAllIds.add(" ");
        fetchAllTexts.add(">=80");
      } else if(i==1){
      fetchAllBools.add('1');
      fetchAllTexts.add(" ");
      } else {
      fetchAllBools.add('0');
      fetchAllTexts.add(">=80");
      }
      // fetchAllTexts.add(">=80");
      fetchAllUrls.add(fetch_80[i]);
      fetchAllNames.add(fetch80Name[i]);
      fetchAllIds.add(fetch80Id[i]);
    }
    if (fetchAllIds.length % 2 != 0) {
      int rem = 2 - (fetchAllIds.length % 2);
      while (rem > 0) {
        fetchAllBools.add('0');
        fetchAllUrls.add("text");
        fetchAllNames.add(" ");
        fetchAllIds.add(" ");
        fetchAllTexts.add(">=80");
        rem--;
      }
    }
    for (i = 0; i < fetch_70.length; i++) {
      if (i == 0) {
        fetchAllBools.add('1');
        // fetchAllUrls.add(">=70");
        // fetchAllNames.add(">=70");
        // fetchAllIds.add(">=70");
        // fetchAllUrls.add(" ");
        // fetchAllNames.add(">=70");
        // fetchAllIds.add(" ");
        // fetchAllUrls.add(" ");
        // fetchAllNames.add(">=70");
        // fetchAllIds.add(" ");
        fetchAllTexts.add(">=70");
      } else if(i==1){
        fetchAllBools.add('1');
        fetchAllTexts.add(" ");
      } else {
        fetchAllBools.add('0');
        fetchAllTexts.add(">=70");
      }
      // fetchAllTexts.add(">=70");
      fetchAllUrls.add(fetch_70[i]);
      fetchAllNames.add(fetch70Name[i]);
      fetchAllIds.add(fetch70Id[i]);
    }
    if (fetchAllIds.length % 2 != 0) {
      int rem = 2 - (fetchAllIds.length % 2);
      while (rem > 0) {
        fetchAllBools.add('0');
        fetchAllUrls.add("text");
        fetchAllNames.add(" ");
        fetchAllIds.add(" ");
        fetchAllTexts.add(">=70");
        rem--;
      }
    }
    for (i = 0; i < fetch_60.length; i++) {
      if (i == 0) {
        fetchAllBools.add('1');
        // fetchAllUrls.add(">=60");
        // fetchAllNames.add(">=60");
        // fetchAllIds.add(">=60");
        // fetchAllUrls.add(" ");
        // fetchAllNames.add(">=60");
        // fetchAllIds.add(" ");
        // fetchAllUrls.add(" ");
        // fetchAllNames.add(">=60");
        // fetchAllIds.add(" ");
        fetchAllTexts.add(">=60");
      } else if(i==1){
        fetchAllBools.add('1');
        fetchAllTexts.add(" ");
      } else {
        fetchAllBools.add('0');
        fetchAllTexts.add(">=60");
      }
      // fetchAllTexts.add(">=60");
      fetchAllUrls.add(fetch_60[i]);
      fetchAllNames.add(fetch60Name[i]);
      fetchAllIds.add(fetch60Id[i]);
    }
    if (fetchAllIds.length % 2 != 0) {
      int rem = 2 - (fetchAllIds.length % 2);
      while (rem > 0) {
        fetchAllBools.add('0');
        fetchAllUrls.add("text");
        fetchAllNames.add(" ");
        fetchAllIds.add(" ");
        fetchAllTexts.add(">=60");
        rem--;
      }
    }
    for (int i = 0; i < fetchAllUrls.length; i++) {
      List<String> ls = [];
      ls.add(fetchAllBools[i]);
      ls.add(fetchAllUrls[i]);
      ls.add(fetchAllNames[i]);
      ls.add(fetchAllIds[i]);
      ls.add(fetchAllTexts[i]);
      str.add(ls);
    }
    if (str[0].isEmpty) {
      // fetchAllBools.add('0');
      //   fetchAllUrls.add(" ");
      //   fetchAllNames.add(" ");
      //   fetchAllIds.add("Basic");
      //   fetchAllTexts.add(">=60");
      // fetchAllBools.add('0');
      //   fetchAllUrls.add("Basic2");
      //   fetchAllNames.add(" ");
      //   fetchAllIds.add(" ");
      //   fetchAllTexts.add(">=60");
      // fetchAllIds.add("Text");
      // fetchAllUrls.add('');
      // fetchAllNames.add('');
      //Start filling from here on
      fetchAllBools.add('1');
      fetchAllIds.add('1');
      fetchAllUrls.add('https://www.archanaskitchen.com/images/archanaskitchen/1-Author/Anjana_Chaturvedi/Cabbage_and_carrot_sambharo.jpg');
      fetchAllNames.add('Masala Karela');
      fetchAllTexts.add('No matches!Suggestions:');
      fetchAllBools.add('1');
      fetchAllIds.add('1');
      fetchAllUrls.add('https://www.archanaskitchen.com/images/archanaskitchen/1-Author/Anjana_Chaturvedi/Cabbage_and_carrot_sambharo.jpg');
      fetchAllNames.add('Masala Karela');
      fetchAllTexts.add(' ');
      fetchAllBools.add('0');
      fetchAllIds.add('1');
      fetchAllUrls.add('https://www.archanaskitchen.com/images/archanaskitchen/1-Author/Anjana_Chaturvedi/Cabbage_and_carrot_sambharo.jpg');
      fetchAllNames.add('Masala Karela');
      fetchAllTexts.add('Basic');
      fetchAllBools.add('0');
      fetchAllIds.add('1');
      fetchAllUrls.add('https://www.archanaskitchen.com/images/archanaskitchen/1-Author/Anjana_Chaturvedi/Cabbage_and_carrot_sambharo.jpg');
      fetchAllNames.add('Masala Karela');
      fetchAllTexts.add('Basic');
      // fetchAllIds.add('1');
      // fetchAllUrls.add('');
      // fetchAllNames.add('');
      // print("hellllllllllllllllllllllooooooooooooo");
      // print(fetchAllUrls.length);
      for (int i = 0; i < fetchAllUrls.length; i++) {
        List<String> ls = [];
        ls.add(fetchAllBools[i]);
        ls.add(fetchAllUrls[i]);
        ls.add(fetchAllNames[i]);
        ls.add(fetchAllIds[i]);
        ls.add(fetchAllTexts[i]);
        str.add(ls);
      }
    }
    return str;
  }

  List<List<String>> getData2(List<String?> selectedIngredients) {
    List<String> fetchAllUrls = [];
    List<String> fetchAllNames = [];
    List<String> fetchAllIds = [];
    List<String> fetchAllBools = [];
    List<String> fetchAllTexts = [];
    List<List<String>> str = [];
    // fetchAllIds.add("Basic");
    // fetchAllUrls.add('');
    // fetchAllNames.add('');
    // fetchAllIds.add("Basic2");
    // fetchAllUrls.add('');
    // fetchAllNames.add('');
    // fetchAllIds.add("Text");
    // fetchAllUrls.add('');
    // fetchAllNames.add('');
    //Start filling from here on
    fetchAllBools.add('1');
    fetchAllIds.add('1');
    fetchAllUrls.add('https://www.archanaskitchen.com/images/archanaskitchen/1-Author/Anjana_Chaturvedi/Cabbage_and_carrot_sambharo.jpg');
    fetchAllNames.add('Masala Karela');
    fetchAllTexts.add('No matches!Suggestions:');
    fetchAllBools.add('1');
    fetchAllIds.add('1');
    fetchAllUrls.add('https://www.archanaskitchen.com/images/archanaskitchen/1-Author/Anjana_Chaturvedi/Cabbage_and_carrot_sambharo.jpg');
    fetchAllNames.add('Masala Karela');
    fetchAllTexts.add(' ');
    fetchAllBools.add('0');
    fetchAllIds.add('1');
    fetchAllUrls.add('https://www.archanaskitchen.com/images/archanaskitchen/1-Author/Anjana_Chaturvedi/Cabbage_and_carrot_sambharo.jpg');
    fetchAllNames.add('Masala Karela');
    fetchAllTexts.add('Basic');
    fetchAllBools.add('0');
    fetchAllIds.add('1');
    fetchAllUrls.add('https://www.archanaskitchen.com/images/archanaskitchen/1-Author/Anjana_Chaturvedi/Cabbage_and_carrot_sambharo.jpg');
    fetchAllNames.add('Masala Karela');
    fetchAllTexts.add('Basic');
    // fetchAllIds.add("Basic");
    // fetchAllUrls.add('');
    // fetchAllNames.add('');
    // fetchAllIds.add("Basic2");
    // fetchAllUrls.add('');
    // fetchAllNames.add('');
    // // fetchAllIds.add("Text");
    // fetchAllUrls.add('');
    // fetchAllNames.add('');
    //Start filling from here on
    fetchAllBools.add('1');
      fetchAllIds.add('1');
      fetchAllUrls.add('https://www.archanaskitchen.com/images/archanaskitchen/1-Author/Anjana_Chaturvedi/Cabbage_and_carrot_sambharo.jpg');
      fetchAllNames.add('Masala Karela');
      fetchAllTexts.add('Basic');
      fetchAllBools.add('1');
      fetchAllIds.add('1');
      fetchAllUrls.add('https://www.archanaskitchen.com/images/archanaskitchen/1-Author/Anjana_Chaturvedi/Cabbage_and_carrot_sambharo.jpg');
      fetchAllNames.add('Masala Karela');
      fetchAllTexts.add(' ');
    print("hellllllllllllllllllllllooooooooooooo");
    print(fetchAllUrls.length);
    for (int i = 0; i < fetchAllUrls.length; i++) {
      List<String> ls = [];
      ls.add(fetchAllBools[i]);
      ls.add(fetchAllUrls[i]);
      ls.add(fetchAllNames[i]);
      ls.add(fetchAllIds[i]);
      ls.add(fetchAllTexts[i]);
      str.add(ls);
    }
    return str;
  }
}
