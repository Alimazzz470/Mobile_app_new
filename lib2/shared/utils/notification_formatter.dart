import 'package:taxiapp_mobile/translations/locale_keys.g.dart';

import '../../core/entities/notifications/notifications.dart';

formatDescription({required Notifications notifications}) {
  // return a string based on the type using case
  switch (notifications.type) {
    case 'TODO_TASK_CREATED':
      return 'A new task of type ${notifications.meta.description.arguments['title']} has been created for you';
    case 'TODO_TASK_STATUS_UPDATED':
      return 'task number {taskNumber} has been updated';
    case 'VEHICLE':
      return 'A new vehicle inspection for vehicle ${notifications.meta.description.arguments['vehicleNumber']} is available, please complete it.';
    case 'LEAVE_CREATED':
      return notifications.meta.description.arguments['toDate'] == null ||
              notifications.meta.description.arguments['toDate'].isEmpty
          ? 'A new leave has been created for you on ${notifications.meta.description.arguments['fromDate']}'
          : 'A new leave has been created for you from ${notifications.meta.description.arguments['fromDate']} to ${notifications.meta.description.arguments['toDate']}';
    case 'LEAVE_UPDATED':
      return 'Your Leave with description ${notifications.meta.description.arguments['reason']} has been updated';
    case "ADVANCE_STATUS_UPDATED":
      return "Your advance for €${notifications.meta.description.arguments['amount']} has been ${notifications.meta.description.arguments['approved'] == "true" ? "Approved" : "Rejected"}";
    case "DEDUCTION":
      return "You have received a new ${notifications.meta.description.text == "PENALTY" ? 'Penalty' : 'Deduction'} of €${notifications.meta.description.arguments['amount']} from your Salary";
    case "BONUS":
      return "You have received a bonus of €${notifications.meta.description.arguments['amount']} to your Salary";
    default:
      return 'default';
  }
}

String mapBackendKeyToLocaleKey(String backendKey) {
  // Define a mapping logic here
  switch (backendKey) {
    case "leave_created_title":
      return LocaleKeys.notifications_leave_created_title;
    case "leave_created_body":
      return LocaleKeys.notifications_leave_created_body;
    case "leave_owner_created_body":
      return LocaleKeys.notifications_leave_owner_created_body;
    case "leave_updated_title":
      return LocaleKeys.notifications_leave_updated_title;
    case "leave_updated_body":
      return LocaleKeys.notifications_leave_updated_body;
    case "leave_owner_updated_body":
      return LocaleKeys.notifications_leave_owner_updated_body;
    case "leave_status_updated_title":
      return LocaleKeys.notifications_leave_status_updated_title;
    case "leave_status_updated_body":
      return LocaleKeys.notifications_leave_status_updated_body;
    case "vehicle_inspection_title":
      return LocaleKeys.notifications_vehicle_inspection_title;
    case "vehicle_inspection_body":
      return LocaleKeys.notifications_vehicle_inspection_body;
    case "deduction_title":
      return LocaleKeys.notifications_deduction_title;
    case "deduction_body":
      return LocaleKeys.notifications_deduction_body;
    case "penalty_title":
      return LocaleKeys.notifications_penalty_title;
    case "penalty_body":
      return LocaleKeys.notifications_penalty_body;
    case "advance_title":
      return LocaleKeys.notifications_advance_title;
    case "advance_body":
      return LocaleKeys.notifications_advance_body;
    case "advance_status_updated_title":
      return LocaleKeys.notifications_advance_status_updated_title;
    case "advance_status_updated_body":
      return LocaleKeys.notifications_advance_status_updated_body;
    case "bonus_title":
      return LocaleKeys.notifications_bonus_title;
    case "bonus_body":
      return LocaleKeys.notifications_bonus_body;
    case "task_created_title":
      return LocaleKeys.notifications_task_created_title;
    case "task_created_body":
      return LocaleKeys.notifications_task_created_body;
    case "task_updated_title":
      return LocaleKeys.notifications_task_updated_title;
    case "task_updated_body":
      return LocaleKeys.notifications_task_updated_body;
    case "task_status_updated_title":
      return LocaleKeys.notifications_task_status_updated_title;
    case "task_status_updated_body":
      return LocaleKeys.notifications_task_status_updated_body;
    case "new_message":
      return LocaleKeys.notifications_new_message;
    case "new_message_body":
      return LocaleKeys.notifications_new_message_body;
    // Add more cases as needed
    default:
      // If no mapping is found, return the original key
      return backendKey;
  }
}

formatType({required Notifications notifications}) {
  // return a string based on the type using case
  switch (notifications.type) {
    case 'TODO_TASK_CREATED':
      return 'Task Created';
    case 'TODO_TASK_STATUS_UPDATED':
      return 'Task Updated';
    case 'VEHICLE':
      return 'Vehicle Inspection';
    case 'LEAVE_CREATED':
      return 'Leave Created';
    case 'LEAVE_UPDATED':
      return 'Leave Updated';
    case "ADVANCE_STATUS_UPDATED":
      return "Advance ${notifications.meta.description.arguments['approved'] == "true" ? "Approved" : "Rejected"}";
    case "DEDUCTION":
      return "${notifications.meta.description.text == "PENALTY" ? 'Penalty' : 'Deduction'} Received";
    case "BONUS":
      return "Bonus Received";
    default:
      return 'default';
  }
}
