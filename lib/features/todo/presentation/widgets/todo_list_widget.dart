import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:get/get.dart';
import 'package:scroll_edge_listener/scroll_edge_listener.dart';
import 'package:todo_test_project/core/widgets/error_handling/error_handling_widget.dart';
import 'package:todo_test_project/features/todo/domain/models/todo_model.dart';
import 'package:todo_test_project/features/todo/presentation/controllers/status/todo_list_status.dart';
import 'package:todo_test_project/features/todo/presentation/controllers/todo_controller.dart';
import 'package:todo_test_project/features/todo/presentation/widgets/empty_data_todo_list_widget.dart';
import 'package:todo_test_project/features/todo/presentation/widgets/loading_todo_card.dart';
import 'package:todo_test_project/features/todo/presentation/widgets/todo_card.dart';

class TodoListWidget extends StatelessWidget {
  TodoListWidget({super.key});

  final TodoController todoController = Get.find();
  void onWidgetCreated(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      refreshScreen();
    });
  }

  void refreshScreen() {
    callInitialEvent();
    callLoadEvent();
  }

  void callLoadEvent() {
    todoController.getTodoList();
  }

  void callInitialEvent() {
    todoController.pageToInitialTodoList();
  }

  @override
  Widget build(BuildContext context) {
    Widget shownWidget = Container();
    List<TodoModel> list = [];
    refreshScreen();
    return Expanded(
      child: Obx(
        () {
          final state = todoController.state.value;
          bool isLoadingMore = false;
          if (state.todoListStatus is TodoListLoading) {
            shownWidget = _createLoadingListWidget();
          } else if (state.todoListStatus is TodoListEmpty) {
            shownWidget = EmptyDataTodoListWidget(
              onClickListener: () {
                refreshScreen();
              },
            );
          } else if (state.todoListStatus is TodoListCompleted) {
            final TodoListCompleted completed =
                state.todoListStatus as TodoListCompleted;
            list = completed.list;

            shownWidget = _createLoadedListWidget(list, false);
          } else if (state.todoListStatus is TodoListLoadingMore) {
            shownWidget = _createLoadedListWidget(list, false);

            isLoadingMore = true;
          } else if (state.todoListStatus is TodoListLoadedMoreError) {
            shownWidget = _createLoadedListWidget(list, false);
          } else if (state.todoListStatus is TodoListError) {
            TodoListError followingListError =
                state.todoListStatus as TodoListError;
            shownWidget = _createErrorWidget(followingListError);
          }
          return Column(
            children: [
              Expanded(child: shownWidget),
              Visibility(
                visible: isLoadingMore,
                child: _createLoadMoreIndicator(),
              ),
            ],
          );
        },
      ),
    );
  }

  ErrorHandlingWidget _createErrorWidget(TodoListError listError) {
    return ErrorHandlingWidget(
      listError.failure,
      onClickListener: () {
        refreshScreen();
      },
    );
  }

  _createLoadingListWidget() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView.separated(
          itemCount: 20,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return const LoadingTodoCard();
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 10);
          },
        ),
      );

  Widget _createLoadedListWidget(List<TodoModel> list, bool isLoading) {
    return ScrollEdgeListener(
      edge: ScrollEdge.end,
      edgeOffset: 30,
      continuous: false,
      debounce: const Duration(milliseconds: 500),
      dispatch: true,
      listener: () {
        if (isLoading) {
          return;
        }
        callLoadEvent();
      },
      child: RefreshIndicator(
        onRefresh: () async {
          refreshScreen();
        },
        backgroundColor: Colors.white,
        color: Colors.blue,
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: list.length,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          itemBuilder: (context, index) {
            return FadeIn(
              duration: const Duration(milliseconds: 500),
              child: TodoCard(
                todoModel: list[index],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 10);
          },
        ),
      ),
    );
  }

  _createLoadMoreIndicator() {
    return const CircularProgressIndicator(
      color: Colors.blue,
    );
  }
}
