import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:quiz/logika/my_bloc.dart';
import 'package:quiz/logika/my_event.dart';
import 'package:quiz/logika/my_model.dart';
import 'package:quiz/logika/save_uroven_in_memoru.dart';
import 'package:flutter/material.dart';
import 'package:quiz/logika/logika_level1.dart';
import 'dart:core';
import '../gamelivels.dart';


class Level4 extends StatefulWidget {
  static My_Model my_model = new My_Model(); //Вызываем модель

  @override
  _Level4State createState() => _Level4State();


}

Logika_Level1 _logika_level1 = Logika_Level1(); //Вызываем логику

//--------Текстовые переменные - Начало-------
String nameLevelStr = "Уровень: ";
int nameLevelInt = 4;
String text = ""; //пустой текск в полосе пройденных вопросов
TextEditingController contSumma = TextEditingController(); //контроллер хранения суммы вводимой игроком
String stringSumma = " "; //для последующего преобразования из текстового контроллера в int
//--------Текстовые переменные - Конец--------

//--------Переменные для логики - Начало---------
int numLeft=0; //Переменная для левой картинки
int numRight=0; //Переменная для правой картинки
int intSummaLR;
int intSummaParse;
//Logika_Level1 logika_level1 = new Logika_Level1(); //Создали новый объект из класса Logika_Level1
Random random = new Random(); //Для генерации случайных чисел
int n = 0; //Учавствует в цикле из 20 задний
int correct_answer = 0; //Кол-во правильных ответов
bool correct_wrong = true; //правильно или непарвильно
bool isList = true; //логич перемен для активации дополнительных кнопок
bool stopTimer = true; //логич перемен для счетчика времени
bool bool_smile = true; // - для показа разных смайликов
int level_of_difficulty; //уровень сложности игры (1, 2 или 3)
int timeGame = 0; //переменная для посчета времени игры
int timeWaitSlognost = 10; //переменная для задания отсчета обратного времени
int timeWait = timeWaitSlognost; //переменная для отсчета обратного времени
int chet_nechet = 0; //для определения четное не четное

//--------Переменные для логики - Конец---------

//--------Переменные с картинками-------
String first_img = "assets/main_img_smail.png";
String fon_img = "assets/level1.jpg";
String img_smail_tru = "assets/img_smile/good _smail.png";
String img_smail_false = "assets/img_smile/question_smail.png";
String img_smail_wait1 = "assets/img_smile/repeat_smail.png";
String img_smail_wait2 = "assets/img_smile/repeat2_smail.png";

//--------Переменные размещения на экране - Начало--------

double width_Polosa = 20; //Размер одной ячейки в общей полоске выполненых задний
double height_Polosa = 7; //Размер одной ячейки в общей полоске выполненых задний

double width_Button_Nazad = 120; //Размер одной ячейки в общей полоске выполненых задний
double height_Button_Nazad = 50; //Размер одной ячейки в общей полоске выполненых задний

double top_Dobavka = 30; //Добавка к основным величинам от верха экрана
double top_Button_Nazad = 80.0; //Начальное положение кнопки "НАЗАД" от верха экрана
double top_Level_text = 95; //Начальное положение кнопки "НАЗАД" от верха экрана
double top_Polosa = 140 + top_Dobavka; //Начальное положение полоски выполненных задний от верха экрана
double top_Contaner_Imags = 155 + top_Dobavka; //Начальное положение контейнера с картинками игры от верха экрана

double left_Button_Nazad = 10.0; //Начальное положение кнопки "НАЗАД" от левого края
double left_Level_text = 200; //Начальное положение кнопки "НАЗАД" от левого края
//--------Переменные размещения на экране - Конец--------

