import 'package:fitness_fusion/dataclass/FeedBack.dart';
import 'package:fitness_fusion/dataclass/FoodItem.dart';
import 'package:fitness_fusion/dataclass/Keyword.dart';
import 'package:fitness_fusion/dataclass/Plan.dart';
import 'package:fitness_fusion/dataclass/Exercises.dart';
import 'package:fitness_fusion/dataclass/User.dart';

late List<FoodItem> All_Food_Items = [];
late List<List<Exercises>> All_Exercises = List.generate(6, (row) => []);
late User MyUser;

late WorkoutPlan MyWorkoutPlan;
late DietPlan MyDietPlan;

late List<TrainerPlans> trainerPlans = [];
late List<Keyword> All_Keywords = [];
late List<UserFeedback> All_Feedbacks = [];
late List<User> Requests= [];
late List<WorkoutPlan> AllWorkoutPlans = [];
late List<DietPlan> AllDietPlans= [];

