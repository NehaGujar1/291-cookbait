import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'BackEndHomeScreen.dart';

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
        title: const Text("CookBait", textAlign: TextAlign.center),
        backgroundColor: Colors.red,
        elevation: 1.1,
      ),
      drawer: const Drawer(),
      body: FutureBuilder(
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
            List<MultiSelectItem<dynamic>> list =
                snapshot.data!.cast<MultiSelectItem>();
            final items3 = ingredients
                .map((ingredient) =>
                    MultiSelectItem<String>(ingredient, ingredient))
                .toList();
            List<dynamic> selectedItems = [];
            return Column(
              children: [
                MultiSelectBottomSheetField(
                    title: const Text("Choose Your Ingredients"),
                    // backgroundColor: Colors.red,
                    searchable: true,
                    items: items3,
                    closeSearchIcon: const Icon(Icons.close),
                    initialValue: const [],
                    onConfirm: (items4) {}),
                ElevatedButton(
                    onPressed: () {
                      Navigator
                    }, child: const Text('Find Recipes'))
              ],
            );
          }),
    );
  }
}
