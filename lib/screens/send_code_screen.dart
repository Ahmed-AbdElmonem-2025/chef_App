 
import 'package:chief_app/cubit/Auth_cubit.dart';
import 'package:chief_app/cubit/auth_states.dart';
import 'package:chief_app/screens/reset_password_screen.dart';
import 'package:chief_app/shared/app_colors.dart';
import 'package:chief_app/widgets/custom_text_field.dart';
import 'package:chief_app/widgets/navigation_widgets.dart';
import 'package:chief_app/widgets/toast_message_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendCodeScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
   GlobalKey<FormState> sendcodekey = GlobalKey<FormState>();
    SendCodeScreen({ Key? key }) : super(key: key);
    
    
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('forget password',style: TextStyle(color:AppColors.white),),
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: BlocConsumer<AuthCubit,AuthStates>(
            listener: (context, state) {
              if(state is SendCodeSuccessState){
                // show message
                showSnackBarItem('Success', context, true);
                // Navigate to 
                navigateTopush(context: context, wiget: ResetPasswordScreen());
                 
              }
            },
            builder: (context, state) {
              return  Form(
              key: sendcodekey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding:   EdgeInsets.only(top: 40,bottom: 24,),
                    child: Image(image: AssetImage('assets/images/lock.png'),),
                  ),
                  const Text('send reset code',style:TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w500),),
                    
                  CustomTextField(controller: emailController,
                  hintText: 'email',
                    validator: (data) {
                      if (data!.isEmpty || !data.contains('@gmail.com')){
                        return 'please enter valid email';
                      } else {
                        return null;
                      }
                    },
                   ),
                   const SizedBox(height: 40,),
                   SizedBox(
                    width: double.infinity,
                     height: 50,
                     child: state is SendCodeLoadingState ?  const CircularProgressIndicator()  : 
                     ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor),
                      onPressed: (){
                        if (sendcodekey.currentState!.validate()) {
                          BlocProvider.of<AuthCubit>(context).sendCode(email: emailController.text);
                        } 
                        ////////////////////////
                      }, 
                     child: const Text('Send code',style:TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600),),),
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