import 'package:flutter/material.dart';

abstract class MyEvent {}

//функция возврщающя значения при подборе случайного числа для Левой цифры
class RandomLeftEvent extends MyEvent {
  int numLeft; //значение
  RandomLeftEvent(this.numLeft); //которое будет возвращаться
  @override
  String toString() {
    // TODO: implement toString
    print("my_event numL/R ${numLeft} ");
    return "";
  }
}

//функция возврщающя значения при подборе случайного числа для Правой цифры
class RandomRightEvent extends MyEvent {
  int numRight; //значение
  RandomRightEvent(this.numRight); //которое будет возвращаться

  @override
  String toString() {
    // TODO: implement toString
    print("my_event numL/R  ${numRight}");
    return "";
  }
}
