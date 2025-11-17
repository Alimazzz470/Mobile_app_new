class Routes {
  static const splash = '/';
  static const signIn = '/login';
  static const bottomNav = '/bottom-nav';
  static const home = '/home';
  static const leaves = '/leaves';
  static const chats = '/messages';
  static const chatDetails = 'chat/:id';
  static const create_chat = '/create-chat';
  static const profile = '/profile';
  static const driverHours = '/driver-hours';
  static const allLeave = '/all-leaves';
  static const logDetails = '/log-details';
  static const advance = '/advanceList';
  static const advancesDetails = 'advance/:id';
  static const deduction = '/deductionList';
  static const deductionsDetails = 'deduction/:id';
  static const penalty = '/penaltyList';
  static const penaltyDetails = 'penalty/:id';
  static const bonus = '/bonusList';
  static const bonusesDetails = 'bonus/:id';
  static const requestVehicle = '/request-car';
  static const returnVehicle = '/return-car';
  static const monthlyInspection = '/monthly-inspection';
  static const signature = '/signature';
  static const requestVehicleInspection = '/request-vehicle-inspection';
  static const editProfile = '/edit-profile';
  static const notifications = '/notifications';
  static const requestLeave = '/request-leave';
  static const requestAdvance = '/request-advance';
  static const todoTasks = '/todo-tasks';
  static const taskDetails = 'task/:id';
  static const imageSlider = '/image-slider';

  // to be used with context go
  static String chatDetailsUri(String id) => "$chats/chat/$id";
  static String taskDetailsUri(String id) => "$todoTasks/task/$id";
  static String penaltyDetailsUri(String id) => "$penalty/penalty/$id";
  static String advanceDetailsUri(String id) => "$advance/advance/$id";
  static String deductionDetailsUri(String id) => "$deduction/deduction/$id";
  static String bonusDetailsUri(String id) => "$bonus/bonus/$id";
  static String chatDetailsUriWithId(String id) => "$chats/chat/$id";
}
