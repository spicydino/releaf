import 'package:flutter/material.dart';
import 'package:releaf/Home_page.dart';
import 'package:releaf/Waste Management/wastePage.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar( 
          
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => WastePage()));
              },
              child: Text('Waste Management'),
            ),
            ],
        ),
    ),
    );
  }
}
