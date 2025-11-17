import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:taxiapp_mobile/core/dto/image_slider.dart';
import '../../../core/services/image_helpers.dart';
import '../../../network/models/common/status_type_model.dart';
import '../../../router/routes.dart';
import '../../../shared/helpers/app_data.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/utils/date_time.dart';
import '../../../shared/widgets/button.dart';
import '../../../shared/widgets/padding.dart';
import '../../../shared/widgets/toast.dart';
import '../../../translations/locale_keys.g.dart';
import '../providers/todo_tasks_provider.dart';
import '../widgets/todo_tasks_widget.dart';

class TodoTaskDetails extends ConsumerStatefulWidget {
  final String taskId;

  const TodoTaskDetails({super.key, required this.taskId});

  @override
  ConsumerState<TodoTaskDetails> createState() => _TodoTaskDetailsState();
}

class _TodoTaskDetailsState extends ConsumerState<TodoTaskDetails> {
  @override
  Widget build(BuildContext context) {
    final task = ref.watch(getSingleTaskProvider(widget.taskId));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.task_details.tr(),
          style: Theme.of(context).primaryTextTheme.displayLarge,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            ref.invalidate(todoTasksProvider);
            context.pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 20.h),
          child: task.when(
            error: (error, stackTrace) {
              return Center(
                child: Text(
                  error.toString(),
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16.sp,
                  ),
                ),
              );
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            data: (todoTask) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VerticalSpace(
                      space: 20.h,
                    ),
                    Text(
                      LocaleKeys.title.tr(),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      todoTask.title,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: SECONDARY_TEXT_COLOR,
                      ),
                    ),
                    VerticalSpace(
                      space: 30.h,
                    ),
                    Text(
                      LocaleKeys.description.tr(),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      todoTask.description,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: SECONDARY_TEXT_COLOR,
                      ),
                    ),
                    VerticalSpace(
                      space: 30.h,
                    ),
                    Text(
                      LocaleKeys.created_date.tr(),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      '${DateTime.parse(todoTask.createdAt).dateText} ${DateTime.parse(todoTask.createdAt).timeText}',
                      style: TextStyle(
                          fontSize: 14.sp, color: SECONDARY_TEXT_COLOR),
                    ),
                    VerticalSpace(
                      space: 30.h,
                    ),
                    Text(
                      LocaleKeys.priority.tr(),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Container(
                      width: 180.w,
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.w,
                        vertical: 15.h,
                      ),
                      decoration: BoxDecoration(
                        color: getPriorityColor(priority: todoTask.priority)
                            .withOpacity(0.4),
                        borderRadius: BorderRadius.circular(5.r),
                        border: Border.all(
                          color: getPriorityColor(priority: todoTask.priority),
                          width: 1.5.w,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          todoTask.priority[0].toUpperCase() +
                              todoTask.priority.substring(1).toLowerCase(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color:
                                getPriorityColor(priority: todoTask.priority),
                          ),
                        ),
                      ),
                    ),
                    VerticalSpace(
                      space: 30.h,
                    ),
                    Text(
                      LocaleKeys.images_files.tr(),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    todoTask.urls.isNotEmpty
                        ? SizedBox(
                            height: 100.h,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: todoTask.urls.length,
                              itemBuilder: (context, index) {
                                return FutureBuilder<String>(
                                  future: getContentType(todoTask.urls[index]),
                                  builder: (context, snapshot) {
                                    return Padding(
                                      padding: EdgeInsets.only(right: 10.w),
                                      child: snapshot.hasData
                                          ? snapshot.data!.contains('image')
                                              ? GestureDetector(
                                                  onTap: () {
                                                    context.push(
                                                      Routes.imageSlider,
                                                      extra: ImageSliderDto(
                                                        images: todoTask.urls,
                                                        initialIndex: index,
                                                      ),
                                                    );
                                                  },
                                                  child: Container(
                                                    width: 150.w,
                                                    height: 100.h,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        10.r,
                                                      ),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        10.r,
                                                      ),
                                                      child: Image.network(
                                                        todoTask.urls[index],
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : GestureDetector(
                                                  onTap: () async {
                                                    if (snapshot.data ==
                                                        'application/pdf') {
                                                      await openFileUrlDoc(
                                                          todoTask.urls[index]);
                                                    } else {
                                                      await openUrl(
                                                          todoTask.urls[index]);
                                                    }
                                                  },
                                                  child: Container(
                                                    width: 150.w,
                                                    height: 100.h,
                                                    decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.r),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 20.h),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          const Center(
                                                            child: Icon(
                                                              Icons
                                                                  .insert_drive_file,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          VerticalSpace(
                                                            space: 5.h,
                                                          ),
                                                          Text(
                                                            todoTask.urls[index]
                                                                .split('/')
                                                                .last,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                              fontSize: 14.sp,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                          : Container(
                                              width: 150.w,
                                              height: 100.h,
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                              ),
                                              child: const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            ),
                                    );
                                  },
                                );
                              },
                            ),
                          )
                        : Center(
                            child: Text(
                              LocaleKeys.no_images_available.tr(),
                              style: TextStyle(
                                  fontSize: 14.sp, color: SECONDARY_TEXT_COLOR),
                            ),
                          ),
                    VerticalSpace(
                      space: 30.h,
                    ),
                    Text(
                      LocaleKeys.status.tr(),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    DropdownButtonHideUnderline(
                      child: Consumer(
                        builder: (context, ref, child) {
                          return Column(
                            children: [
                              DropdownButton2<String>(
                                isExpanded: true,
                                hint: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        LocaleKeys.change_status.tr(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: SECONDARY_TEXT_COLOR,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                items: statusTypes
                                    .map((StatusTypes item) =>
                                        DropdownMenuItem<String>(
                                          value: item.value,
                                          child: Text(
                                            item.name,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: PRIMARY_TEXT_COLOR,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  ref
                                      .read(
                                          changeStatusProvider(todoTask.status)
                                              .notifier)
                                      .updateStatus(value!);
                                },
                                value: ref
                                    .watch(
                                        changeStatusProvider(todoTask.status))
                                    .value,
                                buttonStyleData: ButtonStyleData(
                                  height: 55,
                                  width: ScreenUtil().screenWidth - 48,
                                  padding: const EdgeInsets.only(
                                      left: 14, right: 14),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: Colors.black26,
                                    ),
                                    color: Colors.transparent,
                                  ),
                                ),
                                iconStyleData: const IconStyleData(
                                  icon: Icon(
                                    Icons.arrow_drop_down_circle,
                                  ),
                                  iconSize: 14,
                                  iconEnabledColor: Colors.black54,
                                  iconDisabledColor: Colors.grey,
                                ),
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight: 200,
                                  width: ScreenUtil().screenWidth - 48,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  scrollbarTheme: ScrollbarThemeData(
                                    radius: const Radius.circular(40),
                                    thickness: MaterialStateProperty.all(6),
                                    thumbVisibility:
                                        MaterialStateProperty.all(true),
                                  ),
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                  padding: EdgeInsets.only(left: 14, right: 14),
                                ),
                              ),
                              VerticalSpace(
                                space: 30.h,
                              ),
                              Visibility(
                                visible: !(ref
                                        .watch(changeStatusProvider(
                                            todoTask.status))
                                        .value ==
                                    todoTask.status),
                                child: Button(
                                  label: LocaleKeys.save_changes.tr(),
                                  onPressed: () {
                                    ref
                                        .read(todoTasksProvider.notifier)
                                        .changeTaskStatus(
                                          taskId: todoTask.id,
                                          status: ref
                                              .watch(changeStatusProvider(
                                                  todoTask.status))
                                              .value,
                                          onSuccess: () {
                                            showSuccessSnackBar(
                                              context,
                                              message: LocaleKeys
                                                  .success_status_update
                                                  .tr(),
                                            );
                                          },
                                        );
                                  },
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    ),
                    VerticalSpace(
                      space: 40.h,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
