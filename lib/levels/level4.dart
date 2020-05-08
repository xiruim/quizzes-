import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:quiz/logika/save_uroven_in_memoru.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:quiz/logika/logika_level1.dart';
import 'dart:core';

import '../gamelivels.dart';

class Level4 extends StatefulWidget {
  @override
  _Level4State createState() => _Level4State();
}

//--------Текстовые переменные - Начало-------
String nameLevelStr = "Уровень: ";
int nameLevelInt = 4;
String text = ""; //пустой текск в полосе пройденных вопросов
TextEditingController contSumma=TextEditingController();//контроллер хранения суммы вводимой игроком
String stringSumma;//для последующего преобразования из текстового контроллера в int
//--------Текстовые переменные - Конец--------

//--------Переменные для логики - Начало---------
int numLeft; //Переменная для левой картинки
int numRight; //Переменная для правой картинки
int intSummaLR;
int intSummaParse;
Logika_Level1 logika_level1 = new Logika_Level1(); //Создали новый объект из класса Logika_Level1
Random random = new Random(); //Для генерации случайных чисел
int n = 0; //Учавствует в цикле из 20 задний
int correct_answer = 0; //Кол-во правильных ответов
bool correct_wrong = true; //правильно или непарвильно
bool isList = true; //логич перемен для активации дополнительных кнопок
int level_of_difficulty; //уровень сложности игры (1, 2 или 3)

//--------Переменные для логики - Конец---------

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

//--------Функция генерации цифр от 0 до 9 - Начало-------
void randomLeftRight() {
  numLeft = random.nextInt(10); //Генерируем цифры от 0 до 9
  numRight = random.nextInt(10); //Генерируем цифры от 0 до 9
  if (numLeft == numRight) {
    randomLeftRight();
  }
}
//--------Функция генерации цифр от 0 до 9 - Конец-------

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

  SaveUrovenInMemoru _saveUrovenInMemoru = SaveUrovenInMemoru();// Вызываем класс записи в память


  //--------Задаем ключи - Начало----------
  final _rowKey = GlobalKey<ScaffoldState>();
  //--------Задаем ключи - Конец----------

  //---------При входе на данный уровень игры обращаемся через данную функцию к функции генерации случайных чисел randomLeftRight(); - Начало-------

  @override
  void initState() {
    super.initState();
    randomLeftRight();
    dischargeState();
    slognostLevel();
  }
  //---------При входе на данный уровень игры обращаемся через данную функцию к функции генерации случайных чисел randomLeftRight(); - Конец-------

  //---------Функция проверки сложности уровня - Начало-------
  @override
  void slognostLevel() async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    level_of_difficulty=pref.getInt("Uroven_slognosti");//присваеваем переменной уровень сложности

    print("Уровень сложности");  print(level_of_difficulty);

  }
  //---------Функция проверки сложности уровня - Конец-------

  //---------При входе на данный уровень игры обращаемся через данную функцию к функции генерации случайных чисел randomLeftRight(); - Начало-------

  @override
  void dischargeState() {
    n = 0; //Учавствует в цикле из 20 задний
    correct_answer = 0; //Кол-во правильных ответов
    correct_wrong = true; //правильно или непарвильно
    isList = true; //логич перемен для активации дополнительных кнопок
    for (int i = 0; i <= 19; i++) {
      massivColorLevel1[i] = Colors.blueGrey;
    }
  }
  //---------При входе на данный уровень игры обращаемся через данную функцию к функции генерации случайных чисел randomLeftRight(); - Конец-------

  //---------Функция сохранения пройденного уровня в памяти телефона - Начало----------------
  @override
  void saveInMemory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("Level_completed", nameLevelInt+1); //открываем следующий уровень и сохраняем в памяти телефона
    print("nameLevelInt ");print(nameLevelInt);
  }

  //---------Функция сохранения пройденного уровня в памяти телефона - Конец----------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _rowKey,
      body: Center(

        child: ListView(
          children: <Widget>[
            Stack(
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
                        dischargeState();
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
                    height:500,
                    padding: EdgeInsets.all(2),
                    margin: EdgeInsets.all(0),
                    child: Container(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(width: 1, color: Colors.black12),
                        ),
                        child: Image.asset("assets/img_level4/level_+.png"), //Генерирует из массива левую картинку
                      ),
                    ),
                  ),
                  //-----------Контейнер с "+" между цифрами - Конец---------------
                ),
                isList
                    ? Positioned(
                  top: top_Contaner_Imags + 250,
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
                                _massivTextLevel1[numLeft],
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
                                _massivTextLevel1[numRight],
                                textScaleFactor: 1.5,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: Colors.white),
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
                              child: RaisedButton(
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
                  top: top_Contaner_Imags + 300,
                  //-----------Форма ввода ответа под картинками - Начало---------------
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          //border: Border.all(width: 1, color: Colors.black12),
                        ),
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType
                              .number,//форма ввода - цифры
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            height: 1, fontSize: 50,),

                          controller: contSumma,
                          decoration: InputDecoration(
//                            icon: Icon(Icons.question_answer),
                              contentPadding: EdgeInsets.all(5),
                              hintText: "= "
                          ),
                          validator: (value){
                            if(value.isEmpty){
                              return"Введите сумму";
                            }return null;
                          },
                        ),
                     ),
                      Container(
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
                            "ОТВЕТ",
                            textScaleFactor: 1.5,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: Colors.white),
                          ),
                          onPressed: () {
                            setState(() {
                              if (n <= 19) {
                                //если условие выполняется то выполнять следующие действия
                                stringSumma=contSumma.text;
                                intSummaLR=numLeft+numRight;
                                intSummaParse=int.parse(stringSumma);
//                                print("stringSumma = ${intSummaParse} = ");
//                                print("intSummaLR = ${intSummaLR}");
//                                print("n = ${n} = ");

                                if (intSummaLR==intSummaParse) {
                                  //проверяем - если ответили правильно
                                  correct_answer = correct_answer + 1; //то добавляем единицу
                                  correct_wrong = true; //присваиваем правильно
                                  massivColorLevel1[n] = Colors.yellow; //присваиваем желтый - правильно
                                } else {
                                  correct_wrong = false; //присаиваем неправильно
                                  massivColorLevel1[n] = Colors.red; //присваиваем красный - неправильно
                                }
                                n++; //переходим к следующему вопросу
                                randomLeftRight();
                                contSumma.text="";//очищаем поле ввода при нажатии на ответ

                                if (n == 20) {
                                  isList = false;
                                  FocusScope.of(context).requestFocus(new FocusNode());
                                  if((n-correct_answer)<=level_of_difficulty){//если уровень пройден
                                    _rowKey.currentState.showSnackBar(SnackBar(content: Text("Поздравляю!!! Уровень пройден. Вы правильно ответили на " + correct_answer.toString() + " вопросов из " + (n).toString())));
                                    saveInMemory();// вызывем функцию сохранения пройденного уровеня в памяти телефона
                                  }else{
                                    _rowKey.currentState.showSnackBar(SnackBar(content: Text("Уровень не пройден!!! Вы правильно ответили только на " + correct_answer.toString() + " вопросов из " + (n).toString())));
                                  }
                                }
                              }
                            });

                          },
                        ),
                      ),
                     //-----------Форма ввода ответа под картинками - Начало---------------
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),

      ),
    );
  }
}
