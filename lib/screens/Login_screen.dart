import 'package:chief_app/cubit/Auth_cubit.dart';
import 'package:chief_app/cubit/auth_states.dart';
import 'package:chief_app/screens/home_screen.dart';
import 'package:chief_app/shared/app_colors.dart';
import 'package:chief_app/widgets/custom_text_field.dart';
import 'package:chief_app/widgets/navigation_widgets.dart';
import 'package:chief_app/widgets/toast_message_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> Fkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<AuthCubit>(context);
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
              const SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  key: Fkey,
                  child: BlocConsumer<AuthCubit, AuthStates>(
                    listener: (context, state) {
                      if (state is LoginSuccessState) {
                        showSnackBarItem('success', context, true);
                        navigateTopush(context: context, wiget: const HomeScreen());
                      } else if(state is LoginErrorState) {
                         showSnackBarItem(state.errorMsg, context, false);
                      }
                    },
                    builder: (context, state) {
                      return Column(
                        children: [
                          CustomTextField(
                            controller: emailController,
                            hintText: 'Email',
                            validator: (data) {
                              if (data!.isEmpty) {
                                return 'email not valid';
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            controller: passwordController,
                            hintText: 'password',
                            validator: (data) {
                              if (data!.length < 6) {
                                return 'password not valid';
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          const Row(
                            children: [
                              Text('forget password'),
                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  foregroundColor: AppColors.white,
                                ),
                                onPressed: () {
                                  
                                  if (Fkey.currentState!.validate()) {
                                    cubit.login(
                                      email: emailController.text,
                                      password: passwordController.text);

                                  } else {}
                                },
                                child: state is LoginLoadingState ? CircularProgressIndicator(color: AppColors.black,) : const Text(
                                   'Login',
                                  style: TextStyle(fontSize: 22),
                                )),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
