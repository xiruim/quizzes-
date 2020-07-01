

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class My_vars extends StatefulWidget {
  @override
  _My_varsState createState() => _My_varsState();
}
//--------Текстовые переменные - Начало-------
String nameLevelStr = "Уровень: ";
int nameLevelInt = 4;
String text = ""; //пустой текск в полосе пройденных вопросов
TextEditingController contSumma = TextEditingController(); //контроллер хранения суммы вводимой игроком
String stringSumma = " "; //для последующего преобразования из текстового контроллера в int
//--------Текстовые переменные - Конец--------

//--------Переменные для логики - Начало---------
int _numLeft=0; //Переменная для левой картинки
int numRight=0; //Переменная для правой картинки
int intSummaLR;
int intSummaParse;
//Logika_Level1 logika_level1 = new Logika_Level1(); //Создали новый объект из класса Logika_Level1
int n = 0; //Учавствует в цикле из 20 задний
int correct_answer = 0; //Кол-во правильных ответов
bool correct_wrong = true; //правильно или непарвильно
bool isList = true; //логич перемен для активации дополнительных кнопок
bool stopTimer = true; //логич перемен для счетчика времени
bool bool_smile = true; // - для показа разных смайликов
int level_of_difficulty; //уровень сложности игры (1, 2 или 3)
int timeGame = 0; //переменная для посчета времени игры
int timeWaitSlognost = 10; //переменная для задания отсчета обратного времени
int timeWait = 10; //переменная для отсчета обратного времени
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
double top_Polosa = 140 ; //Начальное положение полоски выполненных задний от верха экрана
double top_Contaner_Imags = 155 ; //Начальное положение контейнера с картинками игры от верха экрана

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

class _My_varsState extends State<My_vars> {

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

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

