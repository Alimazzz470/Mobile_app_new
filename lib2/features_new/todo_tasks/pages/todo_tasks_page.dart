import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../router/routes.dart';
import '../../../shared/widgets/no_data_placeholder.dart';
import '../../../shared/widgets/padding.dart';
import '../../../shared/widgets/placeholders/empty_list_placeholder.dart';
import '../../../translations/locale_keys.g.dart';
import '../providers/todo_tasks_provider.dart';
import '../widgets/todo_tasks_widget.dart';

class TodoTaskPage extends ConsumerStatefulWidget {
  const TodoTaskPage({super.key});

  @override
  ConsumerState<TodoTaskPage> createState() => _TodoTaskPageState();
}

class _TodoTaskPageState extends ConsumerState<TodoTaskPage> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_loadMoreListener);
    super.initState();
  }

  void _loadMoreListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      ref.read(todoTasksProvider.notifier).loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_loadMoreListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ref.watch(todoTasksProvider).when(
        data: (tasks) {
          return Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              // add a mark as read button
              SizedBox(
                height: 20.h,
              ),
              tasks.data.isNotEmpty
                  ? Expanded(
                      child: RefreshIndicator(
                          backgroundColor: Colors.white,
                          onRefresh: () async {
                            ref.invalidate(todoTasksProvider);
                          },
                          child: ListView.separated(
                            controller: _scrollController,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount:
                                tasks.data.length + (tasks.hasNextPage ? 1 : 0),
                            padding: EdgeInsets.symmetric(
                              horizontal: 24.w,
                            ),
                            itemBuilder: (context, index) {
                              if (index == tasks.data.length) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return GestureDetector(
                                onTap: () {
                                  context.go(
                                    Routes.taskDetailsUri(tasks.data[index].id),
                                  );
                                },
                                child: TodoTasksWidget(
                                  todoTaskModel: tasks.data[index],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const VerticalSpace(space: 20);
                            },
                          )),
                    )
                  : Expanded(
                      child: NoDataPlaceholder(
                          text: LocaleKeys.no_active_tasks.tr()),
                    ),
            ],
          );
        },
        error: (error, stackTrace) {
          return EmptyListPlaceholder(error);
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      )),
    );
  }
}
