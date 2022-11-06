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
                      padding: EdgeInsets.only(
                          left: 0, bottom: 0, right: 0, top: 10),
                      itemCount: list!.length,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(

                          crossAxisCount: 2,
                          crossAxisSpacing: 20.0,
                          mainAxisSpacing: 20.0),
                      itemBuilder: (context, index) {
                        // resizeToAvoidBottomInset:
                        // true;

                        // if (list[index][1] == ">=90") {
                        //   return SizedBox(
                        //       height: 20, child: Text(list[index][0]));
                        // } else if (list[index][1] == ">=80") {
                        //   return SizedBox(
                        //       height: 20, child: Text(list[index][0]));
                        // } else if (list[index][1] == ">=70") {
                        //   return SizedBox(
                        //       height: 20, child: Text(list[index][0]));
                        // } else if (list[index][1] == ">=60") {
                        //   return SizedBox(
                        //       height: 20, child: Text(list[index][0]));
                        // } else if (list[index][2] == "Basic2") {
                        //   return SizedBox(height: 20, child: Text(''));
                        // } else if (list[index][2] == "Basic") {
                        //   return SizedBox(
                        //       height: 20,
                        //       child: Text('No matches! Suggestions:'));
                        // }
                        // // else if (list[index][0] == "text") {
                        // //   print('object');
                        // //   return Container(
                        // //     height: 100,
                        // //     width: 350,
                        // //   );
                        // // }
                        // else
                        {
                          return InkWell(
                              onTap: () {
                                String? incorrectRecipeID = list[index][3];
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
                                // height: 500,
                                width: 350,
                                color: Colors.red,
                                child: Column(
                                  children: [
                                    list[index][0]=='1' ?
                                    Container(
                                      color: Colors.white,
                                      child: Text(list[index][4],
                                        style: TextStyle(
                                            fontFamily: 'arial',
                                            fontSize: 15,
                                            color: Color.fromARGB(
                                                255, 68, 62, 62)),),
                                      height: 20,
                                      width:183,
                                      // width: 20,
                                    ):Container(
                                      color:Colors.white,
                                      height: 0,
                                    ),
                                    SizedBox(
                                      height: 10,
                                      width: 20,
                                    ),
                                    SizedBox(
                                      child: Image.network(list[index][1]),
                                      height: 130,
                                      width: 130,
                                      // color: Colors.red,
                                    ),
                                    SizedBox(
                                      height: 10,
                                      width: 20,
                                    ),
                                    Container(
                                      child: Expanded(
                                        child: Text(
                                          list[index][2],
                                          style: TextStyle(
                                              fontFamily: 'arial',
                                              fontSize: 10,
                                              color: Color.fromARGB(
                                                  255, 68, 62, 62)),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      //color: Colors.red,
                                    ),
                                  ],
                                ),
                              ));
                        } //else
                      })) //safe
          ); //container
        },
      ),
    );
  }
}
// class _ChoicesScreenState extends State<ChoicesScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("CookBait", textAlign: TextAlign.center),
//           backgroundColor: Colors.red,
//           elevation: 1.1,
//         ),
//         body: Builder(
//             // future: FirestoreDB().getData(widget.selectedIngredients),
//             builder: (BuildContext context) {
//           List<List<String>>? list =
//               FirestoreDB().getData2(widget.selectedIngredients);
//           return Container(
//               // color: Colors.red,
//               margin: EdgeInsets.only(left: 0, bottom: 0, right: 0, top: 0),
//               padding: EdgeInsets.only(left: 0, bottom: 0, right: 0, top: 0),
//               child: SafeArea(
//                   bottom: false,
//                   child: GridView.builder(
//                       // physics: const NeverScrollableScrollPhysics(),
//                       // shrinkWrap: true,
//                       padding: EdgeInsets.only(
//                           left: 0, bottom: 0, right: 0, top: 10),
//                       itemCount: list!.length,
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//
//                               crossAxisCount: 2,
//                               crossAxisSpacing: 20.0,
//                               mainAxisSpacing: 20.0),
//                       itemBuilder: (context, index) {
//                         // resizeToAvoidBottomInset:
//                         // true;
//
//                         // if (list[index][1] == ">=90") {
//                         //   return SizedBox(
//                         //       height: 20, child: Text(list[index][0]));
//                         // } else if (list[index][1] == ">=80") {
//                         //   return SizedBox(
//                         //       height: 20, child: Text(list[index][0]));
//                         // } else if (list[index][1] == ">=70") {
//                         //   return SizedBox(
//                         //       height: 20, child: Text(list[index][0]));
//                         // } else if (list[index][1] == ">=60") {
//                         //   return SizedBox(
//                         //       height: 20, child: Text(list[index][0]));
//                         // } else if (list[index][2] == "Basic2") {
//                         //   return SizedBox(height: 20, child: Text(''));
//                         // } else if (list[index][2] == "Basic") {
//                         //   return SizedBox(
//                         //       height: 20,
//                         //       child: Text('No matches! Suggestions:'));
//                         // }
//                         // // else if (list[index][0] == "text") {
//                         // //   print('object');
//                         // //   return Container(
//                         // //     height: 100,
//                         // //     width: 350,
//                         // //   );
//                         // // }
//                         // else
//                         {
//                           return InkWell(
//                               onTap: () {
//                                 String? incorrectRecipeID = list[index][3];
//                                 int recipeID = int.parse(incorrectRecipeID);
//                                 recipeID--;
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => IndividualRecipe(
//                                             recipeID: recipeID.toString())));
//                               },
//                               // style: InkWell.styleFrom(
//                               //   backgroundColor: Colors.red,
//
//                               // ignore: empty_statements
//                               // onTap: () {
//                               //     String? incorrectRecipeID = list[index][2];
//                               //     int recipeID = int.parse(incorrectRecipeID);
//                               //     recipeID--;
//                               //     Navigator.push(
//                               //         context,
//                               //         MaterialPageRoute(
//                               //             builder: (context) => IndividualRecipe(
//                               //                 recipeID: recipeID.toString())));
//                               //   },
//
//                               child: Container(
//                                 // height: 500,
//                                 width: 350,
//                                 color: Colors.red,
//                                 child: Column(
//                                   children: [
//                                     list[index][0]=='1' ?
//                                     Container(
//                                       color: Colors.white,
//                                       child: Text(list[index][4],
//                                             style: TextStyle(
//                                     fontFamily: 'arial',
//                                     fontSize: 15,
//                                     color: Color.fromARGB(
//                                         255, 68, 62, 62)),),
//                                       height: 20,
//                                       width:183,
//                                       // width: 20,
//                                     ):Container(
//                                       color:Colors.white,
//                                       height: 0,
//                                     ),
//                                     SizedBox(
//                                       height: 10,
//                                       width: 20,
//                                     ),
//                                     SizedBox(
//                                       child: Image.network(list[index][1]),
//                                       height: 130,
//                                       width: 130,
//                                       // color: Colors.red,
//                                     ),
//                                     SizedBox(
//                                       height: 10,
//                                       width: 20,
//                                     ),
//                                     Container(
//                                       child: Expanded(
//                                         child: Text(
//                                           list[index][2],
//                                           style: TextStyle(
//                                               fontFamily: 'arial',
//                                               fontSize: 10,
//                                               color: Color.fromARGB(
//                                                   255, 68, 62, 62)),
//                                           textAlign: TextAlign.center,
//                                         ),
//                                       ),
//                                       //color: Colors.red,
//                                     ),
//                                   ],
//                                 ),
//                               ));
//                         } //else
//                       })) //safe
//               ); //container
//         }));
//     //   AsyncSnapshot<List<List<String>>?> snapshot) {
//     // if (snapshot.connectionState == ConnectionState.none) {
//     //   return const Center(
//     //     child: Text('Error'),
//     //   );
//     // }
//     // if (snapshot.connectionState == ConnectionState.waiting) {
//     //   return const Center(
//     //     child: CircularProgressIndicator(),
//     //   );
//     // }
//   }
// }
