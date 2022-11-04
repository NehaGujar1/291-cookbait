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
          return GridView.builder(
            // physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: list!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, crossAxisSpacing: 6.0, mainAxisSpacing: 6.0),
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
              } else if(list[index][2]=="Basic") {
                return const Text('Since no recipes match the ingredients list we are providing some basic recipes:');
              } else if (list[index][0] == "text") {
                return Container();
              } else {
                return ElevatedButton(
                    // ignore: empty_statements
                    onPressed: () {
                      String? incorrectRecipeID = list[index][2];
                      int recipeID = int.parse(incorrectRecipeID);
                      recipeID--;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => IndividualRecipe(
                                  recipeID: recipeID.toString())));
                    },
                    child: Column(
                      children: [
                        Image.network(list[index][0]),
                        Expanded(
                          child: Text(list[index][1]),
                        ),
                      ],
                    ));
              }
            },
          );
        },
      ),
    );
  }
}
