import 'dart:async';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:quiz/logika/logika_level1.dart';
import 'dart:core';

import '../gamelivels.dart';

class Level2 extends StatefulWidget {
  @override
  _Level2State createState() => _Level2State();
}
//---------------------------------------------------------------------------------------//
//--------Текстовые переменные - Начало-------
String nameLevelStr = "Уровень: ";
int nameLevelInt = 2;
String text = ""; //пустой текск в полосе пройденного времени
//--------Текстовые переменные - Конец--------

//--------Переменные для логики - Начало---------
int numRandom; //Переменная для генерации случайных чисел
bool mouse=true;//Переменная для видимости мышки
int proidenUroven;//Пройденный уровень

//Logika_Level1 logika_level1 = new Logika_Level1(); //Создали новый объект из класса Logika_Level1
Random random = new Random(); //Для генерации случайных чисел
int n = 0; //Учавствует в цикле из 20 задний
int nNagimaniya=0;//Кол-во нажатий
int correct_answer = 0; //Кол-во правильных ответов
bool correct_wrong = true; //правильно или непарвильно
bool isList = true; //логич перемен для активации дополнительных кнопок
int level_of_difficulty = 3; //уровень сложности игры (1, 2 или 3)
//--------Переменные для логики - Конец---------

//--------Переменные размещения на экране - Начало--------

double width_Polosa = 20; //Размер одной ячейки в общей полоске выполненых задний
double height_Polosa = 7; //Размер одной ячейки в общей полоске выполненых задний

double width_Button_Nazad = 120; //Размер кнопки НАЗАД
double height_Button_Nazad = 50; //Размер кнопки НАЗАД

double top_Dobavka = 30; //Добавка к основным величинам от верха экрана
double top_Button_Nazad = 80.0; //Начальное положение кнопки "НАЗАД" от верха экрана
double top_Level_text = 95; //Начальное положение кнопки "НАЗАД" от верха экрана
double top_Polosa = 140 + top_Dobavka; //Начальное положение полоски выполненных задний от верха экрана
double top_Contaner_Imags = 155 + top_Dobavka; //Начальное положение контейнера с картинками игры от верха экрана

double left_Button_Nazad = 10.0; //Начальное положение кнопки "НАЗАД" от левого края
double left_Level_text = 200; //Начальное положение кнопки "НАЗАД" от левого края
//--------Переменные размещения на экране - Конец--------

//========================================================================================================//
//=========Массив с картинками типа ХЕШ-коллекции набор пар ключ-значение - Начало-------
var _massivImageLevel2 = {
  0: Image.asset("assets/img_level2/norka_1.png"),
  1: Image.asset("assets/img_level2/mouse1.png"),
  2: Image.asset("assets/img_level2/norka_1_gok.png"),
};
//=========Массив с картинками типа ХЕШ-коллекции набор пар ключ-значение - Конец-------

//=========Массив с bool типа ХЕШ-коллекции набор пар ключ-значение для полосы пройденных вопросов - Начало-------
var massivBoolLevel1 = {
  0: true,
  1: true,
  2: true,
  3: true,
  4: true,
  5: true,
  6: true,
  7: true,
  8: true,
  9: true,
  10: true,
  11: true,
  12: true,
  13: true,
  14: true,
  15: true,
  16: true,
  17: true,
  18: true,
  19: true,
};
//=========Массив с bool типа ХЕШ-коллекции набор пар ключ-значение для полосы пройденных вопросов - Конец-------

