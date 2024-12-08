
abstract class MenuState {}

class InitialMenuState extends MenuState {}


class ChangedItemState extends MenuState {}



class  ChangeGroupState extends MenuState {}


class  AddDishLoadingState extends MenuState {}
class  AddDishSucessState extends MenuState {}
class  AddDishErrorState extends MenuState {
 final String err;

  AddDishErrorState({required this.err});
}





class  DeleteDishLoadingState extends MenuState {}
class  DeleteDishSucessState extends MenuState {}
class  DeleteDishErrorState extends MenuState {}






class  GetAllChefMealsLoadingState extends MenuState {}
class  GetAllChefMealsSucessState extends MenuState {}
class  GetAllChefMealsErrorState extends MenuState {}














class MenuImageUpdatedState extends MenuState{}