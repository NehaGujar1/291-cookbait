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
              margin:
                  const EdgeInsets.only(left: 0, bottom: 0, right: 0, top: 0),
              padding:
                  const EdgeInsets.only(left: 0, bottom: 0, right: 0, top: 0),
              child: SafeArea(
                bottom: false,
                child: GridView.builder(
                  padding: const EdgeInsets.only(
                      left: 0, bottom: 0, right: 0, top: 10),
                  itemCount: list!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20.0,
                      mainAxisSpacing: 20.0),
                  itemBuilder: (context, index) {
                    {
                      if (list[index][1] == 'text') {
                        return Container();
                      } else {
                        return InkWell(
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
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
                            width: 350,
                            color: Colors.red,
                            child: Column(
                              children: [
                                list[index][0] == '1'
                                    ? Container(
                                        color: Colors.white,
                                        height: 20,
                                        width: 183,
                                        child: Text(
                                          list[index][4],
                                          style: const TextStyle(
                                            fontFamily: 'arial',
                                            fontSize: 15,
                                            color:
                                                Color.fromARGB(255, 68, 62, 62),
                                          ),
                                        ),
                                        // width: 20,
                                      )
                                    : Container(
                                        color: Colors.white,
                                        height: 0,
                                      ),
                                const SizedBox(
                                  height: 10,
                                  width: 20,
                                ),
                                SizedBox(
                                  height: 130,
                                  width: 130,
                                  child: Image.network(list[index][1]),
                                ),
                                const SizedBox(
                                  height: 10,
                                  width: 20,
                                ),
                                Expanded(
                                  child: Text(
                                    list[index][2],
                                    style: const TextStyle(
                                        fontFamily: 'arial',
                                        fontSize: 10,
                                        color: Color.fromARGB(255, 68, 62, 62)),
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