//=========Массив с Color типа ХЕШ-коллекции набор пар ключ-значение для полосы пройденных вопросов - Начало-------
var massivColorLevel1 = {
  0: Colors.blueGrey,
  1: Colors.blueGrey,
  2: Colors.blueGrey,
  3: Colors.blueGrey,
  4: Colors.blueGrey,
  5: Colors.blueGrey,
  6: Colors.blueGrey,
  7: Colors.blueGrey,
  8: Colors.blueGrey,
  9: Colors.blueGrey,
  10: Colors.blueGrey,
  11: Colors.blueGrey,
  12: Colors.blueGrey,
  13: Colors.blueGrey,
  14: Colors.blueGrey,
  15: Colors.blueGrey,
  16: Colors.blueGrey,
  17: Colors.blueGrey,
  18: Colors.blueGrey,
  19: Colors.blueGrey,
};
//=========Массив с Color типа ХЕШ-коллекции набор пар ключ-значение для полосы пройденных вопросов - Конец-------





//########################################################################################//
//########Начало---Общий виджет полоса пройденных вопросов-------
Widget gameLevel(massivColorLevel1) {
  return Container(
    decoration: BoxDecoration(
      color: massivColorLevel1,
      boxShadow: [BoxShadow(blurRadius: 1.0)],
      borderRadius: BorderRadius.all(Radius.circular(2)),
      border: Border.all(width: 1, color: Colors.black12),
    ),
    alignment: Alignment.center,
    margin: EdgeInsets.all(1),
    width: width_Polosa,
    height: height_Polosa,
    child: Text(
      "",
      style: TextStyle(fontSize: 2, fontWeight: FontWeight.bold, color: Colors.white),
    ),
  );
}
//########Конец---Общий виджет полоса пройденных вопросов-------

//########Общий виджет строки с картинками норок - Начало-------
@override
Widget tableRow(
  massivImage, int numberNorki,
) {
  return InkWell(
    child: Container(
      width: 100,
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(width: 1, color: Colors.black12),
      ),
      child: massivImage, //через эту переменную сюда попадает картинкаа из массива
    ),
    //-------Логика проверки больше или меньше нажатая Норка - Начало---------------
    onTap: () {
      nNagimaniya++;
      if(numberNorki==numRandom){
        correct_answer = correct_answer + 1; //то добавляем единицу
        correct_wrong = true; //присаиваем правильно
        massivColorLevel1[n] = Colors.yellow; //присаиваем желтый - правильно
      } else {
        correct_wrong = false; //присаиваем неправильно
        massivColorLevel1[n] = Colors.red; //присаиваем красный - неправильно
      }
      print("Нажал, ");
      print("mouse= "); print(mouse);
      print("isList= "); print(mouse);
      print("n= "); print(n);

    },
    //-------Логика проверки больше или меньше нажатая Норка - Конец---------------
  );
}
//########Общий виджет строки с картинками норок- Конец-------

class _Level2State extends State<Level2> {
  //--------Задаем ключи - Начало----------
  final _rowKey = GlobalKey<ScaffoldState>();
  //--------Задаем ключи - Конец----------

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++//
//++++++++Функция генерации цифр от 0 до 9 - Начало-------
  void randomGenerator() {
    numRandom = random.nextInt(10); //Генерируем цифры от 0 до 9
  }
//++++++++Функция генерации цифр от 0 до 9 - Конец-------

//+++++++++++Функция При входе на данный уровень игры обращаемся через данную функцию к функции генерации случайных чисел randomLeftRight(); - Начало-------

  @override
  void initState() {
    super.initState();
    dischargeState();
    Timer(Duration(milliseconds: 50),(){
      time_function1();
    });

  }
//+++++++++++Функция При входе на данный уровень игры обращаемся через данную функцию к функции генерации случайных чисел randomLeftRight(); - Конец-------

//+++++++++++Функция сброса переменных при начале игры - Начало+++++++++++++
  @override
  void dischargeState() async{
    n = 0; //Учавствует в цикле из 20 задний
    nNagimaniya=0;//Кол-во нажатий
    correct_answer = 0; //Кол-во правильных ответов
    correct_wrong = true; //правильно или неправильно
    mouse=false;//при начале игры мышку не должно быть видно
    isList = true; //логич перемен для активации дополнительных кнопок
    SharedPreferences pref = await SharedPreferences.getInstance();
    proidenUroven=pref.getInt("Level_completed");//присваеваем переменной номер пройденного уровня
    for (int i = 0; i <= 19; i++) {
      massivColorLevel1[i] = Colors.blueGrey;
    }
  }
//+++++++++++Функция сброса переменных при начале игры - Конец+++++++++++++

//+++++++++++Функция сохранения пройденного уровня в памяти телефона - Начало----------------
  @override
  void saveInMemory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("Level_completed", nameLevelInt+1); //сохраняем пройденный уровень в памяти телефона
    print(nameLevelInt);
  }

