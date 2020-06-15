
import 'package:flutter/material.dart';

class Logika_Level1 extends StatefulWidget {
  _Logika_Level1State logika_level1State=new _Logika_Level1State();
  @override
  _Logika_Level1State createState() => _Logika_Level1State();
  void addSymbol(symbol) {
    logika_level1State.addSymbol(symbol);
    print("symbol= ${symbol}");
  }


}

String stringSumma = " "; //для последующего преобразования из текстового контроллера в int





class _Logika_Level1State extends State<Logika_Level1> {

//--------Функция при нажатии цифр для получения ответа - Начало-------

  void addSymbol(symbol) {
//    setState(() {
      if (stringSumma == "") {
        stringSumma = symbol;
      } else {
        stringSumma += symbol;
      }
//    });

  }

//--------Функция при нажатии цифр для получения ответа - Конец-------


  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
