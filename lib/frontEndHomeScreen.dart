import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import '../BackEndHomeScreen.dart';
import 'frontEndDisplayRecipes.dart';
import 'fruits.dart';

final _items = fruits
    .map((fruit) => MultiSelectItem<Fruits>(fruit, fruit.name))
    .toList();
List<Fruits> _selectedVegetables = [];
final _multiSelectKey = GlobalKey<FormFieldState>();
List<String?> selectedItems = [];
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
        title: const Text("CookBait", textAlign: TextAlign.center, style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, )),
        backgroundColor: Colors.red,
        elevation: 1.1,
      ),
      body: Column(
          children: [
            SingleChildScrollView(
              child: MultiSelectBottomSheetField(
                buttonText: Text("Select Ingredients", style: TextStyle(color: Colors.black),),
                  initialValue: const [],
                  title: const Text("Choose Your Ingredients"),
                  // backgroundColor: Colors.red,
                  searchable: true,
                  items: _items,
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
                  }),
            ),

          ],
        ),
      bottomNavigationBar: SizedBox(
        width: 100.0,
        child: ElevatedButton(
            style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.red)),
            onPressed: () {
              if (selectedItems.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChoicesScreen(
                          selectedIngredients:
                          selectedItems)),
                );
              } else {
                showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Alert'),
                      content: const Text(
                          'Please select atleast one Ingredient'),
                      actions: <Widget>[
                        TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                            child: Container(
                              color: Colors.green,
                              padding: const EdgeInsets.all(14),
                              child: const Text("Okay"),
                            ))
                      ],
                    ));
              }
            },
            child: const Text('Find Recipes!!')

        ),
      ),
    );
  }
}