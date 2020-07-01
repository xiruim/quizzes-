//import 'package:flutter/material.dart';

abstract class MyEvent {}

//функция возврщающя значения при подборе случайного числа для Левой цифры
class RandomLeftEvent extends MyEvent {
  int value; //значение
  RandomLeftEvent(this.value); //которое будет возвращаться
  @override
  String toString() {
    print("my_event numL ${value} ");
    return "";
  }
}

//функция возврщающя значения при подборе случайного числа для Правой цифры
class RandomRightEvent extends MyEvent {
  int value; //значение
  RandomRightEvent(this.value); //которое будет возвращаться
  @override
  String toString() {
//    print("my_event numR  ${numRight}");
    return "";
  }
}
