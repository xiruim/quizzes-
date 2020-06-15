
import 'dart:async';

import 'package:flutter/material.dart';

//--------Переменные для логики - Начало---------
int timeGame = 0; //переменная для посчета времени игры
int timeWaitSlognost = 10; //переменная для задания отсчета обратного времени
int timeWait = timeWaitSlognost; //переменная для отсчета обратного времени
int chet_nechet = 0; //для определения четное не четное

//--------Переменные для логики - Конец---------


class TaimProstoiStop extends StatefulWidget {




  _TaimProstoiStopState taimProstoiStopState=new _TaimProstoiStopState();
  @override
  _TaimProstoiStopState createState() => _TaimProstoiStopState();



  void time_function(bool_smile, isList, stopTimer){
    taimProstoiStopState.time_function(bool_smile, isList, stopTimer);
  }


}

class _TaimProstoiStopState extends State<TaimProstoiStop> {



  //+++++++++++Функция подсчет времени простоя игры  - Начало------
  Future time_function(bool_smile, isList, stopTimer) async {
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
          time_function(bool_smile, isList, stopTimer);
        }
        chet_nechet = timeGame % 2;
        timeWait = timeWait - 1;

      });
    });
    return;
  }

//+++++++++++Функция подсчет времени простоя игры - Конец------




  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
