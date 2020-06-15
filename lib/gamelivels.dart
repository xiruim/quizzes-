import 'package:flutter/material.dart';
import 'package:quiz/dialog/previevwdialog_3.dart';
import 'package:quiz/dialog/previewdialog.dart';
import 'package:quiz/dialog/previewdialog_2.dart';
import 'package:quiz/dialog/previewdialog_4.dart';
import 'package:quiz/dialog/previewdialog_6.dart';
import 'package:quiz/levels/level1.dart';
import 'package:quiz/levels/livel6.dart';
import 'package:quiz/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameLivels extends StatefulWidget {
  @override
  _GameLivelsState createState() => _GameLivelsState();
}

class _GameLivelsState extends State<GameLivels> {
  //------переменные для ячеек-------
  int check;

  //--------Задаем ключи - Начало----------
  final _rowKey = GlobalKey<ScaffoldState>();
  //--------Задаем ключи - Конец----------

  //---------При входе на данную страничку обращаемся через данную функцию к функции проверки пройденных уровней; - Начало-------

  @override
  void initState() {
    super.initState();
    checkLevel();

  }
  //----------При входе на данную страничку обращаемся через данную функцию к функции проверки пройденных уровней; - Конец-------

  //---------Массив с Color типа ХЕШ-коллекции набор пар ключ-значение для цвета номеров уровней - Начало-------
   var massivColorLevel =
  {
    0: Colors.white,
    1: Colors.white,
    2: Colors.white,
    3: Colors.white,
    4: Colors.white,
    5: Colors.white,
    6: Colors.white,
    7: Colors.white,
    8: Colors.white,
    9: Colors.white,
    10: Colors.white,
    11: Colors.white,
    12: Colors.white,
    13: Colors.white,
    14: Colors.white,
    15: Colors.white,
    16: Colors.white,
    17: Colors.white,
    18: Colors.white,
    19: Colors.white,
    20: Colors.white,
    21: Colors.white,
    22: Colors.white,
    23: Colors.white,
    24: Colors.white,
    25: Colors.white,
    26: Colors.white,
    27: Colors.white,
    28: Colors.white,
    29: Colors.white,
  };
//---------Массив с Color типа ХЕШ-коллекции набор пар ключ-значение для цвета номеров уровней - Конец-------



  //---------Функция проверки пройденного уровня - Начало-------
  @override
  void checkLevel() async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    check=pref.getInt("Level_completed");//присваеваем переменной номер пройденного уровня
    check=6;//это если при отладке мы хотим поменять уровень игры
    if (check==0){check=1;}
    for(int i=0; i<=29; i++){
      if(i<check){
        setState(() {//применяем чтобы обновить виджет, без этого цвет цифр пройденных этапов не меняется
          massivColorLevel[i]=Colors.blue;
        });
      }
    }
    print("Пройденый уровень ");  print(check);
    print(massivColorLevel[check-1]);
  }
  //---------Функция проверки пройденного уровня - Конец-------


  //---Начало---Общий виджет кнопок с номером уровня-------
  Widget gameLevelButton(String text,massivColorLevel, nameScreen, int namberLevel){
    return InkWell(
      onTap: (){
        if (namberLevel<=check){
          Navigator.push(
              context, MaterialPageRoute(builder: (context)=> nameScreen));
        }else{
            _rowKey.currentState.showSnackBar(SnackBar(content:Text("Уровень закрыт")));
            print("открыт уровень ");  print(check);
            }


      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          boxShadow: [BoxShadow(
            blurRadius: 2.0
          )],
          borderRadius:
            BorderRadius.all(Radius.circular(10)),
          border: Border.all(width: 1, color: massivColorLevel),
        ),
        alignment: Alignment.center,
          margin: EdgeInsets.all(2),
        width: 58,
        height: 58,
        child: Text(
          text,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: massivColorLevel),
        ),
      ),
    );
  }
  //---Конец---Общий виджет кнопок с номером уровня-------


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _rowKey,
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
                            gameLevelButton("1",massivColorLevel[0], PreviewDialog(),1),
                            gameLevelButton("2",massivColorLevel[1], PreviewDialog_2(),2),
                            gameLevelButton("3",massivColorLevel[2], PreviewDialog_3(),3),
                            gameLevelButton("4",massivColorLevel[3], PreviewDialog_4(),4),
                            gameLevelButton("5",massivColorLevel[4], Level1(),5),
                          ]),

                      TableRow(
                          children: [
                            gameLevelButton("6",massivColorLevel[5], PreviewDialog_6(),6),
                            gameLevelButton("7",massivColorLevel[6], PreviewDialog_4(),7),
                            gameLevelButton("8",massivColorLevel[7], Level1(),8),
                            gameLevelButton("9",massivColorLevel[8], Level1(),9),
                            gameLevelButton("10",massivColorLevel[9], Level1(),10),
                          ]),
                      TableRow(
                          children: [
                            gameLevelButton("11",massivColorLevel[10], Level1(),11),
                            gameLevelButton("12",massivColorLevel[11], Level1(),12),
                            gameLevelButton("13",massivColorLevel[12], Level1(),13),
                            gameLevelButton("14",massivColorLevel[13], Level1(),14),
                            gameLevelButton("15",massivColorLevel[14], Level1(),15),
                          ]),
                      TableRow(
                          children: [
                            gameLevelButton("16",massivColorLevel[15], Level1(),16),
                            gameLevelButton("17",massivColorLevel[16], Level1(),17),
                            gameLevelButton("18",massivColorLevel[17], Level1(),18),
                            gameLevelButton("19",massivColorLevel[18], Level1(),19),
                            gameLevelButton("20",massivColorLevel[19], Level1(),20),
                          ]),
                      TableRow(
                          children: [
                            gameLevelButton("21",massivColorLevel[20], Level1(),21),
                            gameLevelButton("22",massivColorLevel[21], Level1(),22),
                            gameLevelButton("23",massivColorLevel[22], Level1(),23),
                            gameLevelButton("24",massivColorLevel[23], Level1(),24),
                            gameLevelButton("25",massivColorLevel[24], Level1(),25),
                          ]),
                      TableRow(
                          children: [
                            gameLevelButton("26",massivColorLevel[25], Level1(),26),
                            gameLevelButton("27",massivColorLevel[26], Level1(),27),
                            gameLevelButton("28",massivColorLevel[27], Level1(),28),
                            gameLevelButton("29",massivColorLevel[28], Level1(),29),
                            gameLevelButton("30",massivColorLevel[29], Level1(),30),
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
