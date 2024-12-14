 
import 'package:chief_app/cubit/menu_cubit/menu_cubit.dart';
import 'package:chief_app/cubit/menu_cubit/menu_states.dart';
import 'package:chief_app/shared/app_colors.dart';
import 'package:chief_app/widgets/navigation_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/menu_item_widget.dart';
import '../widgets/toast_message_widget.dart';
import 'add_meal_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<MenuCubit>(context);
 
    return BlocConsumer<MenuCubit, MenuState>(
      listener: (context, state) {
        if (cubit.meals.isEmpty) {
          print('nooooooooooooooo meals');
        }else{
         print('meals foundedddddddddd');
        }
        if (state is DeleteDishSucessState) {
          print('meal is deleted');
        }
        if (state is DeleteDishSucessState) {
          showSnackBarItem('meal is deleted sucess', context, true);
        }
         if(state is DeleteDishErrorState){
          showSnackBarItem('something wrong', context, false);
          print('meal not deleted');
        }

      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.only(top: 55, right: 24, left: 24),
              child: Column(
               // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                        style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                                AppColors.primaryColor)),
                        onPressed: () {
                          navigateTopush(
                            context: context,
                            wiget: const AddMealScreen(),
                          );
                          /* cubit.login(email: emailController.text, password: passwordController.text);
                                  if (key.currentState!.validate()) {
                                    
                                  } else {
                                  }*/
                        },
                        child: const Text(
                          'Add Meal',
                          style: TextStyle(color: Colors.white),
                        )),
                  ),

                  state is GetAllChefMealsLoadingState ?  Center(child: CircularProgressIndicator(color: AppColors.primaryColor,))  :
                  Expanded(
                      child: cubit.meals.isEmpty
                          ? Center(
                            child:   Text(
                                'No meals founded',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: AppColors.primaryColor),
                              ),
                          )
                          : ListView.builder(
                              itemCount: cubit
                                  .meals.length, // هنا هنجيب الليست من الكيوبيت
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: MenuItem(context, cubit.meals[index]),
                                );
                              },
                            )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}