import 'package:cloud_firestore/cloud_firestore.dart';

class FireBaseCollectionOfComments {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  // Future<List<String>> getData() async {
  //   QuerySnapshot<Map<String, dynamic>> qr =
  //   await FirebaseFirestore.instance.collection('comments').get();
  //   List<String> str=[];
  //   for (var element in qr.docs) {
  //     final m = element.data();
  //     str.add(m['data']);
  //   }
  //   return str;
  // }

  Future<void> addData(String? name, String? email, String? comment, String? recipeID) async {
    // await FirebaseFirestore.instance
    //     .collection('comments').doc('1001')
    //     .update({'Raiwat': 'hello2'});
    bool didIUpdateTheCommentCollection = false;
    QuerySnapshot<Map<String, dynamic>> collectionOfDocuments =
       await FirebaseFirestore.instance.collection('comments').get();
    for (var element in collectionOfDocuments.docs) {
      if (element.id == recipeID) {
        Map<String?, dynamic> listOfFields = element.data();
        for (int i = 0; i < listOfFields.length; i++) {
          //print(listOfFields[i.toString()][0]);
          if (listOfFields[i.toString()][0] == email) {
            // String? fuck = listOfFields[i.toString()].toString();
            // print(fuck);
            //final data = {i.toString() : comment};
            final documentToBeUpdated = FirebaseFirestore.instance.
            collection('comments').
            doc(recipeID);
            documentToBeUpdated.update({i.toString() : FieldValue.arrayUnion([comment])});
            didIUpdateTheCommentCollection = true;
          }
        }
        if (!didIUpdateTheCommentCollection) {
          List<String?> newArray = [email, name, comment];
          // listOfFields.update(listOfFields.length.toString(), (value) => newArray);
          // listOfFields[(listOfFields.length - 1).toString()].add(name);
          // listOfFields[(listOfFields.length - 1).toString()].add(comment);
          final documentToBeUpdated = FirebaseFirestore.instance.
          collection('comments').
          doc(recipeID);
          final data = {listOfFields.length.toString() : newArray};
          documentToBeUpdated.set(data, SetOptions(merge: true));
          didIUpdateTheCommentCollection = true;
        }
      }
    }
    if (!didIUpdateTheCommentCollection) {
      List<String?> newArray = [email, name, comment];
      // await FirebaseFirestore.instance.collection('comments').doc(recipeID).update({'0': newArray});
      final newDocument = FirebaseFirestore.instance.
      collection('comments').
      doc(recipeID);
      final data = {'0' : newArray};
      newDocument.set(data);
    }
  }
}