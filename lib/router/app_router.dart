import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:taxiapp_mobile/features/profile/pages/advance/advance_details.dart';
import 'package:taxiapp_mobile/features/profile/pages/bonus/bonus_details.dart';
import 'package:taxiapp_mobile/features/profile/pages/deductions/deduction_details.dart';
import 'package:taxiapp_mobile/features/profile/pages/penalty/penalty_details.dart';
import 'package:taxiapp_mobile/features/profile/pages/penalty/penalty_page.dart';
import 'package:taxiapp_mobile/features/profile/pages/request_advance_page.dart';
import 'package:taxiapp_mobile/features/todo_tasks/pages/todo_task_details.dart';
import 'package:taxiapp_mobile/features/todo_tasks/pages/todo_tasks_page.dart';
import 'package:taxiapp_mobile/shared/widgets/image_slider.dart';

import '../core/dto/image_slider.dart';
import '../core/dto/inspection.dart';
import '../core/entities/chat/chat_details.dart';
import '../core/entities/time_tracking/driver_logs.dart';
import '../features/auth/pages/sign_in_page.dart';
import '../features/auth/pages/splash_page.dart';
import '../features/bottom_nav/pages/bottom_nav_page.dart';
import '../features/chat/pages/chat_details_page.dart';
import '../features/chat/pages/chat_list_page.dart';
import '../features/chat/pages/create_chat_page.dart';
import '../features/home/pages/driving_hours_page.dart';
import '../features/home/pages/home_page.dart';
import '../features/home/pages/log_details_page.dart';
import '../features/home/pages/notifications_page.dart';
import '../features/home/pages/request_vehicle_inspection_page.dart';
import '../features/leaves/dto/leaves_filter.dart';
import '../features/leaves/pages/all_leave_page.dart';
import '../features/leaves/pages/leaves_page.dart';
import '../features/leaves/pages/request_leave_page.dart';
import '../features/profile/pages/advance/advance_page.dart';
import '../features/profile/pages/bonus/bonus_page.dart';
import '../features/profile/pages/deductions/deduction_page.dart';
import '../features/profile/pages/edit_profile_page.dart';
import '../features/profile/pages/monthly_inspection.dart';
import '../features/profile/pages/profile_page.dart';
import '../features/profile/pages/request_vehicle_page.dart';
import '../features/profile/pages/return_vehicle_page.dart';
import 'routes.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: "rootKey");

