

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:quiz/logika/my_repositories.dart';
import 'package:quiz/logika/my_state.dart';
import 'package:quiz/logika/my_event.dart';


class MyBloc extends Bloc<MyEvent, MyState>{
  MyRepositories _myRepositories=MyRepositories();

  MyState get initialState => InitState();//инициаализируем MyState


  Stream<MyState> mapEventToState(MyEvent event) async*{
//    print("event= ${event.toString()}");
    try{
      if(event is RandomLeftEvent){
        yield LoadingState();
//        await Future.delayed(const Duration(seconds: 1), ()=> "1");//делаем задержку для наглядности
        int result =_myRepositories.randomLeftRepos(event.value);
        yield RandomLeftState(result);
        print("my_bloc numL ${result}");

      }else if(event is RandomRightEvent){
        yield LoadingState();
//        await Future.delayed(const Duration(milliseconds: 500), ()=> "0.2");
        int result =_myRepositories.randomRightRepos(event.value);
//        print("my_bloc numR ${numRight}");
        yield RandomRightState(result);
      }

    } catch(err){
      print("ErrState ${err}");
      yield ErrState(err);
    }
  }
}