import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:cookbaitsample/Sorted_recipes.dart';
import 'firebase.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Recipe_firebase.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Individual_Recipe());
}


Widget _buildTextField({String Name = 'hg'}) {
  // new
  return Container(
//Type TextField
    width: 200,
    height: 100,
    color: Color(0xFFD80041),
    child: TextField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10.0),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      style: TextStyle(color: Colors.white),
    ),
  );
}

Widget _buildText({String Name = ' '}) {
  return Container(
    width: 300,
    //height: 40,
    clipBehavior: Clip.none,
    child: Text(
      Name,
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
Widget _buildNormalText({String Name = ' '}) {
  return Container(
    child: Text(
      Name,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.black38,
      ),
    ),
  );
}


Widget _buildSubheadings({String Name = ' '}) {
  return Container(
    height: 40,
    child: Text(
      Name,
      style: TextStyle(
        fontSize: 20,
        color: Color(0xFFD80041),
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
List<String> All=[];
/*Widget _buildComments({required List<String> All}){
  return Container(
    padding: EdgeInsets.all(20),
    child: Column(
      children: <Widget>
      [
        for(int i = 0;i<All.length/2;i++)
          {
            Text(
              All[1],
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              '~'+All[0],
              style: TextStyle(
                fontSize: 16,
                color: Colors.black26,
                fontWeight: FontWeight.w400,
              ),
            ),
          }
      ],
    ),
  );
}*/

Widget _buildComments({required List<String> All}){
  return Container(
      height:300,
      clipBehavior: Clip.none,
      padding: EdgeInsets.all(10),
      child: ListView.builder(
          itemCount: ((All!.length)/2).floor(),
          itemBuilder: (context, index) {
  return Container(
  padding: EdgeInsets.all(8),
  child: Column(
  children:<Widget>
  [
  Text(
  All[index*2+1],
  style: TextStyle(
  fontSize: 16,
  color: Colors.black54,
  fontWeight: FontWeight.w400,
  ),
  ),
  Text(
  '~'+All[index*2],
  style: TextStyle(
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

class Individual_Recipe extends StatefulWidget {
  @override
  Ind_recipe createState() => Ind_recipe();
}
class Ind_recipe extends State<Individual_Recipe>
{
  var firestoreDB = FirebaseFirestore.instance.collection("comments").snapshots();
  var RecipeDB = FirebaseFirestore.instance.collection("recipes").snapshots();
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Color(0xFFF9F9F9),
    body:
    SingleChildScrollView(
      child: Card(
      child: Container(
        padding: EdgeInsets.all(20),
        color: Color(0xFFF9F9F9),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 60,
            ),
            Container(
              height: 40,
              width: 40,
              alignment: Alignment.bottomLeft,
              child: ElevatedButton(
                child: Icon(Icons.arrow_back_outlined),
                style: ElevatedButton.styleFrom(
                    alignment: Alignment.topLeft,
                    primary: Color(0xFFD80041),
                    shape: RoundedRectangleBorder(
                      //to set border radius to button
                        borderRadius: BorderRadius.circular(32)),
                    textStyle: const TextStyle(color: Colors.white)),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Individual_Recipe()),
                ),
              ),
            ),
            /*
            _buildText(Name: 'Rava Masala Dosa'),

            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 300,
              height: 350,
              child: Image(
                image: NetworkImage(
                    'https://th.bing.com/th/id/OIP.yYNbPmLwg_kfrr9e9HmtFwHaHJ?pid=ImgDet&rs=1'),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            _buildSubheadings(Name:'Ingredients'),
            _buildNormalText( Name : 'Lorem ipsum dolor \n'
                  'sit amet,\n consectetur adipiscing elit, \n Mauris eget p\n'
                  'urus feugiat,'),

            SizedBox(
              height: 25,
            ),
            _buildSubheadings(Name:'Procedure'),
            _buildNormalText( Name : 'Lorem ipsum dolor '
                'sit amet, consectetur adipiscing elit. Mauris eget p'
                'urus feugiat,'),
            SizedBox(
              height: 20,
            ),*/
            FutureBuilder(
              future: FirestoreRecipe().getData(),

              builder: (BuildContext context, AsyncSnapshot<List<String>?> snapshot) {
                if (snapshot.connectionState == ConnectionState.none &&
                    !snapshot.hasData) {
                  return Center(
                    child: Text('Error'),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                List<String>? list = snapshot.data;
                print(list!.length);
                print(list?[0]);
                var n = 3;
                n = int.parse(list![2]);
                String Ings = "";
                print(list[0]);
                for(int i = 3; i<n+3;i++)
                {Ings = Ings + '\n'+(i-2).toString()+ list[i];}
                return
                  SizedBox(
                      //height: 400,
                      child: Container(
                      child: Column(
                      children : <Widget>[
                       _buildText(Name: list[0]),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                        width: 300,
                        height: 300,
                        child: Image(
                        image: NetworkImage(list[1]),
                         ),
                       ),
                         SizedBox(
                          height: 20,
                          ),
                          _buildSubheadings(Name:'Ingredients'),
                          _buildNormalText(Name: Ings),
                          SizedBox(
                            height: 20,
                          ),
                          _buildSubheadings(Name: 'Procedure'),
                          _buildNormalText(Name: list[n+3]),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                      ),
                     ),
                    );
              },
            ),

              Container(
              width: 350,
              color: Colors.white,
              child: Column(
                children:
                <Widget>[
                  Container(
                    width : 350,
                    height:40,
                    padding: EdgeInsets.all(10),

                    color: Color(0xFFD80041) ,
                    child: Text(
                      'Comment Section',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        backgroundColor: Color(0xFFD80041),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),

                  //_buildComments(Name: 'Nishita', Comment: 'Maine firse bana di'),
                 // _buildComments(Name:'Neha', Comment: 'Amazing recipe! I made it on my Mom’s b’day ... she just loved it!! :)'),
                  FutureBuilder(
                    future: FirestoreComments().getData(),
                    builder: (BuildContext context, AsyncSnapshot<List<String>?> snapshot) {
                      if (snapshot.connectionState == ConnectionState.none &&
                          !snapshot.hasData) {
                        print("if condition");
                        return Center(
                          child: Text('Error'),
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      List<String>? list = snapshot.data;
                      print(list!.length);
                      return
                        SizedBox(
                            child: Container(
                            child: Column(
                            children : <Widget>[
                              _buildComments(All: list),
                            ],
                            ),
                            )
                           /*height: 100,
                            child : ListView.builder(
                              itemCount: list!.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    _buildComments(Name:list[i]; Comment:list[i+1]);
                                    i = i+2;
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                  ),
                                );
                              },
                            ),*/
                        );
                    },
                    // child: Center(
                    //   child: ElevatedButton(
                    //     child: Text('Press'),
                    //     onPressed: () async {
                    //       print('start');
                    //       await FirestoreDB().addData();
                    //       print('done');
                    //     },
                    //   ),
                    //
                  ),
                  ],
                  ),
                 ),

            SizedBox(
              height: 30,
            ),
            Container(
              height: 40,
              width: 100,
              alignment: Alignment.topLeft,
              child: ElevatedButton(
                child: Text('Add Story'),
                style: ElevatedButton.styleFrom(
                    alignment: Alignment.topLeft,
                    primary: Color(0xFFD80041),
                    shape: RoundedRectangleBorder(
                      //to set border radius to button
                        borderRadius: BorderRadius.circular(32)),
                    textStyle: const TextStyle(color: Colors.white)),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Individual_Recipe()),
                ),
              ),
            ),

            Container(
              height: 40,
              width: 40,
              alignment: Alignment.bottomLeft,
              child: ElevatedButton(
                child: Icon(Icons.add_sharp),
                style: ElevatedButton.styleFrom(
                    alignment: Alignment.topLeft,
                    primary: Color(0xFFD80041),
                    shape: RoundedRectangleBorder(
                      //to set border radius to button
                        borderRadius: BorderRadius.circular(32)),
                    textStyle: const TextStyle(color: Colors.white)),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Individual_Recipe()),
                ),
              ),
            ),
          ],
        ),
      ),
        ),
      ),
  );

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

