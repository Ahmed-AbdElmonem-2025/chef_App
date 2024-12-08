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
TextEditingController phoneController = TextEditingController();
  
   TextEditingController confirmPasswordController = TextEditingController(); 
   TextEditingController locationController = TextEditingController();
    TextEditingController brandNameController = TextEditingController(); 
    TextEditingController minChargeController = TextEditingController();
     TextEditingController descController = TextEditingController();

     
      TextEditingController frontIdController = TextEditingController();
       TextEditingController backIdController = TextEditingController(); 
       TextEditingController profilePicController = TextEditingController();

   GlobalKey<FormBuilderState> key = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    var cubit =  BlocProvider.of<AuthCubit>(context,listen: true);
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
                  style: TextStyle(color: AppColors.white, fontSize: 15),
                )),
              ],
            ),
          
                Padding(
          padding: const EdgeInsets.all(14.0),
          child: FormBuilder(
                  key: key,
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
                             if (data!.length < 6) {
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
                             if (data!.length < 6) {
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
           
          
           
          
          
                           const SizedBox(height: 32,),
                          
                          
                          
                          
                          
                         
               // صورة امامية للبطاقة     
                FormBuilderImagePicker(
                           
                name: 'gallery_images',
                decoration: const InputDecoration(
                  labelText: 'Pick Images from Gallery',
                ),
                
                maxImages: 1,  
                iconColor: AppColors.primaryColor,
                onChanged: (pickedImage) {
                  setState(() {
                    cubit.idFront = pickedImage!.first;
                    frontIdController.text = cubit.idFront!;
                  });
                },
              
              ),
                          
               // صورة خلفية للبطاقة     
                FormBuilderImagePicker(
                           
                name: 'gallery_images',
                decoration: const InputDecoration(
                  labelText: 'Pick Images from Gallery',
                ),
                
                maxImages: 1,  
                iconColor: AppColors.primaryColor,
                onChanged: (pickedImage) {
                  setState(() {
                    cubit.idFront = pickedImage!.first;
                    backIdController.text = cubit.idFront!;
                  });
                },
              
              ),
          
          
          
                 // صورة  شخصية     
                FormBuilderImagePicker(
                           
                name: 'gallery_images',
                decoration: const InputDecoration(
                  labelText: 'Pick Images from Gallery',
                ),
                
                maxImages: 1,  
                iconColor: AppColors.primaryColor,
                onChanged: (pickedImage) {
                  setState(() {
                    cubit.idFront = pickedImage!.first;
                    profilePicController.text = cubit.idFront!;
                  });
                },
              
              ),
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          
                           const Row(
                             children: [
                               Text('forget password'),
                             ],
                             
                           ),
                           const SizedBox(height: 24,),
                           Container(
                            width: double.infinity,
                            color: AppColors.primaryColor,
                             child: IconButton(
                               
                              onPressed: (){
                                       
                               
                                if (key.currentState!.validate()) {
                                  
                                } else {
                                }
                              },  icon:const Text('Sign Up',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),),
                           )
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
  }
}