//+++++++++++Функция сохранения пройденного уровня в памяти телефона - Конец----------------

  //++++++++Функция проверки сложности уровня - Начало-------
  @override
  void slognostLevel() async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    level_of_difficulty=pref.getInt("Uroven_slognosti");//присваеваем переменной уровень сложности

    print("Уровень сложности");  print(level_of_difficulty);

  }
  //++++++++Функция проверки сложности уровня - Конец-------

//+++++++++++Функция здержки времени  - Начало------
  Future time_function() async{
    if (n<20){
      setState(() {
        print("n ");print(n);
        Timer(Duration(seconds: 1),(){
          n=n+1;
          mouse=false;
          randomGenerator();
          time_function1();
        });
      });
    }
  }

  Future time_function1() async{
    setState(() {
      massivColorLevel1[n]=Colors.blue;
      if (n>=0 && massivColorLevel1[n-1]==Colors.blue){massivColorLevel1[n-1]=Colors.red;}
      if (n>=20){//если n>=20, значит игра закончена
        isList=false;//присваеваем ложь и выходят кнопки повторить или следующий уровень
        if((n-correct_answer)<=level_of_difficulty){//если уровень пройден
          _rowKey.currentState.showSnackBar(SnackBar(content: Text("Поздравляю!!! Уровень пройден. Вы поймали " + correct_answer.toString() + " мышек " + (n).toString())));
          saveInMemory();// вызывем функцию сохранения пройденного уровеня в памяти телефона
        }else{
          _rowKey.currentState.showSnackBar(SnackBar(content: Text("Уровень не пройден!!! Вы поймали только " + correct_answer.toString() + " мышек из " + (n).toString())));
        }
      }else{
        Timer(Duration(seconds: 2),(){
          mouse=true;
          time_function();
        });
      }

    });
  }

