

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:quiz/logika/my_repositories.dart';
import 'package:quiz/logika/my_state.dart';
import 'package:quiz/logika/my_event.dart';


class MyBloc extends Bloc<MyEvent, MyState>{
  MyRepositories _myRepositories=MyRepositories();

  MyState get initialState=> InitState();//инициаализируем MyState


  Stream<MyState> mapEventToState(MyEvent event) async*{
//    print("event= ${event}");
    try{
      if(event is RandomLeftEvent){
        yield LoadingState();
//        await Future.delayed(const Duration(seconds: 1), ()=> "1");//делаем задержку для наглядности
        int numLeftbloc=_myRepositories.randomLeftRepos(event.numLeftevent);
        yield RandomLeftState(numLeftbloc);
        print("my_bloc numL ${numLeftbloc}");

      }else if(event is RandomRightEvent){
        yield LoadingState();
        int numRight=_myRepositories.randomRightRepos(event.numRight);
//        print("my_bloc numR ${numRight}");
        yield RandomRightState(numRight);
      }

    } catch(err){
      print("ErrState ${err}");
      yield ErrState(err);
    }
  }
}