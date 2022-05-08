import 'package:flutter/material.dart';
import 'package:quiz_app/models/question.dart';
import 'custom_text.dart';

class PageQuizz extends StatefulWidget{
  @override
  _PageQuizzState createState() => _PageQuizzState();
}

class _PageQuizzState extends State<PageQuizz>{
    late Question question;
    List<Question> listeQuestions =[
      Question('La devise du Bénin est : Fraternité Justice Paix',false,'Au contraire c\'est : Fraternité Justice Travail','assets/egypte2.jpg'),
      Question("La lune va finir par tomber sur la terre à cause de la gravité",false,"C'est faux",'assets/egypte2.jpg'),
      Question("La Russie est plus grande en superficie que Pluton",true,"", 'assets/egypte2.jpg')
    ];
    int index=0;
    int score = 0;
    @override
    void initState() {
    super.initState();
    question=listeQuestions[index];
  }
  @override
  Widget build(BuildContext context) {
    double taille = MediaQuery.of(context).size.width * 0.75;
    return Scaffold(
      appBar: AppBar(
        title: CustomText("Le Quizz"),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomText("Question numero ${index+1}",color: Colors.grey[900],),
              CustomText("Score : $score / $index",color: Colors.grey[900],),
              Card(
                elevation: 10.0,
                child: Container(
                  width: taille,
                  height: taille,
                  child: Image.asset(
                      "${question.imagePath}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              CustomText(question.question,color: Colors.grey[900],factor: 1.3),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                    boutonBool(true),
                  boutonBool(false)
                ],
              )
            ],
          ),
      ),
    );
  }

  ElevatedButton boutonBool(bool b){
      return ElevatedButton(
          onPressed: (()=>dialogue(b)),
          child: CustomText((b) ? "Vrai" : "Faux",factor: 1.25,),
      );
  }

  Future<Null> dialogue(bool b) async{
    bool bonneReponse = (b == question.reponse);
    String vrai="assets/vrai.png";
    String faux="assets/faux.png";
    if (bonneReponse){
      score++;
    }
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return SimpleDialog(
            title: CustomText((bonneReponse) ? "C'est gagné !" : "Oups! Perdu...",factor: 1.4,color: (bonneReponse) ? Colors.green :Colors.red,),
            contentPadding: EdgeInsets.all(20.0),
            children: [
              Image.asset((bonneReponse) ? vrai:faux,fit: BoxFit.cover,),
              Container(height: 25.0,),
              CustomText( !(bonneReponse) ? question.explication : "",factor: 1.25,color: Colors.grey[900],),
              Container(height: 25.0,),
              ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context);
                    questionsuivante();
                  },
                  child: CustomText("Au suivant",color: Colors.grey[900],factor: 1.25,),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled))
                          return Colors.blue;
                        return null; // Defer to the widget's default.
                      }),
                ),
              ),
            ],
          );
        }
    );
  }
  void questionsuivante(){
    if (index < listeQuestions.length-1){
      index++;
      setState(() {
        question=listeQuestions[index];
      });
    }else{
      alerte();
    }
  }

  Future<Null> alerte() async{
      return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext buildcontext){
            return AlertDialog(
              title: CustomText("C'est fini !",color: Colors.blue,factor: 1.25,),
              contentPadding: EdgeInsets.all(10.0),
              content: CustomText("Votre score: $score / ${index+1}",color: Colors.grey[900],),
              actions: [
                TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.focused)) {
                            return Colors.red;
                          }
                          if (states.contains(MaterialState.hovered)) {
                            return Colors.green;
                          }
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.blue;
                          }
                          return null; // Defer to the widget's default.
                        }),
                  ),
                  onPressed: () {
                    Navigator.pop(buildcontext);
                    Navigator.pop(context);
                  },
                  child: CustomText("OK",factor: 1.25,color: Colors.blue,),
                )
              ],
            );
          }
      );
  }
}