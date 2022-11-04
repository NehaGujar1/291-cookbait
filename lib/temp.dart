import 'package:flutter/material.dart';

import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:cookbait/BackEndHomeScreen.dart';
import 'package:firebase_core/firebase_core.dart';





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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: FutureBuilder(
            future: FirestoreDB().getData(),
            builder: (BuildContext context, AsyncSnapshot<List<String?>?> snapshot) {
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
              // List<MultiSelectItem<dynamic>> list = snapshot.data!.cast<
              //     MultiSelectItem>();
              final items3 = ingredients
                  .map((ingredient) =>
                  MultiSelectItem<String?>(ingredient, ingredient!))
                  .toList();
              List<String?> selectedItems=[];
              return Column(
                children: [
                  MultiSelectBottomSheetField(
                      initialValue: const [],
                      title: const Text("Choose Your Ingredients"),
                      // backgroundColor: Colors.red,
                      searchable: true,
                      items: items3,
                      closeSearchIcon: const Icon(Icons.close),
                      separateSelectedItems: true,
                      onConfirm: (item) {
                        List<String?> str = [];
                        for(int i=0; i<item.length; i++) {
                          str.add(item[i].toString());
                        }
                        if(item.isNotEmpty) {
                          selectedItems.addAll(str);
                        }
                      },
                      onSelectionChanged: (items){
                        if(items.isNotEmpty) {
                          for(int i = 0; i < items.length; i++) {
                            selectedItems.remove(items[i]);
                          }}})
                ],
              );
            }),
      ),
    );
  }
}