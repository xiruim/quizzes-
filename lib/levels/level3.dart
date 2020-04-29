import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:quiz/logika/logika_level1.dart';
import 'dart:core';

import '../gamelivels.dart';

class Level3 extends StatefulWidget {
  @override
  _Level3State createState() => _Level3State();
}

//---------------------------------------------------------------------------------------//
//--------Текстовые переменные - Начало-------
String nameLevelStr = "Уровень: ";
int nameLevelInt = 3;//Номер жизни игры
String text = ""; //пустой текск в полосе пройденного времени
//--------Текстовые переменные - Конец--------

//--------Переменные для логики - Начало---------
int numRandom; //Переменная для генерации случайных чисел
int proidenUroven; //Пройденный уровень
int nNagimaniya = 0; //переменная увеличения при последовательном нажатии цифр
//int j0,j1,j2,j3,j4,j5,j6,j7,j8,j9,j10,j11,j12,j13,j14;//переменные для размещения цифр на поле

Random random = new Random(); //Для генерации случайных чисел
int n = 0; //Учавствует в цикле из 20 задний
int proverka_num = 0; //Учавствует в проверке цифр
//int nNagimaniya=0;//Кол-во нажатий
int correct_answer = 0; //Кол-во правильных ответов
bool correct_wrong = true; //правильно или непарвильно

bool isList = true; //логич перемен для активации дополнительных кнопок
bool stopTimer = true; //логич перемен для счетчика времени
bool boolRecord=false;//логич перемен для рекорда
double timeGame = 0; //переменная для посчета времени игры
int milliSecundi, milliSecundiRecord = 0; //переменная для посчета и вывода времени игры
int secundi, secundRecord = 0; //переменная для посчета и вывода времени игры
int minuti, minutRecord = 0; //переменная для посчета и вывода времени игры
int level_of_difficulty; //уровень сложности игры (1, 2 или 3)
int minutiSlojnosti;//в зависимости от уровня сложности минимальное время за которое надо пройти уровень
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

//----------Создадим список-------------
List<int> massivNumberLevel3 = new List(15);

//  massivNumberLevel3 = new List.generate(15, (_)=>random.nextInt(15));


//++++++++Функция генерации цифр от 0 до 14 для заполнения поля в хаотичном порядке - Начало-------
void randomGenerator() async {
  int i = 0;
  int i1 = 1;
  int i2 = 0;
  massivNumberLevel3[0] = random.nextInt(15);

//  for (int i=0; i<15; i++){massivNumberLevel3[i]=random.nextInt(15);}
//  for (int i=0; i<15; i++){print(massivNumberLevel3[i]);}
  for (int i1 = 1; i1 < 15; i1++) {
    try {
      massivNumberLevel3[i1] = random.nextInt(15);
      for (int i2 = 0; i2 < 15; i2++) {
        if (i1 == i2) {
        } else {
          if (massivNumberLevel3[i1] != massivNumberLevel3[i2]) {
//          print("i1= ${i1}, i2= ${i2}",);
//          print(massivNumberLevel3[i1]);
          } else {
            massivNumberLevel3[i1] = random.nextInt(15);
//          print("iii1= ${i1}, iii2= ${i2}");
            i2--;
            i1--;
          }
        }
      }
    } catch (_) {
//      print("i= ${i}, i1= ${i1},  i21= ${i2}");
    }
  }
//  print("i= ${i}, i1= ${i1},  i21= ${i2}");
}
//++++++++Функция генерации цифр от 0 до 14 для заполнения поля в хаотичном порядке - Конец-------

//========================================================================================================//
//=========Массив с картинками типа ХЕШ-коллекции набор пар ключ-значение - Начало-------
var _massivImageLevel3 = {
  0: Image.asset("assets/img_level3/1.png"),
  1: Image.asset("assets/img_level3/2.png"),
  2: Image.asset("assets/img_level3/3.png"),
  3: Image.asset("assets/img_level3/4.png"),
  4: Image.asset("assets/img_level3/5.png"),
  5: Image.asset("assets/img_level3/6.png"),
  6: Image.asset("assets/img_level3/7.png"),
  7: Image.asset("assets/img_level3/8.png"),
  8: Image.asset("assets/img_level3/9.png"),
  9: Image.asset("assets/img_level3/10.png"),
  10: Image.asset("assets/img_level3/11.png"),
  11: Image.asset("assets/img_level3/12.png"),
  12: Image.asset("assets/img_level3/13.png"),
  13: Image.asset("assets/img_level3/14.png"),
  14: Image.asset("assets/img_level3/15.png"),
  15: Image.asset("assets/img_level3/of.png"), //не активная ячейка с цифрой
  16: Image.asset("assets/img_level3/on.png"), //активная ячейка с цифрой, т.е. правильно нажатая
};
//=========Массив с картинками типа ХЕШ-коллекции набор пар ключ-значение - Конец-------

