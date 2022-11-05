import 'package:flutter/material.dart';
import 'backEndDisplayRecipes.dart';
import 'frontEndIndividualRecipe.dart';

class ChoicesScreen extends StatefulWidget {
  final List<String?> selectedIngredients;

  const ChoicesScreen({Key? key, required this.selectedIngredients})
      : super(key: key);

  @override
  State<ChoicesScreen> createState() => _ChoicesScreenState();
}

class _ChoicesScreenState extends State<ChoicesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CookBait", textAlign: TextAlign.center),
        backgroundColor: Colors.red,
        elevation: 1.1,
      ),
      body: FutureBuilder(
        future: FirestoreDB().getData(widget.selectedIngredients),
        builder: (BuildContext context,
            AsyncSnapshot<List<List<String>>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            return const Center(
              child: Text('Error'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          List<List<String>>? list = snapshot.data;
          return Container(
              // color: Colors.red,
              margin: EdgeInsets.only(left: 0, bottom: 0, right: 0, top: 0),
              padding: EdgeInsets.only(left: 0, bottom: 0, right: 0, top: 0),
              child: SafeArea(
                bottom: false,
                child: GridView.builder(
                  // physics: const NeverScrollableScrollPhysics(),
                  // shrinkWrap: true,
                  padding:
                      EdgeInsets.only(left: 0, bottom: 0, right: 0, top: 0),
                  itemCount: list!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      // crossAxisSpacing: 20.0,
                      mainAxisSpacing: 50.0
                      ),
                  itemBuilder: (context, index) {
                    // resizeToAvoidBottomInset:
                    // true;

                    if (list[index][1] == ">=90") {
                      return Text(list[index][0]);
                    } else if (list[index][1] == ">=80") {
                      return Text(list[index][0]);
                    } else if (list[index][1] == ">=70") {
                      return Text(list[index][0]);
                    } else if (list[index][1] == ">=60") {
                      return Text(list[index][0]);
                    } else if (list[index][2] == "Basic") {
                      return const Text(
                          'Since no recipes match the ingredients list we are providing some basic recipes:');
                    } else if (list[index][0] == "text") {
                      return Container();
                    } else {
                      return InkWell(
                          onTap: () {
                            String? incorrectRecipeID = list[index][2];
                            int recipeID = int.parse(incorrectRecipeID);
                            recipeID--;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => IndividualRecipe(
                                        recipeID: recipeID.toString())));
                          },
                          // style: InkWell.styleFrom(
                          //   backgroundColor: Colors.red,

                          // ignore: empty_statements
                          // onTap: () {
                          //     String? incorrectRecipeID = list[index][2];
                          //     int recipeID = int.parse(incorrectRecipeID);
                          //     recipeID--;
                          //     Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //             builder: (context) => IndividualRecipe(
                          //                 recipeID: recipeID.toString())));
                          //   },

                          child: Container(
                            height: 500,
                            width: 700,
                            color: Colors.red,
                            child: Column(
                              children: [
                                SizedBox(
                                  child: Image.network(list[index][0]),
                                  height: 225,
                                  width: 225,
                                  // color: Colors.red,
                                ),
                                SizedBox(
                                  height: 10,
                                  width: 20,
                                ),
                                Container(
                                  child: Expanded(
                                    child: Text(
                                      list[index][1],
                                      style: TextStyle(
                                          fontFamily: 'arial',
                                          fontSize: 18,
                                          color:
                                              Color.fromARGB(255, 68, 62, 62)),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  //color: Colors.red,
                                ),
                              ],
                            ),
                          ));
                    }
                  },
                ),
              ));
        },
      ),
    );
  }
}
