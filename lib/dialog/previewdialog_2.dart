import 'package:flutter/material.dart';
import 'package:quiz/gamelivels.dart';
import 'package:quiz/levels/level1.dart';
import 'package:quiz/levels/level2.dart';
import 'package:quiz/main.dart';

class PreviewDialog_2 extends StatefulWidget {
  @override
  _PreviewDialog_2State createState() => _PreviewDialog_2State();
}
//--------Переменные размещения на экране - Начало--------

double width_Button_Close = 120; //Размер кнопки закрыть
double height_Button_Close = 50; //Размер кнопки закрыть

double width_Contaner_Imags = 350; //Размер контейнера с поясняющей картинкой

double width_Contaner_Text_Poyasneniya = width_Contaner_Imags; //Размер контейнера с поясняющей картинкой

double top_Dobavka = 0; //Добавка к основным величинам от верха экрана
double top_Button_Close = -5.0; //Начальное положение кнопки "Зкрыть" от верха экрана
double top_Text_Poyasneniya = 350; //Начальное положение Поясняющего текста от верха экрана
double top_Button_Run = 380 + top_Dobavka; //Начальное положение кнопки "Начало" от верха экрана
double top_Contaner_Imags = 90 + top_Dobavka; //Начальное положение контейнера с картинками игры от верха экрана

double left_Button_Close = 270; //Начальное положение кнопки "НАЗАД" от левого края
//double left_Level_text= 200;//Начальное положение кнопки "НАЗАД" от левого края
//--------Переменные размещения на экране - Конец--------

class _PreviewDialog_2State extends State<PreviewDialog_2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            alignment: Alignment.center,
            children: <Widget>[
              //----------фоновая картинка - Начало-----------------------------------
              Positioned(
                top: 20,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  margin: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.1,
                      height: MediaQuery.of(context).size.height / 1.3,
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 50),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: Image.asset(
                              "assets/previewbacgroung_level1.jpg",
                            ).image,
                            fit: BoxFit.cover,
                          )),
                      //----------фоновая картинка - Конец------------------------------------

                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: <Widget>[
                          //----------кнопка закрытия диалогового окна - Начало-------------------
                          Positioned(
                            top: top_Button_Close,
                            left: left_Button_Close,
                            child: RaisedButton.icon(
                              elevation: 0.0, //убераем тень
                              color: Colors.transparent,


                              icon: Icon(Icons.cancel),
                              label: Text(""),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => GameLivels()));
                              },
                            ),
                          ),
                          //----------кнопка закрытия диалогового окна - Конец--------------------

                          //----------картинка поясняющая суть задания - Начало-------------------
                          Positioned(
                            width: MediaQuery.of(context).size.width / 1.1,
                            height: MediaQuery.of(context).size.height / 1.3,
                            child: Center(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    width: 100,
                                    height: 50,
                                    color: Colors.transparent,
                                  ),
                                  Container(
                                    width: width_Contaner_Imags,
                                    margin: EdgeInsets.all(10),
                                    child: Image.asset(
                                      "assets/preview_img1.png",
                                      alignment: Alignment.center,
                                    ),
                                  ),
                                  //----------картинка поясняющая суть задания - Конец--------------------
                                  Container(
                                    width: 100,
                                    height: 50,
                                    color: Colors.transparent,
                                  ),

                                  //----------текст поясняющий суть здния - Начало------------------------
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.all(2),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Выбери цифру, которая меньше",
                                      textScaleFactor: 1.2,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: Colors.blue),
                                    ),
                                  ),
                                  //----------текст поясняющий суть здния - Конец-------------------------

                                  //----------кнопка начала уровня игры - Начало--------------------------
                                  Container(
                                    width: 125,
                                    height: 50,
                                    padding: EdgeInsets.all(5),
                                    margin: EdgeInsets.all(2),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
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
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Level2()));
                                      },
                                    ),
                                  ),
                                  //----------кнопка начала уровня игры - Конец---------------------------

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
