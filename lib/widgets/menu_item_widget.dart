import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/menu_cubit/menu_cubit.dart';
import '../models/meal_model.dart';
import '../shared/app_colors.dart';

Widget MenuItem(
  BuildContext context,
  MealModel model,
) {
  return Row(
    children: [
      SizedBox(height: 60, width: 60, child: Image.network(model.images[0])),
      const SizedBox(
        width: 8,
      ),
      //Spacer(),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              constraints: const BoxConstraints(maxWidth: 190),
              child: Text(model.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black))),
          Container(
              constraints: const BoxConstraints(maxWidth: 150),
              child: Text(model.description,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor))),
          Text("${model.price.toString()} \$",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor)),
        ],
      ),
      const Spacer(),
      TextButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(
                  'delete meal',
                  style: TextStyle(color: AppColors.black),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      BlocProvider.of<MenuCubit>(context)
                          .deleteMeal(id: model.id);
                      Navigator.pop(context);
                    },
                    child: const Text('ok'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(
          Icons.cancel,
          size: 40,
          color: Colors.red,
        ),
      ),
    ],
  );
}
