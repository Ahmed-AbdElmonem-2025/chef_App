import 'package:chief_app/network_helper/end_point.dart';
import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init()async {
    dio =Dio(
      
      BaseOptions(
       
        baseUrl: EndPoint.baseUrl, ),
        
    );
 dio.options.connectTimeout = const Duration(seconds: 25);  // وقت انتظار الاتصال بالسيرفر 
 dio.options.receiveTimeout = const Duration(seconds: 25);  // وقت انتظار استلام البيانات من السيرفر 
  }






 static Future<Response> getData({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    String? token,
    ProgressCallback? progressCallback,
  }) async {
   try {
      
    Response response = await dio.get(endPoint,
    
     options: Options(
        headers: {
          "token": "FOODAPI $token",
           
        },
        
      ) ,
        queryParameters: queryParameters, onReceiveProgress: progressCallback);
    return response;
   } catch (e) {
    rethrow;
   }
  }

 
 

static Future<Response> post({
  required String endPoint,
  Map<String, dynamic>? queryParameters,
  dynamic data,
  String? token,
  bool isFormData = false,
  ProgressCallback? progressCallback,
}) async {
  try {
   
 
    Response response = await dio.post(
    endPoint,
      options: Options(
        headers: {
          "token": "FOODAPI $token",
           if (isFormData)
              'Content-Type': 'multipart/form-data'
           else
             'Content-Type': 'application/json',
        },
        
      ) ,
      
      data: data,
      queryParameters: queryParameters,
      onReceiveProgress: progressCallback,
      
    );
    return response;
  } catch (e) {
    rethrow;
  }
}








static Future<Response> patch({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    String? token,
    ProgressCallback? progressCallback,
  }) async {
   try {
      dio.options.headers = {};
    Response response = await dio.patch(
      endPoint,
      data: data,
      queryParameters: queryParameters, 
      onReceiveProgress: progressCallback);
    return response;
   } catch (e) {
    rethrow;
   }
  }












static Future<Response> delete({
    required String endPoint,
    required String id,
    
    String? token,
   
  }) async {
   try {
       
    Response response = await dio.delete(
      
      endPoint+'/'+id,
       options: Options(
        headers: {
          "token": "FOODAPI $token",
           
          'Content-Type': 'multipart/form-data'
           
        },
        
      )  ,
     );
    return response;
   } catch (e) {
    rethrow;
   }
  }


}
