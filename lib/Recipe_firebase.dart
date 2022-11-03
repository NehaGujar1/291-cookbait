import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreComments {
  int i = 0;
  int j = 0;
  int jl =1;//no of comments for a user
  int il = 1;//no of users
  String x = '0';
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<List<String>> getData() async {
    DocumentSnapshot<Map<String, dynamic>> qr =
    await FirebaseFirestore.instance.collection('comments').doc('1001').get();
    List<String> str = [];
    final m = qr.data();
     il = m!.length;
      while(i<il)
      {
        x = i.toString();
        jl = qr[x].length;
        for (int j = 2; j < jl; j = j + 1) {
          str.add(qr[x][1]);
          str.add(qr[x][j]);
        }
        i++;
      }
    return str;
  }
}

class FirestoreRecipe {
  //DocumentSnapshot<Map<String, dynamic>> qr;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<List<String>> getData() async {
    DocumentSnapshot<Map<String, dynamic>> qr =
    await FirebaseFirestore.instance.collection('recipes').doc('208').get();
    List<String> st = [];
    st.add(qr['Name']);
    st.add(qr['image-url']);
    int x = qr['Ingredients'].length;
    st.add(x.toString());
    for(int i = 0;i<x;i++)
      {
        st.add(qr['Ingredients'][i]);
      }
    st.add(qr['Recipe']);
    print(st[0]);
    return st;
  }
}



