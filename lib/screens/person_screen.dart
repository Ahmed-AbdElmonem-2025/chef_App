import 'package:flutter/material.dart';

import '../shared/app_colors.dart';

class PersonScreen extends StatelessWidget {
  const PersonScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            
            children: [
       
              const CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage('assets/images/logo.png'),
              ),
              const SizedBox(height: 15,),
              Text('Name: Ahmed AbdElmonem' ,style: TextStyle(color: AppColors.primaryColor,fontSize: 20,fontWeight: FontWeight.w600),),
              
          const SizedBox(height: 100,),
          
               Padding(
                 padding: const EdgeInsets.all(20.0),
                 child: SizedBox(
                          width: double.infinity,
                          child: TextButton(
                              style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                      AppColors.primaryColor)),
                               
                              onPressed: () {  },
                              child: Text(
                                'Update Account'
                                ,style: TextStyle(color: AppColors.black,fontSize: 18,fontWeight: FontWeight.w600),
                              ),),
                        ),
               ),
            ],
          ),
        ),
      ),
    );
  }
}