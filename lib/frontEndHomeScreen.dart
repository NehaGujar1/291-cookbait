import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import '../BackEndHomeScreen.dart';
import 'frontEndDisplayRecipes.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "CookBait",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.red,
        elevation: 1.1,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      // drawer: const Drawer(),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: FirestoreDB().getData(),
          builder:
              (BuildContext context, AsyncSnapshot<List<String>?> snapshot) {
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
            final items3 = ingredients
                .map(
                  (ingredient) =>
                      MultiSelectItem<String>(ingredient, ingredient),
                )
                .toList();
            List<String?> selectedItems = [];
            List<String?> selectedItemsForDebugging = [
              'tomato',
              'salt',
              'cumin powder jeera',
              'pepper pepper',
              'cloves garlic',
              'virgin olive oil',
              'onion',
              'dry beans such cannellini soya beans',
              'red chilli powder cayenne pepper',
              'dried oregano'
            ];
            return Column(
              children: [
                MultiSelectBottomSheetField(
                  buttonText: const Text('Select ingredients'),
                  initialValue: const [],
                  title: const Text("Choose Your Ingredients"),
                  // backgroundColor: Colors.red,
                  searchable: true,
                  items: items3,
                  closeSearchIcon: const Icon(Icons.close),
                  separateSelectedItems: true,
                  onConfirm: (item) {
                    List<String?> str = [];
                    for (int i = 0; i < item.length; i++) {
                      str.add(item[i].toString());
                    }
                    if (item.isNotEmpty) {
                      selectedItems.addAll(str);
                    }
                  },
                  onSelectionChanged: (items) {
                    if (items.isNotEmpty) {
                      for (int i = 0; i < items.length; i++) {
                        selectedItems.remove(items[i]);
                      }
                    }
                  },
                ),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      alignment: Alignment.topLeft,
                      backgroundColor: const Color(0xFFD80041),
                      shape: RoundedRectangleBorder(
                        //to set border radius to button
                        borderRadius: BorderRadius.circular(32),
                      ),
                      textStyle: const TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      if (selectedItems.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChoicesScreen(
                                selectedIngredients: selectedItemsForDebugging),
                          ),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text(
                              'Alert!',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                backgroundColor: Color(0xFFD80041),
                              ),
                            ),
                            content: const Text(
                                'Please select atleast one ingredient'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: Container(
                                  color: const Color(0xFFD80041),
                                  padding: const EdgeInsets.all(14),
                                  child: const Text(
                                    'Okay',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      }
                    },
                    child: const Text('Find Recipes!!'),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
