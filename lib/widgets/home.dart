import 'package:flutter/material.dart';
import 'package:quiz_app/widgets/custom_text.dart';
import 'package:quiz_app/widgets/page_quizz.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Card(
              elevation: 10.0,
              child: Container(
                height: MediaQuery.of(context).size.width * 0.8,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Image.asset(
                  "assets/quizz.png",
                  fit: BoxFit.cover,
              ),
            )
            ),
            ElevatedButton(

              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled))
                        return Colors.blue;
                      return null; // Defer to the widget's default.
                    }),
                foregroundColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled))
                        return Colors.white;
                      return null; // Defer to the widget's default.
                    }),
              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                  return PageQuizz();
                }));
              },
              child: CustomText("Commencer le Quizz",factor: 1.5),
            )
          ],
        ),
      ),
    );
  }
}