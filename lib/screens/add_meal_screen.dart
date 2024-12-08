import 'dart:io';

import 'package:chief_app/cubit/menu_cubit/menu_cubit.dart';
import 'package:chief_app/cubit/menu_cubit/menu_states.dart';
import 'package:chief_app/shared/app_colors.dart';
import 'package:chief_app/widgets/custom_text_field.dart';
import 'package:chief_app/widgets/toast_message_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';


class AddMealScreen extends StatefulWidget {
    const AddMealScreen({ Key? key }) : super(key: key);

  @override
  State<AddMealScreen> createState() => _AddMealScreenState();
  
}

class _AddMealScreenState extends State<AddMealScreen> {
  @override
  void initState() {
     
    super.initState();
   // BlocProvider.of<MenuCubit>(context).addMeal();
  }
   TextEditingController nameController = TextEditingController();

   TextEditingController priceController = TextEditingController();

   TextEditingController descController = TextEditingController();

   GlobalKey<FormState> addmealkey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
   var cubit=BlocProvider.of<MenuCubit>(context);
    return   Scaffold(
      appBar: AppBar(title: const Text('Add dish to menu'),),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Center(
            child: BlocConsumer<MenuCubit,MenuState>(
              listener: (context, state) {
                if (state is AddDishSucessState) {
                  showSnackBarItem('meal added successfully', context, true);
                   print('addddddddddddddddddddddddddddddddddddddddddded');
                  Navigator.pop(context);
                } else if (state is AddDishErrorState){
                   showSnackBarItem('meal not added ', context, false);
                }
              },
              builder: (context, state) {
                return Form(
                key:addmealkey ,
                child: Column(
                  children: [
                    Stack(
                      children:[
                         // عرض الصورة إذا كانت موجودة
                        cubit.myimage != null
                            ? Image.file(File(cubit.myimage!.path)) // لو الصورة موجودة
                            : Image.asset('assets/images/imagepicker.png'), // الصورة الإفتراضية
                       
                       Positioned.directional(
                        textDirection: Directionality.of(context),
                        bottom: -8,
                        end:-8,
                        child: IconButton(onPressed: (){
                           showDialog(context: context, builder: (context) {
                             return Dialog(
                              
                               backgroundColor: AppColors.black,
                               shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                               ),
                               child:Column(
                                mainAxisSize:MainAxisSize.min,
                                children:[
                                  ListTile(
                                    leading:Icon(Icons.camera_alt,color: AppColors.primaryColor,) ,
                                    title: Text('camera',style: TextStyle(color: AppColors.primaryColor),
                                    ),
                                     onTap: () {
                                     cubit.imagePicker(ImageSource.camera)
                                                .then((value) {
                                              // الصورة تم التقاطها
                                              if (value != null) {
                                                cubit.myimage = value;
                                                 Navigator.pop(context);
                                              }
                                      });
                                    },
                                  ),
                                  ListTile(
                                    leading:Icon(Icons.camera_alt,color: AppColors.primaryColor,) ,
                                    title: Text('gallery',style: TextStyle(color: AppColors.primaryColor),
                                    ),
                                    onTap: () {
                                       cubit.imagePicker(ImageSource.camera)
                                                .then((value) {
                                              // الصورة تم التقاطها
                                              if (value != null) {
                                                cubit.myimage = value;
                                                 Navigator.pop(context);
                                              }
                                      });
                                    },
                                  ),
                        
                                ],
                               ) ,
                             );
                           },);
                        },
                         icon: const Icon(Icons.add,size: 35,),
                         ),
                         ),
                        
                      ],
                    
                    
                           
                    ),
                    const SizedBox(height: 16,),
                    CustomTextField(controller: nameController,
                    hintText: 'meal name',
                    validator: (data) {
                      if (data!.isEmpty) {
                        return 'please Enter valid name';
                      } else {
                        return null;
                      }
                    },
                    ),
              
                    const SizedBox(height: 16,),
                    CustomTextField(controller: priceController,
                    hintText: 'meal price',
                    validator: (data) {
                      if (data!.isEmpty) {
                        return 'please Enter valid price';
                      } else {
                        return null;
                      }
                    },
                    ),
              
              
                    const SizedBox(height: 16,),
                    CustomTextField(controller: descController,
                    hintText: 'meal description',
                    validator: (data) {
                      if (data!.isEmpty) {
                        return 'please Enter valid meal description';
                      } else {
                        return null;
                      }
                    },
                    ),
                     const SizedBox(height: 16,),
                      
                      SizedBox(
                        height: 48,
                        width: double.infinity,
                        child: DropdownButton(
                          value: BlocProvider.of<MenuCubit>(context).selectedItem,
                          hint: const Text('Beef'),
                          items: BlocProvider.of<MenuCubit>(context).categoryList.map((e){
                            return DropdownMenuItem(child: Text(e),value: e,);
                          }).toList(),
                          onChanged: (value) {
                            BlocProvider.of<MenuCubit>(context).changeItem(value);
                          },
                         ),
                      ),
                      const SizedBox(height: 16,),


                      Row(
                        children:[
                          Row(
                            children:[
                              Radio(
                                activeColor:AppColors.primaryColor ,
                                value:'quantity' , 
                                groupValue: cubit.groupValu, 
                                onChanged: (val){
                                         cubit.changeGroupVal(val);
                                }),
                               const Text('quantity'),

                               
                              ],


                   

                          ),
                              const Spacer(),
                            Row(
                              children: [
                                Radio(
                                    activeColor:AppColors.primaryColor ,
                                    value:'number' , 
                                    groupValue: cubit.groupValu, 
                                    onChanged: (val){
                                    cubit.changeGroupVal(val);
                                    }),


                                  const Text('number'),
                              ],
                            ),

                        ],
                      ),

                     const SizedBox(height: 16,),
                     TextButton(
                             
                            onPressed: (){
                          if (addmealkey.currentState!.validate()) {
                            
                            cubit.addMeal(
                               mealImage: cubit.myimage!, 
                              mealName: nameController.text, 
                              mealDesc: descController.text, 
                              mealCategory: cubit.selectedItem, 
                              howToSell: cubit.groupValu, 
                              mealPrice:double.parse(priceController.text));
                              
                          } else {
                            print('ppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppp');
                          }
                            
                              
                            }, child: const Text('Add to menu')),
                  ],
                ),
              );
              },

              
            ),
          ),
        ),
      ) ,
    );
  }
}

 