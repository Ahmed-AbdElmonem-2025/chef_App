import 'package:chief_app/cubit/Auth_cubit.dart';
import 'package:chief_app/cubit/auth_states.dart';
import 'package:chief_app/screens/Login_screen.dart';
import 'package:chief_app/shared/app_colors.dart';
import 'package:chief_app/widgets/custom_text_field.dart';
import 'package:chief_app/widgets/navigation_widgets.dart';
import 'package:chief_app/widgets/toast_message_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordScreen extends StatelessWidget {
  TextEditingController codeController = TextEditingController();
 TextEditingController emailController = TextEditingController();
  TextEditingController newpasswordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  @override
  GlobalKey<FormState> key = GlobalKey<FormState>();
    ResetPasswordScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('creat new password',style: TextStyle(color:AppColors.white),),
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: BlocConsumer<AuthCubit,AuthStates>(
            listener: (context, state) {
              if(state is ResetPasswordSuccessState){
                // show message
                showSnackBarItem('Success', context, true);
                // Navigate to 
                navigateTopush(context: context, wiget: LoginScreen());
                 
              }
            },
            builder: (context, state) {
              return  Form(
              key: key,
              child: Column(
                children: [
                  const Padding(
                    padding:   EdgeInsets.only(top: 40,bottom: 24,),
                    child: Image(image: AssetImage('assets/images/lock.png'),),
                  ),
                  const Text('creat new password'),
                    
                    // password
                   CustomTextField(controller: newpasswordController,
                   hintText: 'code',
                    validator: (data) {
                      if (data!.length <6 || data.isEmpty ){
                        return 'please enter valid password';
                      } else {
                        return null;
                      }
                    },
                   ),


                    // confirm password
                   CustomTextField(controller: confirmpasswordController,
                   hintText: 'confirm password',
                    validator: (data) {
                      if (  data != newpasswordController.text ){
                        return 'please enter valid password';
                      } else {
                        return null;
                      }
                    },
                   ),
                    // code
                  CustomTextField(controller: codeController,
                  hintText: 'code',
                    validator: (data) {
                      if (num.tryParse(data!)== null) {
                         return 'please enter valid code';
                      }
                      if (data.length <6 || data.isEmpty){
                        return 'please enter valid code';
                      } else {
                        return null;
                      }
                    },
                   ),
                   Container(
                    color: AppColors.primaryColor,
                    width: double.infinity,
                     child: state is ResetPasswordLoadingState ?  const CircularProgressIndicator()  : 
                     ElevatedButton(
                      
                      onPressed: (){
                          if (key.currentState!.validate()) {
                          BlocProvider.of<AuthCubit>(context).resetpassword(email: emailController.text, password: newpasswordController.text, confirmpassword: confirmpasswordController.text, code: codeController.text);
                        }  
                        ////////////////////////
                      }, 
                     child: const Text('creat new password',style:TextStyle(color: Colors.white,),),),
                   ),
                ],
              ),
            );
            },
           
          ),
        ),
      ),
    );
  }
}