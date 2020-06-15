import 'dart:async';

import 'dart:math';

class My_Model{
  int numLeft;
  int numRight;
  Random random = new Random(); //Для генерации случайных чисел
  StreamController _streamLeftController=new StreamController<int>();//Создаем поток в который будем передавать данные для левых цифр
  StreamController _streamRightController=new StreamController<int>();//Создаем поток в который будем передавать данные для правых цифр
  Stream<int> get randomLeftUpdate => _streamLeftController.stream;
  Stream<int> get randomRightUpdate => _streamRightController.stream;

  static get my_model => null;




  //--------Функция генерации Левых цифр от 0 до 9 - Начало-------
  void randomLeft() {
    numLeft = random.nextInt(10); //Генерируем цифры от 0 до 9
    _streamLeftController.add(numLeft);
    print("my_provider numL ${numLeft} ");

  }
//--------Функция генерации Левых цифр от 0 до 9 - Конец-------

  //--------Функция генерации Правых цифр от 0 до 9 - Начало-------
  void randomRight() {
    numRight = random.nextInt(10); //Генерируем цифры от 0 до 9
    _streamRightController.add(numRight);
    print("my_provider numR ${numRight} ");

  }
//--------Функция генерации Правых цифр от 0 до 9 - Конец-------
}