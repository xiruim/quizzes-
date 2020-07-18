import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/logika/my_bloc.dart';
import 'package:quiz/logika/my_event.dart';
import 'package:quiz/logika/my_state.dart';
import 'package:quiz/logika/my_vars.dart';

import '../gamelivels.dart';

class Level4_1 extends StatefulWidget {
  @override
  _Level4_1State createState() => _Level4_1State();
}

class _Level4_1State extends State<Level4_1> {
  MyBloc _myBloc;
  int numLeft = 3;
  int numRight = 2;

  //--------Задаем ключи - Начало----------
  final _rowKey = GlobalKey<ScaffoldState>();
  //--------Задаем ключи - Конец----------

  @override
  void initState() {
    _myBloc = MyBloc();
    _myBloc.dispatch(RandomLeftEvent(3));//не получилось все равно при ктивации сраницы картинки не появляются
    _myBloc.dispatch(RandomRightEvent(5));//не получилось все равно при ктивации сраницы картинки не появляются

//     TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _myBloc.dispose();
    super.dispose();
  }

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

  //--------Функция смены картинок--Начало-----
  @override
  void reload() {
    // ignore: deprecated_member_use
    _myBloc.dispatch(RandomLeftEvent(numLeft));
    Timer(Duration(milliseconds: 1), () {
      //установил таймер т.к. без него первая цифра не меняется
      // ignore: deprecated_member_use
      _myBloc.dispatch(RandomRightEvent(numRight));
    });
  }

  //--------Функция смены картинок--Конец-----

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _rowKey,
      body: Center(
        child: Stack(
          children: <Widget>[
//            BlocListener(
//              bloc: _myBloc,
//              listener: (prev, curr){
//                if(curr is ErrState){
//                  _rowKey.currentState.showSnackBar(
//                      SnackBar(content: Text(curr.err.message),));
//                }
//              },
//            ),
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
                        BlocListener(
                          bloc: _myBloc,
                          listener: (prev, curr) {
                            if (curr is ErrState) {
                              _rowKey.currentState.showSnackBar(SnackBar(
                                content: Text(curr.err.message),
                              ));
                            }
                          },
                          child: BlocBuilder(
                              bloc: _myBloc,
                              builder: (prev, curr) {
                                if (curr is RandomLeftState || curr is! RandomRightState) {
                                  numLeft = curr.value;
                                  print("numLeft ${numLeft}");
                                  print("curr.numLeftVal= ${curr.value}");
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.all(5),
                                    margin: EdgeInsets.all(1),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      border: Border.all(width: 1, color: Colors.black12),
                                    ),
                                    child: _massivImageLevel1[numLeft], //Генерирует из массива левую картинку
                                  );
                                }
                                if (curr is LoadingState) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.all(5),
                                    margin: EdgeInsets.all(1),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      border: Border.all(width: 1, color: Colors.black12),
                                    ),
                                    child: CircularProgressIndicator(), //в центе выводим крутилку
                                  );
                                }
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.all(5),
                                  margin: EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    border: Border.all(width: 1, color: Colors.black12),
                                  ),
                                  child: _massivImageLevel1[numLeft], //Генерирует из массива левую картинку
                                );
                              }),
                        ),
                        BlocListener(
                          bloc: _myBloc,
                          listener: (prev, curr) {
                            if (curr is ErrState) {
                              _rowKey.currentState.showSnackBar(SnackBar(
                                content: Text(curr.err.message),
                              ));
                            }
                          },
                          child: BlocBuilder(
                              bloc: _myBloc,
                              builder: (prev, curr) {
//                              print("curr1= ${curr.toString()}");
//                              print("curr.numLeftVal= ${curr.numLeftVal}");
                                if (curr is! RandomLeftState || curr is RandomRightState) {
                                  numRight = curr.value;
                                  print("numLeft ${numRight}");
                                  print("curr.numRightVal= ${curr.value}");
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.all(5),
                                    margin: EdgeInsets.all(1),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      border: Border.all(width: 1, color: Colors.black12),
                                    ),
                                    child: _massivImageLevel1[numRight], //Генерирует из массива левую картинку
                                  );
                                }
                                if (curr is LoadingState) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.all(5),
                                    margin: EdgeInsets.all(1),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      border: Border.all(width: 1, color: Colors.black12),
                                    ),
                                    child: CircularProgressIndicator(), //в центе выводим крутилку
                                  );
                                }
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.all(5),
                                  margin: EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    border: Border.all(width: 1, color: Colors.black12),
                                  ),
                                  child: _massivImageLevel1[numRight], //Генерирует из массива левую картинку
                                );
                              }),
                        )
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
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Level4_1()));
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
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => isList == true && stopTimer == false ? GameLivels() : Level4_1()));
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
//                                  Level4.my_model.randomRight();
                                  reload();
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
