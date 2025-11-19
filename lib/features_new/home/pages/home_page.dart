import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:taxiapp_mobile/features/profile/providers/profile_providers.dart';
import '../../../core/exceptions/coded_exception.dart';
import '../../../router/routes.dart';
import '../../../shared/theme/app_theme.dart';
import '../../../shared/widgets/bottom_modal.dart';
import '../../../shared/widgets/button.dart';
import '../../../shared/widgets/home/action_button.dart';
import '../../../shared/widgets/home/recent_tile.dart';
import '../../../shared/widgets/home/stat_card.dart';
import '../../../shared/widgets/padding.dart';
import '../../../shared/widgets/placeholders/placeholder_content.dart';
import '../../../translations/locale_keys.g.dart';
import '../providers/get_notifications_providers.dart';
import '../providers/inspection_provider.dart';
import '../providers/time_logs_providers.dart';
import '../widgets/download_filter.dart';
import '../widgets/inspection.dart';
import '../widgets/time_tracker.dart';
import '../widgets/timeline_card.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. CUSTOM HEADER SECTION
              _buildHeader(context, ref),

              const SizedBox(height: 24),

              ref.watch(assignedVehicleProvider).when(
                data: (vehicle) {
                  if (vehicle != null) {
                    return const Column(
                      children: [
                        TimeTracker(),
                        VerticalSpace(space: 30),
                      ],
                    );
                  } else {
                    return Container(
                      height: 180.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Center(
                        child: Text(
                          LocaleKeys.no_vehicle_assigned.tr(),
                          style: Theme.of(context)
                              .primaryTextTheme
                              .displaySmall
                              ?.copyWith(color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }
                },
                error: (error, stackTrace) {
                  return Text(error.toString());
                },
                loading: () {
                  return const Center(child: CircularProgressIndicator());
                },
              ),
              Consumer(
                builder: (_, ref, __) {
                  final inspection = ref.watch(hasInspectionProvider);

                  return inspection.maybeWhen(
                    data: (data) {
                      if (data == null || data.completed) {
                        return const SizedBox.shrink();
                      } else {
                        return Column(
                          children: [
                            Inspection(
                              inspectionId: data.id,
                              vehicleId: data.vehicleId,
                            ),
                            const VerticalSpace(space: 30),
                          ],
                        );
                      }
                    },
                    orElse: () => const SizedBox.shrink(),
                  );
                },
              ),
              // 2. STATS OVERVIEW CARDS
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Overview",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        StatCard(title: "Balance", count: "12", color: Colors.blueAccent, surfaceColor: surfaceColor),
                        SizedBox(width: 12),
                        StatCard(title: "Pending", count: "2", color: Colors.orangeAccent, surfaceColor: surfaceColor),
                        SizedBox(width: 12),
                        StatCard(title: "Approved", count: "8", color: Colors.green, surfaceColor: surfaceColor),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // 3. QUICK ACTIONS GRID
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Quick Actions",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 3, // 3 buttons per row
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 1.1,
                      children: const [
                        ActionButton(icon: Icons.add_circle_outline, label: "Apply Leave", primaryColor: primaryColor),
                        ActionButton(icon: Icons.history, label: "History", primaryColor: primaryColor),
                        ActionButton(icon: Icons.calendar_today, label: "Calendar", primaryColor: primaryColor),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // 4. RECENT ACTIVITY LIST
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Recent Activity",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text("View All"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const RecentTile(title: "Sick Leave", status: "Pending Approval", date: "Oct 24", statusColor: Colors.orange),
                    const RecentTile(title: "Casual Leave", status: "Approved", date: "Oct 12", statusColor: Colors.green),
                    const RecentTile(title: "Emergency", status: "Rejected", date: "Sep 30", statusColor: Colors.red),
                    const SizedBox(height: 80), // Bottom padding for nav bar
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                     Text(
                LocaleKeys.driver_logs.tr(),
                style: Theme.of(context).primaryTextTheme.displayMedium,
              ),
              const VerticalSpace(space: 15),
              Row(
                children: [
                  Flexible(
                    child: Button(
                      label: LocaleKeys.view_all.tr(),
                      onPressed: () {
                        context.push(Routes.driverHours);
                      },
                    ),
                  ),
                  const HorizontalSpace(space: 15),
                  Flexible(
                    child: Button(
                      label: LocaleKeys.download.tr(),
                      onPressed: () {
                        showBottomModal(
                          context: context,
                          height: 280.w,
                          child: const DownloadFilter(),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const VerticalSpace(space: 30),
              Text(
                LocaleKeys.today_hours.tr(),
                style: Theme.of(context).primaryTextTheme.displayMedium,
              ),
              const VerticalSpace(space: 20),
              const _TodayHours(),
                  ],
                )
              )
            ],
          ),
        ),
      ),
    );
  }

  // --- WIDGET BUILDERS ---

  Widget _buildHeader(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.grey.shade200,
            backgroundImage: const NetworkImage("https://i.pravatar.cc/150?img=11"), // Placeholder
          ),
          const SizedBox(width: 16),
          // Greeting
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Good Morning,",
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                ),
                 Text(
                  profile.when(
                    data: (data) => data.employee?.name ?? 'User',
                    loading: () => 'Loading...',
                    error: (err, stack) => 'Error',
                  ),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          // Notification Icon
          GestureDetector(
            onTap: () => context.push(Routes.notifications),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: const Icon(Icons.notifications_outlined, color: primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}

class _TodayHours extends ConsumerWidget {
  const _TodayHours({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayLog = ref.watch(todayLogProvider);

    return todayLog.when(
      data: (timeline) {
        if (timeline.isEmpty) {
          return Center(
            child: Text(
              LocaleKeys.not_started_working.tr(),
              style: Theme.of(context).primaryTextTheme.displaySmall!.copyWith(
                    color: Colors.grey,
                  ),
            ),
          );
        }

        return ListView.separated(
          itemCount: timeline.length,
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return TimelineCard(
              index: index,
              length: timeline.length,
              timeline: timeline[index],
            );
          },
          separatorBuilder: (context, index) {
            return const VerticalSpace(space: 1);
          },
        );
      },
      error: (error, stackTrace) {
        final e = error as CodedException;
        return PlaceholderContent(
          message: e.getString(context),
        );
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