//##################################### Виджеты ###################################################//

class _Level3State extends State<Level3> {
  //--------Задаем ключи - Начало----------
  final _rowKey = GlobalKey<ScaffoldState>();

  //--------Задаем ключи - Конец----------

  //######## Общий виджет строки с клетками для цифр - Начало-------
  @override
  Widget tableRow(
    massivImage,
    massivImage2,
    massivNumber,
    int numberCell,
  ) {
    return InkWell(
      child: Stack(
        children: <Widget>[
          Positioned(
            child: Container(
              width: 100,
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.all(1),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(width: 1, color: Colors.black12),
              ),
              child: massivImage, //через эту переменную сюда попадает картинка из массива
            ),
          ),
          Positioned(
            child: Container(
              width: 100,
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.all(1),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(width: 1, color: Colors.black12),
              ),
              child: massivImage2, //через эту переменную сюда попадает картинка из массива
            ),
          ),
        ],
      ),

      //-------Логика проверки  нажатая ячейка с цифрой - Начало---------------
      onTap: () {
        //выполнить логику нажатия кнопок
        if (proverka_num == massivNumberLevel3[numberCell]) {
          najatie(numberCell);
          proverka_num++;
//          print("кнопка нажата правильно");
        } else {
//          print("кнопка нажата Неправильно, проверка номера=${proverka_num}, массив=${massivNumber}");
        }
      },
      //-------Логика проверки  нажатая ячейка с цифрой - Конец---------------
    );
  }
//######## Общий виджет строки с клетками для цифр - Конец-------

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++//

//+++++++++++Функция проверки правильности нажатия и Рекорда - Начало-------

  @override
  void najatie(int numberCell) async {
    setState(() {
      print("Нажатие");
      stopTimer = true;
      numRandom = massivNumberLevel3[numberCell];
      if (numRandom == 14) {
//        print("Соптаймер");
        stopTimer = false;
        if(milliSecundi<milliSecundiRecord){
//          print("Функция проверки правильности нажатия и Рекорда миллисек=${minutRecord}");
          if(secundi<=secundRecord){
//            print("Функция проверки правильности нажатия и Рекорда секунды=${secundRecord}");
            if(minuti<=minutRecord){
//              print("Функция проверки правильности нажатия и Рекорда минуты=${minutRecord}");
              minutRecord=minuti;
              secundRecord=secundi;
              milliSecundiRecord=milliSecundi;
              saveRecordInMemory();
              boolRecord=true;
              isList=false;
            }
          }
          isList=false;
        }
        if(minuti<minutiSlojnosti)
      }
    });
  }

//+++++++++++Функция проверки правильности нажатия и Рекорда - Начало-------

//+++++++++++Функция При входе на данный уровень игры обращаемся через данную функцию к функции генерации случайных чисел randomLeftRight(); - Начало-------

  @override
  void initState() {
    super.initState();
    dischargeState();
    randomGenerator();
    time_function();
//    Timer(Duration(milliseconds: 50),(){
//      time_function1();
//    });
  }
//+++++++++++Функция При входе на данный уровень игры обращаемся через данную функцию к функции генерации случайных чисел randomLeftRight(); - Конец-------

//+++++++++++Функция сброса переменных при начале игры - Начало+++++++++++++
  @override
  void dischargeState() async {
    n = 0; //Учавствует в цикле из 20 задний
    nNagimaniya = 0; //Кол-во нажатий
    correct_answer = 0; //Кол-во правильных ответов
    correct_wrong = true; //правильно или неправильно
    proverka_num = 0;
    numRandom = -1;
    milliSecundi = secundi = minuti = 0;

    isList = true; //логич перемен для активации дополнительных кнопок
    boolRecord=false;// готовим для следующего рекорда
    stopTimer = true;//для начала отсчета времени при повторе игры
    SharedPreferences pref = await SharedPreferences.getInstance();
    proidenUroven = pref.getInt("Level_completed"); //присваеваем переменной номер пройденного уровня


    level_of_difficulty = pref.getInt("Uroven_slognosti"); //присваеваем переменной уровень сложности
    milliSecundiRecord = pref.getInt("Record_Level3_millisec");//записываем рекорд из памяти
    secundRecord = pref.getInt("Record_Level3_sec");//записываем рекорд из памяти
    minutRecord = pref.getInt("Record_Level3_minut");//записываем рекорд из памяти
    print("min=${minutRecord}, sec=${secundRecord}, millsec=${minutRecord}");
    if(minutRecord==null && secundRecord==null && milliSecundiRecord==null){//если рекорда еще нет, присваиваем максимальное значение
      minutRecord=secundRecord=59;
      milliSecundiRecord=9;
    }

  }
