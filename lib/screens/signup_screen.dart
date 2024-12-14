
import 'dart:io';

import 'package:chief_app/screens/Login_screen.dart';
import 'package:chief_app/widgets/toast_message_widget.dart';
import 'package:flutter/material.dart';
 
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
 
import '../cubit/Auth_cubit.dart';
import '../cubit/auth_states.dart';
import '../shared/app_colors.dart';
import '../widgets/custom_text_field.dart';
 

class SignUp extends StatefulWidget {
    const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();

   TextEditingController passwordController = TextEditingController();
 
TextEditingController nameController = TextEditingController(); 
TextEditingController addressController = TextEditingController(); 
TextEditingController phoneController = TextEditingController();
  TextEditingController latController = TextEditingController(); 
  TextEditingController langController = TextEditingController(); 
   TextEditingController confirmPasswordController = TextEditingController(); 
   TextEditingController locationController = TextEditingController();
    TextEditingController brandNameController = TextEditingController(); 
    TextEditingController minChargeController = TextEditingController();
     TextEditingController descController = TextEditingController();

     
      TextEditingController frontIdController = TextEditingController();
       TextEditingController backIdController = TextEditingController(); 
       TextEditingController profilePicController = TextEditingController();

   GlobalKey<FormBuilderState> signupkey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    var cubit =  BlocProvider.of<AuthCubit>(context,listen: true);
    return BlocConsumer<AuthCubit,AuthStates>(
      listener: (context, state) {
        if (state is SignUpErrorState) {
          showSnackBarItem(state.errorMsg, context, false);
          print('errrrrrrrrrrrrrrrrrrrrrrrror');
        }
        if (state is SignUpSuccessState) {
           showSnackBarItem(state.Msg, context, true);
           Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) {
             return LoginScreen();
           },));
          print('suuuuuuuuuuuuuuuuuuuuuucscccccccssssssss');
        }
      },
      builder: (context, state) {
        return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Image.asset(
                    'assets/images/backgroundt.png',
                    width: double.infinity,
                  ),
                  Center(
                      child: Text(
                    'Welcome Back',
                    style: TextStyle(color: AppColors.white, fontSize: 20),
                  )),
                ],
              ),
            
                  Padding(
            padding: const EdgeInsets.all(14.0),
            child: FormBuilder(
                    key: signupkey,
                    child: BlocConsumer<AuthCubit,AuthStates>(
                      listener: (context, state) {
                      
                      },
                      builder: (context, state) {
                        return Column(
                        children: [
                        CustomTextField(
                          controller:emailController,
                           hintText: 'Email',
                             
                             validator:  (data) {
                               if (data!.isEmpty) {
                                 return 'email not valid';
                               }else{
                                return null;
                               }
                             },) , 
                                
                             const SizedBox(height: 10,),
                                
                             CustomTextField(
                          controller: nameController,
                           hintText: 'name',
                             
                             validator:  (data) {
                               if (data!.length < 6) {
                                 return 'name not valid';
                               }else{
                                return null;
                               }
                             },) , 
            
            
      
                       const SizedBox(height: 10,),
                                // phone
                             CustomTextField(
                          controller: phoneController,
                           hintText: 'phone',
                             
                             validator:  (data) {
                               if (data!.length < 11) {
                                 return 'phone not valid';
                               }else{
                                return null;
                               }
                             },) , 
            
            
                            const SizedBox(height: 10,),
                                
                             CustomTextField(
                          controller: passwordController,
                           hintText: 'password',
                             
                             validator:  (data) {
                               if (data!.length < 6) {
                                 return 'password not valid';
                               }else{
                                return null;
                               }
                             },) , 
            
            
            
            
            
            
            
                             const SizedBox(height: 10,),
                                
                             CustomTextField(
                          controller: confirmPasswordController,
                           hintText: 'confirm password',
                             
                             validator:  (data) {
                               if (data!.length < 6 && data == passwordController.text) {
                                 return 'confirm password not valid';
                               }else{
                                return null;
                               }
                             },) , 
            
            
            
            
            
            
            
                             const SizedBox(height: 10,),
                                
                             CustomTextField(
                          controller: brandNameController,
                           hintText: 'brand Name',
                             
                             validator:  (data) {
                               if (data!.length < 6) {
                                 return 'brand Name not valid';
                               }else{
                                return null;
                               }
                             },) , 
            
            
            
            
            
            
                             const SizedBox(height: 10,),
                                
                             CustomTextField(
                          controller: locationController,
                           hintText: 'location',
                             
                             validator:  (data) {
                               if (data!.length < 6) {
                                 return 'location not valid';
                               }else{
                                return null;
                               }
                             },) , 
            
            
            
            
            
            
                             const SizedBox(height: 10,),
                                
                             CustomTextField(
                          controller: minChargeController,
                           hintText: 'min Charge',
                             
                             validator:  (data) {
                               if (data!.length < 2) {
                                 return 'min Charge not valid';
                               }else{
                                return null;
                               }
                             },) , 
            
            
            
            
            
            
                             const SizedBox(height: 10,),
                                
                             CustomTextField(
                          controller: descController,
                           hintText: 'description',
                             
                             validator:  (data) {
                               if (data!.length < 6) {
                                 return 'desc not valid';
                               }else{
                                return null;
                               }
                             },) , 
             
            
      
      
                            const SizedBox(height: 10,),
                                // address
                             CustomTextField(
                          controller: addressController,
                           hintText: 'address',
                             
                             validator:  (data) {
                               if (data!.length < 6) {
                                 return 'address not valid';
                               }else{
                                return null;
                               }
                             },) , 
      
      
      
                       const SizedBox(height: 10,),
                                // lattitude
                             CustomTextField(
                          controller: latController,
                           hintText: 'lat',
                             
                             validator:  (data) {
                               if (data!.length < 6) {
                                 return 'lat not valid';
                               }else{
                                return null;
                               }
                             },) , 
            
      
             const SizedBox(height: 10,),
                                // langtude
                             CustomTextField(
                          controller: langController,
                           hintText: 'lang',
                             
                             validator:  (data) {
                               if (data!.length < 6) {
                                 return 'lang not valid';
                               }else{
                                return null;
                               }
                             },) , 
            
                             const SizedBox(height: 32,),
                            
      
      
      
      
      
      
      
                     
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: InkWell(
                                onTap: () {
                                                       cubit.imagePicker(ImageSource.camera, 'profile') ;               
                                },
                                child:
                                cubit.profileimage == null ?
                                 Container(
                                  
                                  width: double.infinity,
                                  height:200,
                                  decoration:  BoxDecoration(  color:AppColors.primaryColor,),
                                  child:const Icon(Icons.image, size: 40,),
                                ) :  Container(
                                  width: double.infinity,
                                  height: 200,
                                  decoration:  BoxDecoration( color: AppColors.primaryColor,),
                                  child: Image.file(File(cubit.profileimage!.path),) , 
                                  ),
                              ),
                           ),       
                            
           /*                     // صورة  شخصية     
               FormBuilderImagePicker(
                             
                  name: 'gallery_images', 
                  decoration: const InputDecoration(
                    labelText: 'profile image',
                    labelStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                    focusColor: Colors.red,
                  ),
                  
                  maxImages: 1,  
                  iconColor: AppColors.primaryColor,
                  onChanged: (pickedImage) {
                   
                      cubit.profileimage = pickedImage!.first;
                      
                    
                  },
                
                ),
      */
      
                 
      
      
      
      
      
      
      
      
      
      
      
      
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: InkWell(
                                onTap: () {
                                                       cubit.imagePicker(ImageSource.camera, 'healthCertificate') ;               
                                },
                                child:
                                cubit.healthCertificate == null ?
                                 Container(
                                  width: double.infinity,
                                  height:200,
                                decoration:  BoxDecoration(  color:AppColors.primaryColor,),
                                child:const Icon(Icons.image, size: 40,),
                                ) :  Container(
                                  width: double.infinity,
                                  height: 200,
                                  decoration:  BoxDecoration(  color:AppColors.primaryColor,),
                                  child: Image.file(File(cubit.healthCertificate!.path),) , 
                                  ),
                              ),
                           ),
              /*   // شهادة    
                  FormBuilderImagePicker(
                             
                  name: 'gallery_images',
                  decoration: const InputDecoration(
                    labelText: 'certificate',
                    labelStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                  ),
                  
                  maxImages: 1,  
                  iconColor: AppColors.primaryColor,
                  onChanged: (pickedImage) {
                   
                      cubit.healthCertificate = pickedImage!.first;
                        
      print('Selected Image Path: ${cubit.backIdPath?.path}');
                    
                  },
                
                ),
                    */        
      
      
      
      
      
      
      
      
      
      
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: InkWell(
                                onTap: () {
                                                       cubit.imagePicker(ImageSource.camera, 'frontIdPath') ;               
                                },
                                child:
                                cubit.frontIdPath == null ?
                                 Container(
                                  width: double.infinity,
                                  
                                height:200,
                                decoration:  BoxDecoration(  color:AppColors.primaryColor,),
                                child:const Icon(Icons.image, size: 40,),
                                ) :  Container(
                                  width: double.infinity,
                                 
                                  height:200,
                                decoration:  BoxDecoration(  color:AppColors.primaryColor,),
                                 
                                  child: Image.file(File(cubit.frontIdPath!.path),) , 
                                  ),
                              ),
                           ),  
            /*     // صورة امامية للبطاقة     
                  FormBuilderImagePicker(
                             
                  name: 'gallery_images',
                  decoration: const InputDecoration(
                    labelText: 'front id',
                    labelStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                  ),
                  
                  maxImages: 1,  
                  iconColor: AppColors.primaryColor,
                  onChanged: (pickedImage) {
                     
                       
                      cubit.frontIdPath = pickedImage!.first;
                       
                    
                  },
                  
                ),
      */
                          
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                                        cubit.imagePicker(ImageSource.camera, 'backIdPath') ;               
                                },
                                child:
                                cubit.backIdPath == null ?
                                 Container(
                                  width: double.infinity,
                                  
                                  height:200,
                                decoration:  BoxDecoration(  color:AppColors.primaryColor,),
                                child:const Icon(Icons.image, size: 40,),
                                ) :  Container(
                                  width: double.infinity,
                                   
                                  height:200,
                                decoration:  BoxDecoration(  color:AppColors.primaryColor,),
                                
                                  child: Image.file(File(cubit.backIdPath!.path),) , 
                                  ),
                              ),
                            ), 
                 // صورة خلفية للبطاقة     
               /*   FormBuilderImagePicker(
                             
                  name: 'gallery_images',
                  decoration: const InputDecoration(
                    labelText: 'back id',
                    labelStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                  ),
                  
                  maxImages: 1,  
                  iconColor: AppColors.primaryColor,
                  onChanged: (pickedImage) {
                   
                      cubit.backIdPath = pickedImage!.first;
                         
      print('Selected Image Path: ${cubit.backIdPath?.path}');
                   
                  },
                
                ),
            */
            
            
                  
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            const SizedBox(height: 12,),
                             Row(
                               children: [
                                 InkWell(
                                  onTap: () {
                                     
                                  },
                                  child: const Text('forget password',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),)),
                               ],
                               
                             ),
                             const SizedBox(height: 24,),
                             Container(
                              width: double.infinity,
                              color: AppColors.primaryColor,
                               child: IconButton(
                                 
                                onPressed: (){
                                  if ( cubit.backIdPath != null ) {
                                     print(cubit.backIdPath!.name);
                                      print(cubit.backIdPath!.path);
                                  }       
                                 
                               
                                  if (signupkey.currentState!.validate()) {
                                     Map<String, dynamic> location = {
                                                  'name': nameController.text,
                                                   'address': addressController.text,
                                                  'coordinates':  [
                                                       latController.text,
                                                       langController.text,
                                                  ],
                                             };
      
                                      
      
                                    cubit.registerUser(name: nameController.text, email: emailController.text,
                                     password: passwordController.text, 
                                     confirmPassword: confirmPasswordController.text,
                                      location: location ,
                                       profilePicPath:   cubit.profileimage!,
                                        phone: phoneController.text, 
                                        brandName: brandNameController.text, 
                                        minCharge: minChargeController.text,
                                         disc: descController.text, 
                                         healthCertificate: cubit.healthCertificate!,
                                          frontIdPath: cubit.frontIdPath!,
                                           backIdPath:cubit.backIdPath!);
                                  
                                  }  
                                },  icon: state is SignUpLoadingState ? CircularProgressIndicator(color: AppColors.primaryColor,)  
                                : Text('Sign Up',
                                style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),),
                             ),
                        ],
                      );
                      },
                      
                    ),
                  ),
                  ),
            
            
            
            
            
            ]),
          ),
        
        
        
        ),
      
      );
      },
      
    );
  }
}
