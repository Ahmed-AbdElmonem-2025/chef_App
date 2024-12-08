import 'package:chief_app/cubit/home_cubit/home_cubit.dart';
import 'package:chief_app/cubit/home_cubit/home_states.dart';
import 'package:chief_app/shared/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit,HomeStates>(
      builder: (context, state) {
        return Scaffold(
          body: BlocProvider.of<HomeCubit>(context).screens[BlocProvider.of<HomeCubit>(context).currentIndex] ,
      bottomNavigationBar: GNav(
      activeColor: AppColors.primaryColor,
       gap: 8,
       padding: const EdgeInsets.all(16),
       tabBackgroundColor:Colors.black12 ,
       tabBorderRadius:14 ,
       selectedIndex: BlocProvider.of<HomeCubit>(context).currentIndex,
       onTabChange: (index) {
         BlocProvider.of<HomeCubit>(context).changeIndex(index);
       },
      tabs: const [
      GButton(icon: Icons.menu,text: 'menu',),
      GButton(icon: Icons.person,text: 'Edit Profile',),
      
        ]),
        
      );
      },
    
    );
  }
}