//---------Массив с картинками типа ХЕШ-коллекции набор пар ключ-значение - Начало-------
var _massivImageLevel1 = {
  0: Image.asset("assets/img_level1/level1_0.png"),
  1: Image.asset("assets/img_level1/level1_1.png"),
  2: Image.asset("assets/img_level1/level1_2.png"),
  3: Image.asset("assets/img_level1/level1_3.png"),
  4: Image.asset("assets/img_level1/level1_4.png"),
  5: Image.asset("assets/img_level1/level1_5.png"),
  6: Image.asset("assets/img_level1/level1_6.png"),
  7: Image.asset("assets/img_level1/level1_7.png"),
  8: Image.asset("assets/img_level1/level1_8.png"),
  9: Image.asset("assets/img_level1/level1_9.png"),
};
//---------Массив с картинками типа ХЕШ-коллекции набор пар ключ-значение - Конец-------

//---------Массив с Текстом типа ХЕШ-коллекции набор пар ключ-значение - Начало-------
var _massivTextLevel1 = {
  0: "Ноль",
  1: "Один",
  2: "Два",
  3: "Три",
  4: "Четыре",
  5: "Пять",
  6: "Шесть",
  7: "Семь",
  8: "Восемь",
  9: "Девять",
};
//---------Массив с Текстом типа ХЕШ-коллекции набор пар ключ-значение - Конец-------

//---------Массив с bool типа ХЕШ-коллекции набор пар ключ-значение для полосы пройденных вопросов - Начало-------
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
//---------Массив с bool типа ХЕШ-коллекции набор пар ключ-значение для полосы пройденных вопросов - Конец-------

//---------Массив с Color типа ХЕШ-коллекции набор пар ключ-значение для полосы пройденных вопросов - Начало-------
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
//---------Массив с Color типа ХЕШ-коллекции набор пар ключ-значение для полосы пройденных вопросов - Конец-------

////--------Функция генерации цифр от 0 до 9 - Начало-------
//void randomLeftRight() {
//  numLeft = random.nextInt(10); //Генерируем цифры от 0 до 9
//  numRight = random.nextInt(10); //Генерируем цифры от 0 до 9
////  if (numLeft == numRight) {
////    randomLeftRight();
////  }
//}
////--------Функция генерации цифр от 0 до 9 - Конец-------

//---Начало---Общий виджет полоса пройденных вопросов-------
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
//---Конец---Общий виджет полоса пройденных вопросов-------

class _Level4State extends State<Level4> {
  MyBloc _myBloc;
  SaveUrovenInMemoru _saveUrovenInMemoru = SaveUrovenInMemoru(); // Вызываем класс записи в память
//  TaimProstoiStop _taimProstoiStop=TaimProstoiStop();//Вызываем класс Таймера простоя времени

  //--------Задаем ключи - Начало----------
  final _rowKey = GlobalKey<ScaffoldState>();
  //--------Задаем ключи - Конец----------




  //---------При входе на данный уровень игры обращаемся через данную функцию к функции генерации случайных чисел randomLeftRight(); - Начало-------

  @override
  void initState() {
    potok();
    _saveUrovenInMemoru.slognostLevel(level_of_difficulty);
    time_function();

//    super.initState();
  }
  //---------При входе на данный уровень игры обращаемся через данную функцию к функции генерации случайных чисел randomLeftRight(); - Конец-------

  //---------Для закрытия потока - Начало-------
  @override
  void dispose() {
    streamSubscription?.cancel(); //Вроде как закрываем поток
    super.dispose();
  }
  //---------Для закрытия потока - Конец-------
  //---------Проверка потока - Начало-------
  StreamSubscription streamSubscription; //Вызываем поток
  @override
  void potok() {

    Level4.my_model.randomLeft();
    Level4.my_model.randomRight();
    streamSubscription = Level4.my_model.randomLeftUpdate.listen((newNumLeft) => setState(() {
      numLeft = newNumLeft;
      print("numLeft=${numLeft}"); //проверка
    }));
    streamSubscription = Level4.my_model.randomRightUpdate.listen((newNumRight) => setState(() {
      numRight = newNumRight;
    }));
    print("numLeft=${numLeft}"); //проверка

  }
  //---------Проверка потока - Конец-------

//  //---------Функция проверки сложности уровня - Начало-------
//  @override
//  void slognostLevel() async {
//    SharedPreferences pref = await SharedPreferences.getInstance();
//    level_of_difficulty = pref.getInt("Uroven_slognosti"); //присваеваем переменной уровень сложности
//
//    print("Уровень сложности");
//    print(level_of_difficulty);
//  }
//  //---------Функция проверки сложности уровня - Конец-------

