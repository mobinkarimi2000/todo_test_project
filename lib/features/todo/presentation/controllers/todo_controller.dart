import 'package:get/get.dart';
import 'package:todo_test_project/features/todo/domain/models/todo_list_params.dart';
import 'package:todo_test_project/features/todo/domain/models/todo_model.dart';
import 'package:todo_test_project/features/todo/domain/usecases/add_todo_use_case.dart';
import 'package:todo_test_project/features/todo/domain/usecases/delete_todo_use_case.dart';
import 'package:todo_test_project/features/todo/domain/usecases/get_todo_list_use_case.dart';
import 'package:todo_test_project/features/todo/domain/usecases/update_todo_use_case.dart';
import 'package:todo_test_project/features/todo/presentation/controllers/status/todo_list_status.dart';
import 'package:todo_test_project/features/todo/presentation/controllers/todo_state.dart';

class TodoController extends GetxController {
  var state = TodoState(todoListStatus: TodoListInitial()).obs;

  final GetTodoListUseCase _getTodoListUseCase;
  final AddTodoListUseCase _addTodoListUseCase;
  final UpdateTodoListUseCase _updateTodoListUseCase;
  final DeleteTodoListUseCase _deleteTodoListUseCase;
  int pageNumber = 0;
  int pageSize = 30;

  final List<TodoModel> todoList = [];

  TodoController(
    this._getTodoListUseCase,
    this._addTodoListUseCase,
    this._updateTodoListUseCase,
    this._deleteTodoListUseCase,
  );
  deleteTodo(int id) async {
    final result = await _deleteTodoListUseCase(id);
    result.fold(
      (failure) {
        todoList.removeWhere((element) => element.id == id);
        if (todoList.isEmpty) {
          state.value =
              state.value.copyWith(newTodoListStatus: TodoListEmpty());
        } else {
          state.value = state.value
              .copyWith(newTodoListStatus: TodoListCompleted(list: todoList));
        }
      },
      (success) {
        todoList.removeWhere((element) => element.id == id);
        if (todoList.isEmpty) {
          state.value =
              state.value.copyWith(newTodoListStatus: TodoListEmpty());
        } else {
          state.value = state.value
              .copyWith(newTodoListStatus: TodoListCompleted(list: todoList));
        }
      },
    );
  }

  updateTodo(TodoModel todoModel) async {
    final result = await _updateTodoListUseCase(todoModel);
    result.fold(
      (failure) {
        final index =
            todoList.indexWhere((element) => element.id == todoModel.id);
        todoList.removeWhere((element) => element.id == todoModel.id);
        todoList.insert(index, todoModel);

        if (todoList.isEmpty) {
          state.value =
              state.value.copyWith(newTodoListStatus: TodoListEmpty());
        } else {
          state.value = state.value
              .copyWith(newTodoListStatus: TodoListCompleted(list: todoList));
        }
      },
      (success) {
        final index =
            todoList.indexWhere((element) => element.id == todoModel.id);
        todoList.removeWhere((element) => element.id == todoModel.id);
        todoList.insert(index, todoModel);

        if (todoList.isEmpty) {
          state.value =
              state.value.copyWith(newTodoListStatus: TodoListEmpty());
        } else {
          state.value = state.value
              .copyWith(newTodoListStatus: TodoListCompleted(list: todoList));
        }
      },
    );
  }

  addTodo(TodoModel todoModel) async {
    final result = await _addTodoListUseCase(todoModel);
    result.fold(
      (failure) {},
      (success) {
        todoList.insert(0, success);

        if (todoList.isEmpty) {
          state.value =
              state.value.copyWith(newTodoListStatus: TodoListEmpty());
        } else {
          state.value = state.value
              .copyWith(newTodoListStatus: TodoListCompleted(list: todoList));
        }
      },
    );
  }

  pageToInitialTodoList() {
    todoList.clear();
    pageNumber = 0;
  }

  getTodoList() async {
    if (pageNumber == 0) {
      state.value = state.value.copyWith(newTodoListStatus: TodoListLoading());
    } else {
      state.value =
          state.value.copyWith(newTodoListStatus: TodoListLoadingMore());
    }
    final result = await _getTodoListUseCase(
        TodoListParams(pageNumber: pageNumber, pageSize: pageSize));
    result.fold(
      (failure) {
        state.value = state.value
            .copyWith(newTodoListStatus: TodoListError(failure: failure));
      },
      (success) {
        if (success.todos?.isNotEmpty ?? false) {
          pageNumber++;
        }
        todoList.addAll(success.todos ?? []);

        if (todoList.isEmpty) {
          state.value =
              state.value.copyWith(newTodoListStatus: TodoListEmpty());
        } else {
          state.value = state.value
              .copyWith(newTodoListStatus: TodoListCompleted(list: todoList));
        }
      },
    );
  }
}
