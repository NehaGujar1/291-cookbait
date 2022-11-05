import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'backEndIndividualRecipe.dart';
import 'frontEndCommentSection.dart';

Widget _buildHeading({String name = ' '}) {
  return Container(
    width: 300,
    //height: 40,
    clipBehavior: Clip.none,
    child: Text(
      name,
      style: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

Widget _buildNormalText({String name = ' '}) {
  return Text(
    name,
    style: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.black38,
    ),
  );
}

Widget _buildSubheadings({String name = ' '}) {
  return SizedBox(
    height: 40,
    child: Text(
      name,
      style: const TextStyle(
        fontSize: 20,
        color: Color(0xFFD80041),
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

List<String> all = [];

Widget _buildComments({required List<String> all}) {
  return Container(
    height: 300,
    clipBehavior: Clip.none,
    padding: const EdgeInsets.all(10),
    child: ListView.builder(
      //removed the null check with quickFix
      itemCount: ((all.length) / 2).floor(),
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              Text(
                all[index * 2 + 1],
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                //replaced with interpolation using quickFix
                '~${all[index * 2]}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black26,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}

class IndividualRecipe extends StatefulWidget {
  final String recipeID;

  const IndividualRecipe({Key? key, required this.recipeID}) : super(key: key);

  @override
  State<IndividualRecipe> createState() => _IndividualRecipeState();
}

class _IndividualRecipeState extends State<IndividualRecipe> {
  var firestoreDB =
      FirebaseFirestore.instance.collection("comments").snapshots();
  var recipeDB = FirebaseFirestore.instance.collection("recipes").snapshots();

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xFFF9F9F9),
        body: SingleChildScrollView(
          child: Card(
            child: Container(
              padding: const EdgeInsets.all(20),
              color: const Color(0xFFF9F9F9),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 60,
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.bottomLeft,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          alignment: Alignment.topLeft,
                          backgroundColor: const Color(0xFFD80041),
                          shape: RoundedRectangleBorder(
                              //to set border radius to button
                              borderRadius: BorderRadius.circular(32)),
                          textStyle: const TextStyle(color: Colors.white)),
                      onPressed: () => Navigator.pop(
                        context,
                      ),
                      child: const Icon(Icons.arrow_back_outlined),
                    ),
                  ),
                  FutureBuilder(
                    future: FirestoreRecipe().getData(widget.recipeID),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<String>?> snapshot) {
                      if (snapshot.connectionState == ConnectionState.none &&
                          !snapshot.hasData) {
                        return const Center(
                          child: Text('Error'),
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      List<String>? list = snapshot.data;
                      var n = 3;
                      n = int.parse(list![2]);
                      String ingredientsList = "";
                      for (int i = 3; i < n + 3; i++)
                      {
                        ingredientsList =
                            '$ingredientsList\n${i - 2}${list[i]}';
                      }
                      return SizedBox(
                        //height: 400,
                        child: Column(
                          children: <Widget>[
                            _buildHeading(name: list[0]),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: 300,
                              height: 300,
                              child: Image(
                                image: NetworkImage(list[1]),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            _buildSubheadings(name: 'Ingredients'),
                            _buildNormalText(name: ingredientsList),
                            const SizedBox(
                              height: 20,
                            ),
                            _buildSubheadings(name: 'Procedure'),
                            _buildNormalText(name: list[n + 3]),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Container(
                    width: 350,
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 350,
                          height: 40,
                          padding: const EdgeInsets.all(10),
                          color: const Color(0xFFD80041),
                          child: const Text(
                            'Comment Section',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              backgroundColor: Color(0xFFD80041),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        FutureBuilder(
                          future: FirestoreComments().getData(widget.recipeID),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<String>?> snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.none &&
                                !snapshot.hasData) {
                              //print("if condition");
                              return const Center(
                                child: Text('Error'),
                              );
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            List<String>? list = snapshot.data;
                            //print(list!.length);
                            return SizedBox(
                                child: Column(
                              children: <Widget>[
                                _buildComments(all: list!),
                              ],
                            ));
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 40,
                    width: 100,
                    alignment: Alignment.topLeft,
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.bottomLeft,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          alignment: Alignment.topLeft,
                          backgroundColor: const Color(0xFFD80041),
                          shape: RoundedRectangleBorder(
                              //to set border radius to button
                              borderRadius: BorderRadius.circular(32)),
                          textStyle: const TextStyle(color: Colors.white)),
                      //This onPressed function is subject to correction
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CommentSection(
                                  recipeID: widget.recipeID,
                                )),
                      ),
                      child: const Text("Add Comment"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