  //---------Сброс всех значений на начальные; - Начало-------

  @override
  void dischargeState() {

    n = 0; //Учавствует в цикле из 20 задний
    correct_answer = 0; //Кол-во правильных ответов
    correct_wrong = true; //правильно или неправильно
    isList = true; //логич перемен для активации дополнительных кнопок
    stringSumma = "";
    timeGame = 0;
    timeWait = timeWaitSlognost;
    for (int i = 0; i <= 19; i++) {
      massivColorLevel1[i] = Colors.blueGrey;
    }

  }
  //---------Сброс всех значений на начальные; - Конец-------

//  //---------Функция сохранения пройденного уровня в памяти телефона - Начало----------------
//  @override
//  void saveInMemory() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    await prefs.setInt("Level_completed", nameLevelInt + 1); //открываем следующий уровень и сохраняем в памяти телефона
//    print("nameLevelInt ");
//    print(nameLevelInt);
//  }
//  //---------Функция сохранения пройденного уровня в памяти телефона - Конец----------------

  //-----Общий виджет кнопок с цифрами ответа ---- Начало---
  Widget numButton(String text, Function onPress) {
    return InkWell(
      onTap: () {
        setState(() {
          onPress();
        });
      },
      child: Container(
        width: 40,
        height: 50,
        padding: EdgeInsets.all(2),
        margin: EdgeInsets.all(2),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Text(
          text,
          textScaleFactor: 1.5,
          style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: Colors.white),
        ),
      ),
    );
  }

//-----Общий виджет кнопок с цифрами ответа ---- Конец---

//--------Функция при нажатии цифр для получения ответа - Начало-------
  void addSymbol(symbol) {
    setState(() {
      if (stringSumma == "") {
        stringSumma = symbol;
      } else {
        stringSumma += symbol;
      }
    });
  }

//--------Функция при нажатии цифр для получения ответа - Конец-------

  //+++++++++++Функция подсчет времени простоя игры  - Начало------
  Future time_function() async {
    setState(() {
      Timer(Duration(milliseconds: 1000), () {
        timeGame = timeGame + 1;
        if (timeGame > 3) {
          bool_smile = true;
        } else {
          bool_smile = false;
        }
        if (timeWait <= 0) {
          isList = false;
          print("STOP GAME, isList=${isList} ");
        } else {
          time_function();
        }
        chet_nechet = timeGame % 2;
        timeWait = timeWait - 1;
      });
      if (n == 20 || timeWait <= 0) {
        isList = false;
        FocusScope.of(context).requestFocus(new FocusNode());
        if ((n - correct_answer) <= level_of_difficulty) {
          //если уровень пройден
          _rowKey.currentState.showSnackBar(SnackBar(content: Text("Поздравляю!!! Уровень пройден. Вы правильно ответили на " + correct_answer.toString() + " вопросов из " + (n).toString())));
          _saveUrovenInMemoru.saveInMemory(nameLevelInt); // вызывем функцию сохранения пройденного уровеня в памяти телефона
        } else {
          _rowKey.currentState.showSnackBar(SnackBar(content: Text("Уровень не пройден!!! Вы правильно ответили только на " + correct_answer.toString() + " вопросов из " + (n).toString())));
        }
      }

      if (stopTimer == true) {
        print("timeGame=${timeGame}, stopTimer=${stopTimer}, timeWait=${timeWait}, isList=${isList} ");
      }
    });
  }