//+++++++++++Функция здержки времени  - Конец------



  //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _rowKey,
      body: Center(
        child: Stack(
          children: <Widget>[
            //-----------Фоновое изображение - Начало----------
            Positioned(
              child: Image.asset("assets/level1.jpg"),
            ),
            //-----------Фоновое изображение - Конец----------
            Positioned(
              //----------Кнопка назад - Начало--------------
              top: top_Button_Nazad,
              left: left_Button_Nazad,
              child: Container(
                width: width_Button_Nazad,
                height: height_Button_Nazad,
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
                    setState(() {
                      n=20;
                    });
                    Navigator.push(context, MaterialPageRoute(builder: (context) => GameLivels()));
                  },
                ),
              ),
              //----------Кнопка назад - Конец--------------
            ),
            Positioned(
              //------------Наименование Уровня игры - Начало------------
              top: top_Level_text,
              left: left_Level_text,
              child: Container(
                width: 155,
                padding: EdgeInsets.all(2),
                //color: Colors.blueGrey,
                child: Text(
                  nameLevelStr + nameLevelInt.toString(),
                  textScaleFactor: 1.5,
                  textAlign: TextAlign.right,
                  style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: Colors.cyan),
                ),
              ),
              //------------Наименование Уровня игры - Конец------------
            ),
            Positioned(
              //------------Полоса уровня - Начало---------------
              top: top_Polosa,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.all(0),
                child: Table(
                  children: <TableRow>[
                    TableRow(
                      children: [
                        gameLevel(massivColorLevel1[0]),
                        gameLevel(massivColorLevel1[1]),
                        gameLevel(massivColorLevel1[2]),
                        gameLevel(massivColorLevel1[3]),
                        gameLevel(massivColorLevel1[4]),
                        gameLevel(massivColorLevel1[5]),
                        gameLevel(massivColorLevel1[6]),
                        gameLevel(massivColorLevel1[7]),
                        gameLevel(massivColorLevel1[8]),
                        gameLevel(massivColorLevel1[9]),
                        gameLevel(massivColorLevel1[10]),
                        gameLevel(massivColorLevel1[11]),
                        gameLevel(massivColorLevel1[12]),
                        gameLevel(massivColorLevel1[13]),
                        gameLevel(massivColorLevel1[14]),
                        gameLevel(massivColorLevel1[15]),
                        gameLevel(massivColorLevel1[16]),
                        gameLevel(massivColorLevel1[17]),
                        gameLevel(massivColorLevel1[18]),
                        gameLevel(massivColorLevel1[19]),
                      ],
                    ),
                  ],
                ),
              ),
              //------------Полоса уровня - Конец---------------
            ),
            Positioned(
              //-----------Контейнер с катринками - Начало---------------
              top: top_Contaner_Imags,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(2),
                margin: EdgeInsets.all(0),
                child: mouse ?
                Table(
                  children: <TableRow>[
                    TableRow(
                      children: [
                        tableRow((numRandom==0) ?_massivImageLevel2[1]:_massivImageLevel2[0],0),
                        tableRow((numRandom==1) ?_massivImageLevel2[1]:_massivImageLevel2[0],1),
                        tableRow(_massivImageLevel2[2],11),
                        tableRow((numRandom==2) ?_massivImageLevel2[1]:_massivImageLevel2[0],2),
                        tableRow(_massivImageLevel2[2],11),
                      ],
                    ),
                    TableRow(
                      children: [
                        tableRow(_massivImageLevel2[2],11),
                        tableRow(_massivImageLevel2[2],11),
                        tableRow((numRandom==3) ?_massivImageLevel2[1]:_massivImageLevel2[0],3),
                        tableRow((numRandom==4) ?_massivImageLevel2[1]:_massivImageLevel2[0],4),
                        tableRow(_massivImageLevel2[2],11),
                      ],
                    ),
                    TableRow(
                      children: [
                        tableRow((numRandom==5) ?_massivImageLevel2[1]:_massivImageLevel2[0],5),
                        tableRow(_massivImageLevel2[2],11),
                        tableRow(_massivImageLevel2[2],11),
                        tableRow((numRandom==6) ?_massivImageLevel2[1]:_massivImageLevel2[0],6),
                        tableRow((numRandom==7) ?_massivImageLevel2[1]:_massivImageLevel2[0],7),
                      ],
                    ),
                    TableRow(
                      children: [
                        tableRow(_massivImageLevel2[2],11),
                        tableRow((numRandom==8) ?_massivImageLevel2[1]:_massivImageLevel2[0],8),
                        tableRow(_massivImageLevel2[2],11),
                        tableRow((numRandom==9) ?_massivImageLevel2[1]:_massivImageLevel2[0],9),
                        tableRow(_massivImageLevel2[2],11),
                      ],
                    ),
                  ],
                ):
                Table(
                  children: <TableRow>[
                    TableRow(
                      children: [
                        tableRow(_massivImageLevel2[0],11),
                        tableRow(_massivImageLevel2[0],11),
                        tableRow(_massivImageLevel2[2],11),
                        tableRow(_massivImageLevel2[0],11),
                        tableRow(_massivImageLevel2[2],11),
                      ],
                    ),
                    TableRow(
                      children: [
                        tableRow(_massivImageLevel2[2],11),
                        tableRow(_massivImageLevel2[2],11),
                        tableRow(_massivImageLevel2[0],11),
                        tableRow(_massivImageLevel2[0],11),
                        tableRow(_massivImageLevel2[2],11),
                      ],
                    ),
                    TableRow(
                      children: [
                        tableRow(_massivImageLevel2[0],11),
                        tableRow(_massivImageLevel2[2],11),
                        tableRow(_massivImageLevel2[2],11),
                        tableRow(_massivImageLevel2[0],11),
                        tableRow(_massivImageLevel2[0],11),
                      ],
                    ),
                    TableRow(
                      children: [
                        tableRow(_massivImageLevel2[2],11),
                        tableRow(_massivImageLevel2[0],11),
                        tableRow(_massivImageLevel2[2],11),
                        tableRow(_massivImageLevel2[0],11),
                        tableRow(_massivImageLevel2[2],11),
                      ],
                    ),
                  ],
                ),
              ),
              //-----------Контейнер с катринками - Конец---------------
            ),
            isList
                ? Positioned(
                    top: top_Contaner_Imags + 300,
                    //-----------Контейнер с текстом под картинками - Начало---------------
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(2),
                      margin: EdgeInsets.all(0),
                      child: Table(
                        children: <TableRow>[
                          TableRow(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.all(5),
                                margin: EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  //border: Border.all(width: 1, color: Colors.black12),
                                ),
                                child: Text(
                                  n.toString(),
                                  textScaleFactor: 1.5,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: Colors.white),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.all(5),
                                margin: EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  //border: Border.all(width: 1, color: Colors.black12),
                                ),
                                child: Text(
                                  massivColorLevel1[n-1]==Colors.yellow ?"Поймал": "Не поймал",
                                  textScaleFactor: 1.5,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: massivColorLevel1[n-1]==Colors.yellow ?Colors.white:Colors.red),
                                ),
                              ),
                              //-----------Контейнер с текстом под картинками - Конец---------------
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                : Positioned(
                    top: top_Contaner_Imags + 300,
                    //-----------Появляющийся Контейнер с окончнием игры - Начало---------------
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(0.2),
                      margin: EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Table(
                        children: <TableRow>[
                          TableRow(
                            children: [
                              Container(
                                //--------Кнопка "Повторить" - Начало--------------
                                width: width_Button_Nazad,
                                height: height_Button_Nazad,
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
                                    "Повторить",
                                    textScaleFactor: 1.0,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: Colors.white),
                                  ),
                                  onPressed: () {
                                    dischargeState(); //вызываем функцию сброса данных для логики
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Level2()));
                                  },
                                ),
                                //--------Кнопка "Повторить" - Конец--------------
                              ),
                              Container(
                                //--------Кнопка "Следующий уровень" - Начало--------------
                                width: width_Button_Nazad,
                                height: height_Button_Nazad,
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
                                child: proidenUroven==nameLevelInt ?
                                RaisedButton(
                                  elevation: 0.0, //убераем тень
                                  color: Colors.transparent,
                                  child: Text(
                                    "Следующий уровень",
                                    textScaleFactor: 1.0,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: Colors.white),
                                  ),
                                  onPressed: () {
                                    dischargeState(); //вызываем функцию сброса данных для логики
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => GameLivels()));
                                  },
                                ):
                                RaisedButton(
                                  elevation: 0.0, //убераем тень
                                  color: Colors.transparent,
                                  child: Text(
                                    "Уровень не пройден",
                                    textScaleFactor: 1.0,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: Colors.red),
                                  ),
                                  onPressed: () {
                                    dischargeState(); //вызываем функцию сброса данных для логики
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Level2()));
                                  },
                                ),
                                //--------Кнопка "Следующий уровень" - Конец--------------
                              ),
                              //-----------Появляющийся Контейнер с окончнием игры - Конец---------------
                            ],
                          ),
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
