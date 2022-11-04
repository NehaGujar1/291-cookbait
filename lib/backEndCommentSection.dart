import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FireBaseCollectionOfComments {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<void> addData(String? name, String? email, String? comment, String? recipeID, BuildContext context) async {
    bool didIUpdateTheCommentCollection = false;
    QuerySnapshot<Map<String, dynamic>> collectionOfDocuments =
    await FirebaseFirestore.instance.collection('comments').get();
    for (var element in collectionOfDocuments.docs) {
      if (element.id == recipeID) {
        Map<String?, dynamic> listOfFields = element.data();
        for (int i = 0; i < listOfFields.length; i++) {
          if (listOfFields[i.toString()][0] == email) {
            final documentToBeUpdated = FirebaseFirestore.instance.
            collection('comments').
            doc(recipeID);
            documentToBeUpdated.update({i.toString() : FieldValue.arrayUnion([comment])});
            didIUpdateTheCommentCollection = true;
          }
        }
        if (!didIUpdateTheCommentCollection) {
          List<String?> newArray = [email, name, comment];
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
      final newDocument = FirebaseFirestore.instance.
      collection('comments').
      doc(recipeID);
      final data = {'0' : newArray};
      newDocument.set(data);
      didIUpdateTheCommentCollection = true;
    }
    // This Alert message is not working so commented for now
    // if (didIUpdateTheCommentCollection) {
    //   showDialog(
    //       builder: (ctx) => AlertDialog(
    //         title: const Text('Alert'),
    //         content: const Text(
    //             'Comment Successfully added'),
    //         actions: <Widget>[
    //           TextButton(
    //               onPressed: () {
    //                 Navigator.of(ctx).pop();
    //               },
    //               child: Container(
    //                 color: Colors.green,
    //                 padding: const EdgeInsets.all(14),
    //                 child: const Text("Okay"),
    //               ))
    //         ],
    //       ), context: context);
    // }else {
    //   showDialog(
    //       builder: (ctx) => AlertDialog(
    //         title: const Text('Alert'),
    //         content: const Text(
    //             'Unknown error occurred. Try Again'),
    //         actions: <Widget>[
    //           TextButton(
    //               onPressed: () {
    //                 Navigator.of(ctx).pop();
    //               },
    //               child: Container(
    //                 color: Colors.green,
    //                 padding: const EdgeInsets.all(14),
    //                 child: const Text("Okay"),
    //               ))
    //         ],
    //       ), context: context);
    // }
  }
}