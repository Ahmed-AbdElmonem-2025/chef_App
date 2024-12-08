// ignore_for_file: file_names

import 'package:chief_app/cubit/auth_states.dart';
import 'package:chief_app/network_helper/dio_helper.dart';
import 'package:chief_app/network_helper/end_point.dart';
 
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../shared/app_strings.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit () : super(InitialState());

  
  login({
    required String email,
    required String password,
  }){
  emit(LoginLoadingState());  
  Map<String,dynamic> data ={ // دى البادى اللى بيكون فى البوست مان
   'email':email,
   'password':password,
  };

  DioHelper.post(endPoint: EndPoint.loginEndpoint,data:data ).then((value) async {
    print(value.data.toString());
     //String yourToken = "Your JWT";
     Map<String, dynamic> decodedToken = JwtDecoder.decode(value.data['token']);
        try {
      var prefs = await SharedPreferences.getInstance();
      await prefs.setString('id', decodedToken['id']);
     // idd = prefs.getString('id');
      
      print("ID saved: $idd");


      //token
      await prefs.setString('token', value.data['token']);
      token = prefs.getString('token');
    } catch (e) {
      print("Error saving ID: $e");
    }
  print(decodedToken["name"]);

print('donnnnnnnnnnnnnnnnnnnnnnnnnnnne');
    emit(LoginSuccessState());
  }).catchError((onError){
    print(onError.toString());
    emit(LoginErrorState(onError.toString(),));
  });

  }






  // send code

  sendCode({
    required String email,
     
  }){
    emit(SendCodeLoadingState());
  Map<String,dynamic> data ={ // دى البادى اللى بيكون فى البوست مان
   'email':email,
    
  };
  DioHelper.post(endPoint: EndPoint.sendCodeEndpoint,data:data, ).then((value){
    
    print(value.data.toString());
    emit(SendCodeSuccessState());
  }).catchError((onError){
    print(onError.toString());
    emit(SendCodeErrorState(onError.toString()));
  });
 
   
  }














   // reset password  

  resetpassword({
    required String email,
    required String password,
    required String confirmpassword,
    required String code,
  }){
    emit(SendCodeLoadingState());
  Map<String,dynamic> data ={ // دى البادى اللى بيكون فى البوست مان
   'email':email,
   'password':password,
   'confirmpassword':confirmpassword,
   'code':code,
    
  };
  DioHelper.patch(endPoint: EndPoint.changeForgottenPassword,data:data, ).then((value){
    
    print(value.data.toString());
    emit(ResetPasswordSuccessState());
  }).catchError((onError){
    print(onError.toString());
    emit(ResetPasswordErrorState(onError.toString()));
  });

  }










 


  String? idFront;
  String? backFront;
  String? profileImage;
}