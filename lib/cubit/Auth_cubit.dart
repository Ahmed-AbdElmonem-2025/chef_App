// ignore_for_file: file_names

import 'dart:convert';
import 'dart:typed_data';

import 'package:chief_app/cubit/auth_states.dart';
import 'package:chief_app/network_helper/dio_helper.dart';
import 'package:chief_app/network_helper/end_point.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
 
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
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





  // sign up
  
  XFile? profileimage;
  XFile ? healthCertificate;
  XFile ? frontIdPath;
  XFile ? backIdPath;

  Future<XFile?> imagePicker(ImageSource source, String imageType) async {
  XFile? image = await ImagePicker().pickImage(source: source);
  if (image != null) {
    if (imageType == 'profile') {
      profileimage = image;  
    } else if(imageType == 'healthCertificate'){
      healthCertificate = image;  
    }else if(imageType == 'frontIdPath'){
      frontIdPath = image;  
    }else if(imageType == 'backIdPath'){
      backIdPath = image;  
    }

       if (profileimage != null &&
        healthCertificate != null &&
        frontIdPath != null &&
        backIdPath != null) {
      emit(SignUpImageUpdatedState());
    }
    
    emit(SignUpImageUpdatedState());  
    return image;
  } else {
    return null;
  }
}
  Future<void> registerUser({
  required String name,
  required String email,
  required String password,
  required String confirmPassword,
  required Map<String, dynamic> location,
  required XFile profilePicPath,
  required String phone,
  required String brandName,
  required dynamic minCharge,
  required String disc,
  required XFile healthCertificate,
  required XFile frontIdPath,
  required XFile backIdPath,
}) async {
  try {
    
 emit(SignUpLoadingState() ) ;
  // تحميل الصور باستخدام rootBundle
    final Uint8List imageBytes1 = await backIdPath.readAsBytes();
    final Uint8List imageBytes2 = await frontIdPath.readAsBytes();
    final Uint8List imageBytes3 = await profilePicPath.readAsBytes();
    final Uint8List imageBytes4 = await healthCertificate.readAsBytes();

    FormData formData = FormData.fromMap({
      'name': name,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'phone': phone,
      'brandName': brandName,
      'minCharge': minCharge,
      'disc': disc,
      // تمرير الصور كـ MultipartFile باستخدام البيانات كـ List<int>
      //'healthCertificate': MultipartFile.fromFileSync(healthCertificate.path, filename: healthCertificate.name.split('/').last),
 // 'frontId': MultipartFile.fromFileSync(frontIdPath.path, filename: frontIdPath.name.split('/').last),
  //'backId': MultipartFile.fromFileSync(backIdPath.path, filename: backIdPath.name.split('/').last),
  //'profilePic': MultipartFile.fromFileSync(profilePicPath.path, filename: profilePicPath.name.split('/').last),
  'backId':  MultipartFile.fromBytes(imageBytes1, filename: backIdPath.path.split('/').last),
  'frontId':  MultipartFile.fromBytes(imageBytes2, filename: frontIdPath.path.split('/').last),
  'profilePic':  MultipartFile.fromBytes(imageBytes3, filename: profilePicPath.path.split('/').last),
  'healthCertificate':  MultipartFile.fromBytes(imageBytes4, filename: healthCertificate.path.split('/').last),
   'location': jsonEncode(location),
    });

    final response = await DioHelper.post(
      endPoint: EndPoint.signupEndpoint,
      data: formData,
      isFormData: true,
      token: token,
    );
print('........................... ..... $frontIdPath .............................');
    if (response.statusCode == 200 || response.statusCode== 201 || response.statusCode == 202) {
      print("Response Message: ${response.data['message']}");
      print(response.statusCode);
      emit(SignUpSuccessState(response.data['message']));
    } else   {
      emit(SignUpErrorState(response.data['ErrorMessage'].toString()));
      print("Error: ${response.statusCode}");
      print('*********************** ${response.data['ErrorMessage']}*************************');
    }
     print(response.data.toString());
     print(response.statusCode.toString());
     
  } catch (e) {
    if (e is DioException) {
      print("DioError Data: ${e.response?.data}");
      print("DioError Status: ${e.response?.statusCode}");
      print("DioError Details: ${e.error.toString()}");
    } else {
      print("Unknown Exception: $e");
    }  
    emit(SignUpErrorState(e.toString()),);
  }
 
}

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  /*
    Future<void> registerUser({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required Map<String, dynamic> location,
      String? profilePicPath,
  }) async {
     // تحميل الصورة من assets باستخدام rootBundle
    String imagePath = 'assets/images/logo.png';
    final ByteData bytes = await rootBundle.load(imagePath);
    final Uint8List imageBytes = bytes.buffer.asUint8List();
    try {
      FormData formData = FormData.fromMap({
        'name': name,
        'email': email,
        'password': password,
        'confirmpaswword': confirmPassword,
        'location': jsonEncode(location), // تمرير الموقع كـ JSON
        'profilePic': /*await MultipartFile.fromFile(
          profilePicPath,
          filename: profilePicPath.split('/').last,*/
           MultipartFile.fromBytes(imageBytes, filename: imagePath.split('/').last)
        ,
      });

      
   final response = await DioHelper.post(endPoint: EndPoint.signupEndpoint,isFormData: true,token: token);
      if (response.statusCode == 200|| response.statusCode == 201 || response.statusCode == 202) {
        print("Response Message: ${response.data['Message']}");
        // يمكنك إظهار رسالة نجاح للمستخدم هنا
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
       if (e is DioException) {
      print("DioError: ${e.response?.data}");
      print("DioError Status Code: ${e.response?.statusCode}");
      print("DioError Message: ${e.message}");
    } else {
      print("Unknown Error: $e");
    }
      // يمكن إضافة معالجة للأخطاء هنا مثل رسالة للمستخدم في حالة حدوث خطأ
    }
  }
*/


























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










 


 // String? idFront;
  //String? backFront;
 // String? profileImage;
}