import 'package:chief_app/cubit/home_cubit/home_states.dart';
import 'package:chief_app/screens/menu_screen.dart';
import 'package:chief_app/screens/person_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit () : super(InitialState());

 List<Widget> screens = [const MenuScreen(),const PersonScreen()];

  int currentIndex=0;
 void changeIndex(index){
     currentIndex = index;
     emit(ChangeIndexState());
  }

}