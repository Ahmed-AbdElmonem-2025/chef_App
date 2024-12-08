import 'package:chief_app/screens/change_lang.dart';
import 'package:chief_app/shared/app_assests.dart';
import 'package:chief_app/shared/app_colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    navigateAfterThreeSeconds();
     super.initState();
  }

  void navigateAfterThreeSeconds(){
    Future.delayed(const Duration(seconds: 3,)).then((value){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const ChangeLanguageScreen();
      },));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,

      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
       Image.asset(AppAssets.appLogo),
       Text('Chef App',style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.white),)    
        ],
      ) ,
    );
  }
}