import 'dart:math';

//-------------State - Состояние---------------
//создадим абстрактный класс (Абстрактный класс - это тип класса, который не может быть создан непосредственно, что означает, что объект не может быть создан из него)

abstract class MyState {}

class InitState extends MyState {
  //инициализация
  InitState();

  //---переопределение например Возвращает строковое представление  целого числа
  @override
  String toString() {
    return "";
  }
}

//функция  которая ничего не возвращает
class LoadingState extends MyState {
  @override
  String toString() {
    return "";
  }
}

//функция которая возвращаает значение для Левых цифр
class RandomLeftState extends MyState {
  int numLeft; //значение
  RandomLeftState(this.numLeft); //которое будет возвращаться
  @override
  String toString() {
    print("my_state numL/R ${numLeft}");
    return "";
  }
}

//функция которая возвращаает значение для Правых цифр
class RandomRightState extends MyState {
  int numRight; //значение
  RandomRightState(this.numRight); //которое будет возвращаться
  @override
  String toString() {
    print("my_state numL/R ${numRight}");
    return "";
  }
}

//функция возвращающая значение при ошибке
class ErrState extends MyState{
  dynamic err;//Данный оператор, как и var, позволяет вывести тип переменной исходя из присвоенного ей значения. Но в отличие от var, dynamic позволяет изменять тип переменной.
  ErrState(this.err);//которое будет возвращаться
  @override
  String toString() {
    return"";
  }
}