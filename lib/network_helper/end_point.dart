class EndPoint {
  
static String baseUrl = 'https://food-api-omega.vercel.app/api/v1/';


static String loginEndpoint  = 'chef/signin/';
static String signupEndpoint  = 'chef/signup/';

static String sendCodeEndpoint  = '';

static String changeForgottenPassword  = '';

static String addMeal  = 'meal/add-to-menu';

static String deleteMeal  = 'meal/delete-meal';


static String getAllChefMeals(String id)  => 'chef/get-chef/$id/meals';
}