//+++++++++++Функция сброса переменных при начале игры - Конец+++++++++++++

//+++++++++++Функция сохранения пройденного уровня в памяти телефона - Начало----------------
  @override
  void saveInMemory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("Level_completed", nameLevelInt + 1); //сохраняем пройденный уровень в памяти телефона
    print(nameLevelInt);
  }

//+++++++++++Функция сохранения пройденного уровня в памяти телефона - Конец----------------

  //++++++++Функция проверки сложности уровня и старого рекорда - Начало-------
  @override
  void slognostLevel() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    level_of_difficulty = pref.getInt("Uroven_slognosti"); //присваеваем переменной уровень сложности

    print("Уровень сложности");
    print(level_of_difficulty);
  }
  //++++++++Функция проверки сложности уровня и старого рекорда - Конец-------

  //+++++++++++Функция сохранения рекорда в памяти телефона - Начало----------------
  @override
  void saveRecordInMemory() async {
    SharedPreferences prefsRecord = await SharedPreferences.getInstance();
    await prefsRecord.setInt("Record_Level3_millisec", milliSecundi); //сохраняем Рекорд в памяти телефона
    await prefsRecord.setInt("Record_Level3_sec", secundi);
    await prefsRecord.setInt("Record_Level3_minut", minuti);
    print(nameLevelInt);
  }

//+++++++++++Функция сохранения рекорда в памяти телефона - Конец----------------

//+++++++++++Функция подсчета времени игры и подготовка миллисек, секунд, минут  - Начало------
  Future time_function() async {
    setState(() {
      if (stopTimer == true) {
//        print("Время игры ${timeGame}, ${stopTimer} ");
        Timer(Duration(milliseconds: 250), () {
          timeGame = timeGame + 1;
          milliSecundi = milliSecundi + 1;
          if (milliSecundi == 9) {
            secundi++;
            milliSecundi = 0;
          }
          if (secundi == 59) {
            minuti++;
            secundi = 0;
          }
          time_function();
        });
      }
    });
  }

