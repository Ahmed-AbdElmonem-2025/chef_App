 

import 'package:chief_app/cubit/menu_cubit/menu_states.dart';
import 'package:chief_app/models/meal_model.dart';
import 'package:chief_app/network_helper/dio_helper.dart';
import 'package:chief_app/network_helper/end_point.dart';
import 'package:chief_app/shared/app_strings.dart';
import 'package:dio/dio.dart';
 
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
 

class MenuCubit extends Cubit<MenuState> {
  MenuCubit() : super(InitialMenuState());


 

Future<void> addMeal({
  required String mealName,
  required String mealDesc,
  required String mealCategory,
  required String howToSell,
  required double mealPrice,
  required XFile mealImage,    // صورة الوجبة
}) async {
  try {
    // تحميل الصورة من المسار المحلي باستخدام ImagePicker
    final bytes = await mealImage.readAsBytes();

    // تجهيز البيانات باستخدام FormData
    FormData formData = FormData.fromMap({
      "name": mealName,
      "description": mealDesc,
      "price": mealPrice,
      "howToSell": howToSell,
      "category": mealCategory,
      // إضافة صورة كـ MultipartFile من bytes
      "mealImages": [
        MultipartFile.fromBytes(bytes, filename: mealImage.name),
      ],
    });



 

    Response response = await DioHelper.post(endPoint: EndPoint.addMeal,isFormData: true,data: formData,token: token);

     
    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
      print("Meal added successfully");
      emit(AddDishSucessState());
    } else {
      print('Error: ${response.statusCode}, ${response.data}');
    }
  } catch (e) {
    if (e is DioException) {
      print("DioError: ${e.response?.data}");
      print("DioError Status Code: ${e.response?.statusCode}");
      print("DioError Message: ${e.message}");
       emit(AddDishErrorState(err: e.toString()));
    } else {
      print("Unknown Error: $e");
      emit(AddDishErrorState(err: 'can not added please try again'));
    }
  }
}



















// ميثود للتجربة على القيم الثابتة
/*
Future<void> addMeal() async {
  try {
    // بيانات ثابتة
    String mealName = "Pizza Margherita";
    String mealDesc = "Delicious pizza with fresh tomatoes and mozzarella cheese";
    String mealCategory = "Beef";
    String howToSell = "number";
    double mealPrice = 12.99;
    
    // تحميل الصورة من assets باستخدام rootBundle
    String imagePath = 'assets/images/logo.png';
    final ByteData bytes = await rootBundle.load(imagePath);
    final Uint8List imageBytes = bytes.buffer.asUint8List();

    // تجهيز البيانات باستخدام FormData
    FormData formData = FormData.fromMap({
      "name": mealName,
      "description": mealDesc,
      "price": mealPrice,
      "howToSell": howToSell,
      "category": mealCategory,
      // إضافة صورة كـ MultipartFile من bytes
      "mealImages": [
        MultipartFile.fromBytes(imageBytes, filename: imagePath.split('/').last),
      ],
    });

    var options =   Options(
     
    
     headers: {
          "token": "FOODAPI $token", // إضافة التوكن بشكل صحيح
        },
  );

    // إرسال الطلب
    final response = await _dio.post(
      'meal/add-to-menu/',
      data: formData,
      options: options,
    );

    // التحقق من نجاح الطلب
    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
      print("Meal added successfully");
    } else {
      print('Error: ${response.statusCode}, ${response.data}');
    }
  } catch (e) {
    if (e is DioException) {
      print("DioError: ${e.response?.data}");
      print("DioError Status Code: ${e.response?.statusCode}");
      print("DioError Message: ${e.message}");
    } else {
      print("Unknown Error: $e");
    }
  }}

*/













































































































// دى ميثود لو عاوزين بيرميشن للصورة
/*
Future<void> requestPermissions() async {
  if (await Permission.camera.request().isGranted && 
      await Permission.photos.request().isGranted) {
    print("Permissions granted");
  } else {
    print("Permissions denied");
  }
}
*/



XFile? myimage;
// ميثود لتغيير الصورة
 Future<XFile?> imagePicker(ImageSource source)async {
  XFile? image = await ImagePicker().pickImage(source: source);
  if (image != null ) {
     myimage = image;
     emit(MenuImageUpdatedState());
     return image;
  } else {
    return null;
  }
 
 }















  List<String> categoryList=[
    'Beef',
    'Chicken',
    'Seafood',
     'Pork',
    'Lamb',
   
  ];
 String selectedItem='Beef';

 void changeItem(item){
   selectedItem = item;
   emit(ChangedItemState());
 }
 









 String groupValu='quantity';



 void changeGroupVal(val){
  groupValu = val;
  emit(ChangeGroupState());
 }




 
 

 






 
 




















// delete meal
Future deleteMeal({ 
  required String id,
    
})async{
emit(DeleteDishLoadingState());
 try {
   final response = await DioHelper.delete(
     endPoint: EndPoint.deleteMeal ,
     token: token,
     id: id,
   );
  await getMeals();
   emit(DeleteDishSucessState());
  return response.data['message'];
 }  catch (e) {
  emit(DeleteDishErrorState());
   return  e.toString() ;
 }
  
}


 







List<MealModel> meals=[];

// get all meals
 getMeals(  
   
 )async{
emit(GetAllChefMealsLoadingState());
 try {
  if (idd !=null) {
    final response = await DioHelper.getData(
      
    endPoint: EndPoint.getAllChefMeals(idd!),
    token: token,
    
   );
   final mealsData = GetAllMealsModel.fromJson(response.data);
  print(mealsData.toString());
  print(response.data);
if (response.statusCode == 200) {
  // ملء قائمة الوجبات
        meals = mealsData.meals; // تخزين الوجبات في القائمة
   emit(GetAllChefMealsSucessState());
}else{
 // print(response.data.toString());
  emit(GetAllChefMealsErrorState());
}
        
    return response.data['message'];
  }
   
   
    
 
 }  catch (e) {
  
  emit(GetAllChefMealsErrorState());
   if (e is DioException) {
    print("DioError: ${e.response?.data}");
    print("Status Code: ${e.response?.statusCode}");
    print("Headers: ${e.response?.headers}");
  } else {
    print("Unknown error: $e");
  }
  print(  e.toString())  ;
 }
  
} 


}