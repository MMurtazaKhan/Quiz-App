import 'package:flutter/material.dart';
import 'package:quiz/quizBrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(MyApp());
}

List<Icon> icons = [];

QuizBrain questions = QuizBrain();

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void checkQuestion(bool ans) {
    bool correctans = questions.getAnswer();
    setState(() {
      if (questions.ifFinished() == true) {
        Alert(
                context: context,
                title: "Finished!",
                desc: "Questions have ended").show();
        questions.reset();
        icons = [];
      } else {
        if (ans == correctans) {
          setState(() {
            icons.add(Icon(
              Icons.check,
              color: Colors.green,
            ));
            questions.questionIncrement();
          });
        } else {
          setState(() {
            icons.add(Icon(
              Icons.close,
              color: Colors.red,
            ));
            questions.questionIncrement();
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Quiz App",style: TextStyle(fontSize: 30,fontFamily: 'Lobster'),)),backgroundColor: Colors.grey[800],
        ),
        body: Container(
          padding: EdgeInsets.only(top: 200),
          child: Column(
            children: [
              Expanded(child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(questions.getQuestion(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              )),
              SizedBox(
                height: 100,
              ),
              ElevatedButton(
                onPressed: () {
                  checkQuestion(true);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green[600],
                  minimumSize: Size(250,50)),
                child: Text("True",style: TextStyle(fontSize: 20,fontFamily: 'Lobster'),),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    checkQuestion(false);
                  },
                  style: ElevatedButton.styleFrom(minimumSize: Size(250,50),
                  primary: Colors.green[600],
                  ),
                  child: Text("False",style: TextStyle(fontSize: 20,fontFamily: 'Lobster'),)),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: icons,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
