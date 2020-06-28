//import 'package:flutter/material.dart';

abstract class MyEvent {}

//функция возврщающя значения при подборе случайного числа для Левой цифры
class RandomLeftEvent extends MyEvent {
  int numLeftevent; //значение
  RandomLeftEvent(this.numLeftevent); //которое будет возвращаться

  @override
  String toString() {
    print("my_event numL ${numLeftevent} ");
    return "";
  }
}

//функция возврщающя значения при подборе случайного числа для Правой цифры
class RandomRightEvent extends MyEvent {
  int numRight; //значение
  RandomRightEvent(this.numRight); //которое будет возвращаться

  @override
  String toString() {
    print("my_event numR  ${numRight}");
    return "";
  }
}
