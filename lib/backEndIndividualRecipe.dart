import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreComments {
  int i = 0;
  int j = 0;
  int jl = 1; //no of comments for a user
  int il = 1; //no of users
  String x = '0';
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<bool> checkIfDocExists(String docId) async {
    try {
      var collectionRef =
          FirebaseFirestore.instance.collection('comments');

      var doc = await collectionRef.doc(docId).get();
      return doc.exists;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<String>> getData(String? recipeID) async {
    bool docExists = await checkIfDocExists(recipeID!);
    if (docExists) {
      DocumentSnapshot<Map<String, dynamic>> qr = await FirebaseFirestore
          .instance
          .collection('comments')
          .doc(recipeID)
          .get();
      List<String> str = [];
      final m = qr.data();
      il = m!.length;
      print(il);
      while (i < il) {
        x = i.toString();
        jl = qr[x].length;
        print(jl);
        for (int j = 2; j < jl; j = j + 1) {
          str.add(qr[x][1]);
          str.add(qr[x][j]);
        }
        i++;
      }
      return str;
    } else {
      return [" ", "Be the first one to Comment"];
    }
  }
}

class FirestoreRecipe {
  //DocumentSnapshot<Map<String, dynamic>> qr;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<String>> getData(String? recipeID) async {
    DocumentSnapshot<Map<String, dynamic>> qr = await FirebaseFirestore.instance
        .collection('recipes')
        .doc(recipeID)
        .get();
    List<String> st = [];
    st.add(qr['Name']);
    st.add(qr['image-url']);
    st.add(qr['Cuisine']);
    //print("Cuisine is added");
    int t = qr['TotalTimeInMins'];
    st.add(t.toString()+' Minutes');
    print("Total time is added");
    int x = qr['Ingredients'].length;
    st.add(x.toString());
    print("Number of ingredients");
    print(st[4]);
    for (int i = 0; i < x; i++) {
      st.add('. '+qr['Ingredients'][i]);
    }
    st.add(qr['Recipe']);
    //print(st[0]);
    return st;
  }
}