//+++++++++++Функция подсчета времени игры и подготовка миллисек, секунд, минут - Конец------

  //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _rowKey,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.all(0),
          decoration: BoxDecoration(

              //-----------Основной фон - Начало----------------------------------------
              image: DecorationImage(
                  image: Image.asset("assets/level1.jpg").image, //фоновое изображение контейнера
                  fit: BoxFit.cover //растягивает н весь экраан
                  )),
          //-----------Основной фон - Конец----------------------------------------

          child: Stack(
            children: <Widget>[
//            //-----------Фоновое изображение - Начало----------
//
//            Positioned(
//              child: Image.asset("assets/level1.jpg"),
//            ),
//            //-----------Фоновое изображение - Конец----------
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
                      for (int i = 0; i < 15; i++) {
                        massivNumberLevel3[i] = random.nextInt(15);
                      }
//                    setState(() {
////                      n=20;
//                    });
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
                //-----------Контейнер с катринками - Начало---------------
                top: top_Contaner_Imags,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(2),
                  margin: EdgeInsets.all(0),
                  child: Table(
                    children: <TableRow>[
                      TableRow(
                        children: [
                          tableRow((numRandom == massivNumberLevel3[0]) ? _massivImageLevel3[16] : _massivImageLevel3[15], _massivImageLevel3[massivNumberLevel3[0]], massivNumberLevel3[0], 0),
                          tableRow((numRandom == massivNumberLevel3[1]) ? _massivImageLevel3[16] : _massivImageLevel3[15], _massivImageLevel3[massivNumberLevel3[1]], massivNumberLevel3[0], 1),
                          tableRow((numRandom == massivNumberLevel3[2]) ? _massivImageLevel3[16] : _massivImageLevel3[15], _massivImageLevel3[massivNumberLevel3[2]], massivNumberLevel3[0], 2),
                          tableRow((numRandom == massivNumberLevel3[3]) ? _massivImageLevel3[16] : _massivImageLevel3[15], _massivImageLevel3[massivNumberLevel3[3]], massivNumberLevel3[0], 3),
                          tableRow((numRandom == massivNumberLevel3[4]) ? _massivImageLevel3[16] : _massivImageLevel3[15], _massivImageLevel3[massivNumberLevel3[4]], massivNumberLevel3[0], 4),
                        ],
                      ),
                      TableRow(
                        children: [
                          tableRow((numRandom == massivNumberLevel3[5]) ? _massivImageLevel3[16] : _massivImageLevel3[15], _massivImageLevel3[massivNumberLevel3[5]], massivNumberLevel3[0], 5),
                          tableRow((numRandom == massivNumberLevel3[6]) ? _massivImageLevel3[16] : _massivImageLevel3[15], _massivImageLevel3[massivNumberLevel3[6]], massivNumberLevel3[0], 6),
                          tableRow((numRandom == massivNumberLevel3[7]) ? _massivImageLevel3[16] : _massivImageLevel3[15], _massivImageLevel3[massivNumberLevel3[7]], massivNumberLevel3[0], 7),
                          tableRow((numRandom == massivNumberLevel3[8]) ? _massivImageLevel3[16] : _massivImageLevel3[15], _massivImageLevel3[massivNumberLevel3[8]], massivNumberLevel3[0], 8),
                          tableRow((numRandom == massivNumberLevel3[9]) ? _massivImageLevel3[16] : _massivImageLevel3[15], _massivImageLevel3[massivNumberLevel3[9]], massivNumberLevel3[0], 9),
                        ],
                      ),
                      TableRow(
                        children: [
                          tableRow((numRandom == massivNumberLevel3[10]) ? _massivImageLevel3[16] : _massivImageLevel3[15], _massivImageLevel3[massivNumberLevel3[10]], massivNumberLevel3[0], 10),
                          tableRow((numRandom == massivNumberLevel3[11]) ? _massivImageLevel3[16] : _massivImageLevel3[15], _massivImageLevel3[massivNumberLevel3[11]], massivNumberLevel3[0], 11),
                          tableRow((numRandom == massivNumberLevel3[12]) ? _massivImageLevel3[16] : _massivImageLevel3[15], _massivImageLevel3[massivNumberLevel3[12]], massivNumberLevel3[0], 12),
                          tableRow((numRandom == massivNumberLevel3[13]) ? _massivImageLevel3[16] : _massivImageLevel3[15], _massivImageLevel3[massivNumberLevel3[13]], massivNumberLevel3[0], 13),
                          tableRow((numRandom == massivNumberLevel3[14]) ? _massivImageLevel3[16] : _massivImageLevel3[15], _massivImageLevel3[massivNumberLevel3[14]], massivNumberLevel3[0], 14),
                        ],
                      ),
                    ],
                  ),
                ),
                //-----------Контейнер с катринками - Конец---------------
              ),
              Positioned(
                  top: top_Contaner_Imags + 250,
                  //-----------Контейнер с текстом под картинками - Начало---------------
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(2),
                      margin: EdgeInsets.all(0),
                      child: Table(children: <TableRow>[
                        TableRow(children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              //border: Border.all(width: 1, color: Colors.black12),
                            ),
                            child: !boolRecord ? Text(
//                                  timeGame.toString(),
//                                  minuti.toString(),
                              "$minuti. $secundi. $milliSecundi", //выводим таймер игры
                              textScaleFactor: 1.5,
                              textAlign: TextAlign.start,
                              style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: Colors.white70),
                            ):
                            Text(
//                                  timeGame.toString(),
//                                  minuti.toString(),
                              "$minuti. $secundi. $milliSecundi - Новый рекорд", //выводим таймер игры
                              textScaleFactor: 1.5,
                              textAlign: TextAlign.start,
                              style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: Colors.white70),
                            )
                          ),
//                          Container(
//                            width: MediaQuery.of(context).size.width,
//                            padding: EdgeInsets.all(5),
//                            margin: EdgeInsets.all(1),
//                            decoration: BoxDecoration(
//                              borderRadius: BorderRadius.all(Radius.circular(10)),
//                              //border: Border.all(width: 1, color: Colors.black12),
//                            ),
//                          ),
                        ])
                      ]))),
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
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    //border: Border.all(width: 1, color: Colors.black12),
                                  ),
                                  child: Text(
                                    "$minutRecord. $secundRecord. $minutRecord - Рекорд", //выводим таймер игры
                                    textScaleFactor: 1.5,
                                    textAlign: TextAlign.start,
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
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => Level3()));
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
                                  child: proidenUroven == nameLevelInt
                                      ? RaisedButton(
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
                                        )
                                      : RaisedButton(
                                          elevation: 0.0, //убераем тень
                                          color: Colors.transparent,
                                          child: Text(
                                            "Слишком долго - Уровень не пройден",
                                            textScaleFactor: 1.0,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: Colors.red),
                                          ),
                                          onPressed: () {
                                            dischargeState(); //вызываем функцию сброса данных для логики
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => Level3()));
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
      ),
    );
  }
}
