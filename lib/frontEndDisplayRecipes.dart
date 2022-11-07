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
        backgroundColor: const Color(0xFFD80041),
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
              margin:
                  const EdgeInsets.only(left: 0, bottom: 0, right: 0, top: 0),
              padding:
                  const EdgeInsets.only(left: 8, bottom: 0, right: 8, top: 0),
              child: SafeArea(
                bottom: false,
                child: GridView.builder(
                  padding: const EdgeInsets.only(
                      left: 16, bottom: 8, right: 16, top: 10),
                  itemCount: list!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio:0.75,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 16.0),
                  itemBuilder: (context, index) {
                    {
                      if (list[index][1] == 'text') {
                        return Container();
                      } else {
                        return InkWell(
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),

                          ),
                          onTap: () {
                            String? incorrectRecipeID = list[index][3];
                            int recipeID = int.parse(incorrectRecipeID);
                            recipeID--;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => IndividualRecipe(
                                  recipeID: recipeID.toString(),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 8.0,
                                    offset: Offset(6,6),
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),

                            child: Column(
                              children: [
                                list[index][0] == '1'
                                    ? Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                        ),
                                        height: 20,
                                        width: 170,
                                        child: Text(
                                          list[index][4],
                                          style: const TextStyle(
                                            fontFamily: 'Nunito',
                                            fontSize: 14,
                                            color:
                                                Color.fromARGB(255, 68, 62, 62),
                                          ),
                                        ),
                                        // width: 20,
                                      )
                                    : Container(
                                        color: Colors.white,
                                        height: 10,
                                      ),
                                /*const SizedBox(
                                  height: 10,
                                  width: 20,
                                ),*/
                                SizedBox(
                                  height: 100,
                                  width: 150,
                                  child: Image.network(list[index][1]),
                                ),
                                SizedBox(
                                  height: 10,
                                  width: 20,
                                ),
                                Expanded(
                                  child: Text(
                                    list[index][2],
                                    style: const TextStyle(
                                      fontFamily: 'Nunito',
                                      //FontWeight.bold(w400),
                                      fontSize: 14,
                                      color: Colors.black54,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    } //else
                  },
                ),
              ) //safe
              );
        },
      ),
    );
  }
}
