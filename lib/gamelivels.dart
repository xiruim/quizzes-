import 'package:flutter/material.dart';
import 'package:quiz/dialog/previewdialog.dart';
import 'package:quiz/levels/level1.dart';
import 'package:quiz/main.dart';

class GameLivels extends StatefulWidget {
  @override
  _GameLivelsState createState() => _GameLivelsState();
}

class _GameLivelsState extends State<GameLivels> {
  //------переменные для ячеек-------


  //---Начало---Общий виджет кнопок с номером уровня-------
  Widget gameLevelButton(String text, nameScreen){
    return InkWell(
      onTap: (){
        Navigator.push(
            context, MaterialPageRoute(builder: (context)=> nameScreen));

      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          boxShadow: [BoxShadow(
            blurRadius: 2.0
          )],
          borderRadius:
            BorderRadius.all(Radius.circular(10)),
          border: Border.all(width: 1, color: Colors.white),
        ),
        alignment: Alignment.center,
          margin: EdgeInsets.all(2),
        width: 58,
        height: 58,
        child: Text(
          text,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
  //---Конец---Общий виджет кнопок с номером уровня-------


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
           child: Stack(
            children: <Widget>[
              Positioned(
                child:Image.asset("assets/main_background.jpg"),
              ),
              Positioned(
                top: 80,
                left: 10,
                child: Container(
                  width: 120,
                  height: 50,
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: RaisedButton(
                    elevation: 0.0, //убераем тень
                    color: Colors.transparent,
                    child: Text(
                      "НАЗАД",
                      textScaleFactor: 1.5,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
                    },
                  ),
                ),
              ),
              Positioned(
                top: 150,
                child:Container(
                  width:  MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10),
                  child: Table(
                    children: <TableRow>[
                      TableRow(
                          children: [
                            gameLevelButton("1", PreviewDialog()),
                            gameLevelButton("2", Level1()),
                            gameLevelButton("3", Level1()),
                            gameLevelButton("4", Level1()),
                            gameLevelButton("5", Level1()),
                          ]),

                      TableRow(
                          children: [
                            gameLevelButton("6", Level1()),
                            gameLevelButton("7", Level1()),
                            gameLevelButton("8", Level1()),
                            gameLevelButton("9", Level1()),
                            gameLevelButton("10", Level1()),
                          ]),
                      TableRow(
                          children: [
                            gameLevelButton("11", Level1()),
                            gameLevelButton("12", Level1()),
                            gameLevelButton("13", Level1()),
                            gameLevelButton("14", Level1()),
                            gameLevelButton("15", Level1()),
                          ]),
                      TableRow(
                          children: [
                            gameLevelButton("16", Level1()),
                            gameLevelButton("17", Level1()),
                            gameLevelButton("18", Level1()),
                            gameLevelButton("19", Level1()),
                            gameLevelButton("20", Level1()),
                          ]),
                      TableRow(
                          children: [
                            gameLevelButton("21", Level1()),
                            gameLevelButton("22", Level1()),
                            gameLevelButton("23", Level1()),
                            gameLevelButton("24", Level1()),
                            gameLevelButton("25", Level1()),
                          ]),
                      TableRow(
                          children: [
                            gameLevelButton("26", Level1()),
                            gameLevelButton("27", Level1()),
                            gameLevelButton("28", Level1()),
                            gameLevelButton("29", Level1()),
                            gameLevelButton("30", Level1()),
                          ]),
                    ],
                  ),
                ),
              ),

            ],
          ),

      ),
    );
  }

}