final appRoutes = <RouteBase>[
  GoRoute(path: Routes.bottomNav, redirect: (_, __) => Routes.splash),
  GoRoute(
    path: Routes.splash,
    builder: (context, state) => const SplashPage(),
  ),
  GoRoute(
    path: Routes.signIn,
    builder: (context, state) => const SignInPage(),
  ),
  GoRoute(
    parentNavigatorKey: rootNavigatorKey,
    path: Routes.driverHours,
    builder: (_, state) => const DrivingHoursPage(),
  ),
  GoRoute(
    parentNavigatorKey: rootNavigatorKey,
    path: Routes.allLeave,
    builder: (_, state) {
      // get the extra param
      final filters = state.extra as LeavesFilterDto;

      // return the page with the id
      return AllLeavesPage(filters: filters);
    },
  ),
  GoRoute(
    parentNavigatorKey: rootNavigatorKey,
    path: Routes.logDetails,
    builder: (_, state) {
      // get the extra param
      final details = state.extra as DriverLog;

      // return the page with the id
      return LogDetailsPage(log: details);
    },
  ),
  GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: Routes.advance,
      builder: (_, __) => const AdvancePage(),
      routes: [
        GoRoute(
          parentNavigatorKey: rootNavigatorKey,
          path: Routes.advancesDetails,
          builder: (_, state) => AdvanceDetailsScreen(
            advanceId: state.pathParameters['id'] ?? '',
          ),
        ),
      ]),
  GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: Routes.deduction,
      builder: (_, __) => const DeductionPage(),
      routes: [
        GoRoute(
          parentNavigatorKey: rootNavigatorKey,
          path: Routes.deductionsDetails,
          builder: (_, state) => DeductionDetailsScreen(
            deductionId: state.pathParameters['id'] ?? '',
          ),
        ),
      ]),
  GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: Routes.bonus,
      builder: (_, __) => const BonusPage(),
      routes: [
        GoRoute(
          parentNavigatorKey: rootNavigatorKey,
          path: Routes.bonusesDetails,
          builder: (_, state) => BonusDetailsScreen(
            bonusId: state.pathParameters['id'] ?? '',
          ),
        ),
      ]),
  GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: Routes.penalty,
      builder: (_, __) => const PenaltyPage(),
      routes: [
        GoRoute(
          parentNavigatorKey: rootNavigatorKey,
          path: Routes.penaltyDetails,
          builder: (_, state) => PenaltyDetailsScreen(
            penaltyId: state.pathParameters['id'] ?? '',
          ),
        ),
      ]),
  GoRoute(
    parentNavigatorKey: rootNavigatorKey,
    path: Routes.imageSlider,
    builder: (_, state) {
      final images = state.extra as ImageSliderDto;

      return ImageSlider(
        listImagesModel: images,
      );
    },
  ),
  GoRoute(
    parentNavigatorKey: rootNavigatorKey,
    path: Routes.requestVehicle,
    builder: (_, __) => const RequestVehiclePage(),
  ),
  GoRoute(
    parentNavigatorKey: rootNavigatorKey,
    path: Routes.notifications,
    builder: (_, __) => const NotificationsPage(),
  ),
  GoRoute(
    parentNavigatorKey: rootNavigatorKey,
    path: Routes.returnVehicle,
    builder: (_, state) {
      // get the extra param
      final id = state.extra as String;

      // return the page with the id
      return ReturnVehiclePage(vehicleId: id);
    },
  ),
  GoRoute(
    parentNavigatorKey: rootNavigatorKey,
    path: Routes.create_chat,
    builder: (_, state) => const CreateChatPage(),
  ),
  GoRoute(
    parentNavigatorKey: rootNavigatorKey,
    path: Routes.monthlyInspection,
    builder: (_, state) {
      // get the extra param
      final dto = state.extra as InspectionDto;

      // return the page with the id
      return InspectionPage(dto: dto);
    },
  ),
  GoRoute(
    parentNavigatorKey: rootNavigatorKey,
    path: Routes.requestVehicleInspection,
    builder: (_, state) {
      // get the extra param
      final dto = state.extra as InspectionDto;

      // return the page with the id
      return RequestVehicleInspectionPage(dto: dto);
    },
  ),
  GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: Routes.requestLeave,
      builder: (_, __) => const RequestLeavePage()),
  GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: Routes.requestAdvance,
      builder: (_, __) => const RequestAdvancePage()),
  GoRoute(
    parentNavigatorKey: rootNavigatorKey,
    path: Routes.editProfile,
    builder: (_, state) => const EditProfilePage(),
  ),
  GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: Routes.chats,
      builder: (_, __) => const ChatListPage(),
      routes: [
        GoRoute(
          parentNavigatorKey: rootNavigatorKey,
          path: Routes.chatDetails,
          builder: (_, state) {
            // return the page with the id
            return ChatDetailsPage(chatId: state.pathParameters['id']!);
          },
        ),
      ]),
  StatefulShellRoute.indexedStack(
    builder: (_, __, shell) => BottomNavPage(navigationShell: shell),
    branches: <StatefulShellBranch>[
      StatefulShellBranch(
        routes: <RouteBase>[
          GoRoute(
            path: Routes.home,
            builder: (_, __) => const HomePage(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: <RouteBase>[
          GoRoute(
            path: Routes.leaves,
            builder: (_, __) => const LeavesPage(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: <RouteBase>[
          GoRoute(
              path: Routes.todoTasks,
              builder: (_, __) => const TodoTaskPage(),
              routes: [
                GoRoute(
                  path: Routes.taskDetails,
                  builder: (_, state) => TodoTaskDetails(
                    taskId: state.pathParameters['id']!,
                  ),
                ),
              ]),
        ],
      ),
      StatefulShellBranch(
        routes: <RouteBase>[
          GoRoute(
            path: Routes.profile,
            builder: (_, __) => const ProfilePage(),
          ),
        ],
      ),
    ],
  ),
];
