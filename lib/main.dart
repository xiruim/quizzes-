import 'package:flutter/material.dart';
//import 'package:image/image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:quiz/gamelivels.dart';

import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:core';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //----------Переменные-------------
  String text_appBar_main = "Викторина";
  String slognost = "Уровень сложности";
  int uroven_slognost;

  //---переменные для таблицы
  double width_tabl = 200; //ширина ячейки таблицы
  double height_tabl = 70; //высота ячейки таблицы

  //--------Задаем ключи - Начало----------
  final _rowKey = GlobalKey<ScaffoldState>();
  //--------Задаем ключи - Конец----------

  //---------При входе на данный уровень игры обращаемся через данную функцию к функции генерации случайных чисел randomLeftRight(); - Начало-------

  @override
  void initState() {
    super.initState();
    loadSlognostInMemory();
  }
  //---------При входе на данный уровень игры обращаемся через данную функцию к функции генерации случайных чисел randomLeftRight(); - Конец-------


//  //---------Массив с Текстом "Уровень сложности" типа ХЕШ-коллекции набор пар ключ-значение - Начало-------
//  var _massivTextUrovenSlognosti = {
//    0: "Легкий",
//    1: "Средний",
//    2: "Сложный",
//  };
////---------Массив с Текстом типа ХЕШ-коллекции набор пар ключ-значение - Конец-------

  //--W---повторяющийся виджет столбцов с названием уровней - Начало--W
  Widget tablNameUrovenComponent(String nameUrovenComp, double h_shript, double h_megduStrok) {
    return TableCell(
      child: Container(
        child: Container(
          //height: height_tabl,
          padding: EdgeInsets.all(2),
//          margin: EdgeInsets.all(10),
          child: Text(
            nameUrovenComp,
            textScaleFactor: h_shript,
            textAlign: TextAlign.left,
            style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: Colors.white70, height: h_megduStrok),
          ),
        ),
      ),
    );
  }
  //--W---повторяющийся виджет столбцов  с названием уровней - Конец--W

  //--W---повторяющийся виджет Радиокнопки выбора уровня - Начало--W
  Widget tablRadioComponent(int val) {
    return TableCell(
      child: Radio(
        value: val,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, //сужает строки
        activeColor: Colors.white, //цвет активной кнопки
        groupValue: uroven_slognost,
        onChanged: (T) {
          print(T);
          setState(() {
            uroven_slognost = T;
            saveSlognostInMemory();
          });
        },
      ),
    );
  }
  //--W---повторяющийся виджет Радиокнопки выбора уровня - Конец--W

  //---------Функция сохранения сложности уровня игры в памяти телефона - Начало----------------
  @override
  void saveSlognostInMemory() async {
    if(uroven_slognost==null){
      uroven_slognost=3;
    }else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt("Uroven_slognosti", uroven_slognost); //сохраняем  уровень сложности в памяти телефона
    }
    print(uroven_slognost);
  }

  //---------Функция сохранения сложности урорвня игры в памяти телефона - Конец----------------

  //---------Функция сохранения сложности уровня игры из памяти телефона - Начало----------------
  @override
  void loadSlognostInMemory() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(uroven_slognost==null){
      uroven_slognost=3;
    }else{
      uroven_slognost=prefs.getInt("Uroven_slognosti"); //сохраняем  уровень сложности в памяти телефона
    }

    print(uroven_slognost);
  }

  //---------Функция сохранения сложности урорвня игры из памяти телефона - Конец----------------

  @override
  Widget build(BuildContext context) {
    //----Нчало - Скрывает строку состояния (время, заряд и т.д.)--------
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    //----Конец - Скрывает строку состояния (время, заряд и т.д.)--------

    return Scaffold(
      key: _rowKey,
      //DDDDDD ----- Боковое выпадающее меню - Начало-------

      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(

            //-----------Основной фон - Начало----------------------------------------
              image: DecorationImage(
                  image: Image.asset("assets/main_background.jpg").image, //фоновое изображение контейнера
                  fit: BoxFit.cover //растягивает н весь экраан
              )),
          //-----------Основной фон - Конец----------------------------------------
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.transparent,
                height: 50,
              ),
              //------------------Выбор сложности уровня - Начало-----------
              Container(
                margin: EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width / 2, //Разтягиваем на всю ширину экрана
                child: Table(
                  children: [
                    TableRow(children: <TableCell>[
                      tablRadioComponent(3),
                      tablNameUrovenComponent("Легкий", 1.2, 2),
                    ]),
                    TableRow(children: <TableCell>[
                      tablRadioComponent(2),
                      tablNameUrovenComponent("Средний", 1.2, 2),
                    ]),
                    TableRow(children: <TableCell>[
                      tablRadioComponent(1),
                      tablNameUrovenComponent("Тяжелый", 1.2, 2),
                    ]),
                  ],
                ),
              ),
              //------------------Выбор сложности уровня - Конец-----------

              //------- Кнопка сброса выполненых заданий - Начало--------
              Container(
                width: 200,
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
                    "Сброс выполненых заданий",
                    textScaleFactor: 0.9,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: Colors.white),
                  ),
                  onPressed: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    await prefs.setInt("Level_completed", 1); //обнуляем пройденный уровень в памяти телефона
                    await prefs.setInt("Uroven_slognosti", 3);//обнуляем  уровень сложности в памяти телефона
                    uroven_slognost=null;
                    print("uroven_slognost "); print(uroven_slognost);
                    saveSlognostInMemory();
                   // _rowKey.currentState.showSnackBar(SnackBar(content:Text("Все задания обнулены, начните все сначала")));
                  },
                ),
              ),
              //------- Кнопка сброса выполненых заданий - Начало--------
            ],
          ),
        ),
      ),
      //DDDDDD ----- Боковое выпадающее меню - Конец-------

      body: Center(
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Image.asset("assets/main_background.jpg"),
            ),
            Positioned(
              top: 100,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Container(
                  width: 250,
                  height: 250,
                  alignment: Alignment.center,
                  //padding: ,
                  child: Image.asset("assets/main_img_boy.png"),
                ),
              ),
            ),
            Positioned(
              top: 560,
              left: MediaQuery.of(context).size.width / 2 - 150 / 2,
              child: Container(
                width: 150,
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
                    "НАЧАТЬ",
                    textScaleFactor: 1.5,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: Colors.white),
                  ),
                  onPressed: () {
                    saveSlognostInMemory();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => GameLivels()));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