//+++++++++++Функция подсчет времени простоя игры - Конец------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _rowKey,
      body: Center(
        child: Stack(
          children: <Widget>[
            //-----------Фоновое изображение - Начало----------
            Positioned(
              child: Image.asset(fon_img),
            ),
            //-----------Фоновое изображение - Конец----------
            Positioned(
              //-------Смайлик ----- Начало--
              top: top_Button_Nazad - 70,
              left: left_Button_Nazad + 70,
              child: bool_smile
                  ?
                  //------Смайлик ожидания - Начало---
                  Container(
                      width: 200,
                      height: 200,
                      child: chet_nechet == 0
                          ? Image.asset(
                              img_smail_wait1,
                            )
                          : Image.asset(img_smail_wait2),
                    )
                  :
                  //------Смайлик ожидания - Конец---

                  //------Смайлик правильного или не правильного ответа - Начало---
                  Container(
                      width: 200,
                      height: 200,
                      child: correct_wrong
                          ? Image.asset(
                              img_smail_tru,
                            )
                          : Image.asset(img_smail_false),
                    ),
              //------Смайлик правильного или не правильного ответа - Начало---
              //-------Смайлик ----- Конец--
            ),
            Positioned(
              //----------Кнопка назад - Начало--------------
              top: top_Button_Nazad,
              left: left_Button_Nazad,
              child: Container(
                padding: EdgeInsets.all(2),
                margin: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: RaisedButton(
                  elevation: 0.0, //убераем тень
                  color: Colors.transparent,
                  child: Icon(
                    Icons.backspace,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    dischargeState();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => GameLivels()));
                  },
                ),
              ),
              //----------Кнопка назад - Конец--------------
            ),
            Positioned(
              //------------Наименование Уровня игры и времени обратного отсчета - Начало------------
              top: top_Level_text,
              left: left_Level_text,
              child: Column(
                children: <Widget>[
                  Container(
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
                  Container(
                    width: 155,
                    padding: EdgeInsets.all(2),
                    //color: Colors.blueGrey,
                    child: Text(
                      timeWait.toString(),
                      textScaleFactor: 1.5,
                      textAlign: TextAlign.right,
                      style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: Colors.cyan),
                    ),
                  ),
                ],
              ),
              //------------Наименование Уровня игры и времени обратного отсчета - Конец------------
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
              //-----------Контейнер с картинками - Начало---------------
              top: top_Contaner_Imags,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(2),
                margin: EdgeInsets.all(0),
                child: Table(
                  children: <TableRow>[
                    TableRow(
                      children: [
                        Container(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              border: Border.all(width: 1, color: Colors.black12),
                            ),
                            child: _massivImageLevel1[numLeft], //Генерирует из массива левую картинку
                          ),
                        ),
                        Container(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              border: Border.all(width: 1, color: Colors.black12),
                            ),
                            child: _massivImageLevel1[numRight], //Генерирует из массива правую картинку
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //-----------Контейнер с катринками - Конец---------------
            ),
            Positioned(
              //-----------Контейнер с "+" между цифрами - Начало---------------
              top: top_Contaner_Imags,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 250,
                padding: EdgeInsets.all(2),
                margin: EdgeInsets.all(0),
                alignment: Alignment.center,
                child: Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(40),
                  margin: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(width: 1, color: Colors.black12),
                  ),
//                        child: Image.asset("assets/img_level4/level_+.png"), //картинка со знком +
                  child: Text(
                    "+", //вместо картинки со знаком + будем использовать символ +
                    textScaleFactor: 10.5,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w600, fontStyle: FontStyle.italic, color: Colors.red, decorationColor: Colors.red),
                  ),
                ),
              ),
              //-----------Контейнер с "+" между цифрами - Конец---------------
            ),
            isList
                ? Positioned(
                    top: top_Contaner_Imags + 300,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(2),
                      margin: EdgeInsets.all(0),
                      child: Table(
                        children: <TableRow>[
                          TableRow(
                              //----------Цифры для написания ответа ------ Начало-------
                              //----------(56789)-------------
                              children: [
                                numButton("5", () {
                                  addSymbol("5");
                                }),
                                numButton("6", () {
                                  addSymbol("6");
                                }),
                                numButton("7", () {
                                  addSymbol("7");
                                }),
                                numButton("8", () {
                                  addSymbol("8");
                                }),
                                numButton("9", () {
                                  addSymbol("9");
                                }),
                              ]),
                          //----------(01234)-------------
                          TableRow(children: [
                            numButton("0", () {
                              addSymbol("0");
                            }),
                            numButton("1", () {
                              addSymbol("1");
                            }),
                            numButton("2", () {
                              addSymbol("2");
                            }),
                            numButton("3", () {
                              addSymbol("3");
                            }),
                            numButton("4", () {
                              addSymbol("4");
                            }),
                          ]),

                          //----------Цифры для написания ответа ------ Конец-------
                        ],
                      ),
                    ),
                  )
                : Positioned(
                    top: top_Contaner_Imags + 250,
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
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Level4()));
                                  },
                                ),
                                //--------Кнопка "Повторить" - Конец--------------
                              ),
                              Container(
                                //--------Кнопка "Следующий уровень/Еще раз" - Начало--------------
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
                                    isList == true && stopTimer == false ? "Следующий уровень" : "Уровень не пройден",
                                    textScaleFactor: 1.0,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: Colors.white),
                                  ),
                                  onPressed: () {
                                    dischargeState(); //вызываем функцию сброса данных для логики
                                    dispose();
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => isList == true && stopTimer == false ? GameLivels() : Level4()));
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
            Positioned(
              top: top_Contaner_Imags + 250,
              //-----------Форма ввода ответа под картинками - Начало---------------
              child: isList
                  ? Row(
                      children: <Widget>[
                        //-----Поле вывода ответа - Начало------------------
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            //border: Border.all(width: 1, color: Colors.black12),
                          ),
                          child: Text(
                            stringSumma,
                            textScaleFactor: 1.5,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: Colors.white),
                          ),
                        ),
                        //-----Поле вывода ответа - Конец------------------

                        //-----Кнопка удалить - Начало---------------
                        Container(
                          width: 50,
                          height: 50,
//                        padding: EdgeInsets.all(1),
//                        margin: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              color: Colors.red,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: IconButton(
                            icon: Icon(Icons.cancel),
                            color: Colors.red,
                            disabledColor: Colors.white,
                            alignment: Alignment.center,
                            onPressed: () {
                              setState(() {
                                stringSumma = ""; //очищаем поле ввода при нажатии на ответ
                              });
                            },
                          ),
                        ),
                        //-----Кнопка удалить - Конец---------------

                        //-----Кнопка ответа - Начало ---------------
                        Container(
                          width: width_Button_Nazad,
                          height: 50,
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: RaisedButton(
                            elevation: 0.0, //убераем тень
                            color: Colors.transparent,
                            child: Text(
                              "ОТВЕТ",
                              textScaleFactor: 1.3,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: Colors.white),
                            ),
                            onPressed: () {
                              setState(() {
                                if (n <= 19) {
                                  //если условие выполняется то выполнять следующие действия
                                  intSummaLR = numLeft + numRight;
                                  print("stringSumma= ${stringSumma}");
                                  intSummaParse = int.parse(stringSumma);

                                  if (intSummaLR == intSummaParse) {
                                    //проверяем - если ответили правильно
                                    correct_answer = correct_answer + 1; //то добавляем единицу
                                    correct_wrong = true; //присваиваем правильно
                                    massivColorLevel1[n] = Colors.yellow; //присваиваем желтый - правильно
                                  } else {
                                    correct_wrong = false; //присаиваем неправильно
                                    massivColorLevel1[n] = Colors.red; //присваиваем красный - неправильно
                                  }
                                  n++; //переходим к следующему вопросу
//                                  Level4.my_model.randomLeft();
//                                  Level4.my_model.randomRight();
                                  // ignore: deprecated_member_use
                                  _myBloc.dispatch(RandomLeftEvent(numLeft));
                                  _myBloc.dispatch(RandomRightEvent(numRight));

                                  stopTimer = false; //остнавливаем таймер
                                  timeGame = 0; //сбрасываем счетчик на 0
                                  stopTimer = true; //запускаем таймер
                                  timeWait = timeWaitSlognost; //запускаем счетчик при правильном или неправильном ответе
                                }
                                stringSumma = ""; //очищаем поле ввода при нажатии на ответ
                              });
                            },
                          ),
                        ),
                        //-----Кнопка ответа - Конец ---------------
                        //-----------Форма ввода ответа под картинками - Конец---------------
                      ],
                    )
                  : Row(), //После окончания игры цифры исчезают
            ),
          ],
        ),
      ),
    );
  }
}
