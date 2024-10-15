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
  TodoState state = TodoState(todoListStatus: TodoListInitial());

  final GetTodoListUseCase _getTodoListUseCase;
  final AddTodoListUseCase _addTodoListUseCase;
  final UpdateTodoListUseCase _updateTodoListUseCase;
  final DeleteTodoListUseCase _deleteTodoListUseCase;
  int pageNumber = 1;
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
      (failure) {},
      (success) {
        todoList.removeWhere((element) => element.id == id);
        if (todoList.isEmpty) {
          state = state.copyWith(newTodoListStatus: TodoListEmpty());
        } else {
          state = state.copyWith(
              newTodoListStatus: TodoListCompleted(list: todoList));
        }
      },
    );
  }

  updateTodo(TodoModel todoModel) async {
    final result = await _updateTodoListUseCase(todoModel);
    result.fold(
      (failure) {},
      (success) {
        final index =
            todoList.indexWhere((element) => element.id == todoModel.id);
        todoList.removeWhere((element) => element.id == todoModel.id);
        todoList.insert(index, todoModel);

        if (todoList.isEmpty) {
          state = state.copyWith(newTodoListStatus: TodoListEmpty());
        } else {
          state = state.copyWith(
              newTodoListStatus: TodoListCompleted(list: todoList));
        }
      },
    );
  }

  addTodo(TodoModel todoModel) async {
    final result = await _addTodoListUseCase(todoModel);
    result.fold(
      (failure) {},
      (success) {
        todoList.insert(0, todoModel);

        if (todoList.isEmpty) {
          state = state.copyWith(newTodoListStatus: TodoListEmpty());
        } else {
          state = state.copyWith(
              newTodoListStatus: TodoListCompleted(list: todoList));
        }
      },
    );
  }

  pageToInitialTodoList() {
    todoList.clear();
    pageNumber = 1;
  }

  getTodoList() async {
    if (pageNumber > 1) {
      state = state.copyWith(newTodoListStatus: TodoListLoading());
    } else {
      state = state.copyWith(newTodoListStatus: TodoListLoadingMore());
    }
    final result = await _getTodoListUseCase(
        TodoListParams(pageNumber: pageNumber, pageSize: pageSize));
    result.fold(
      (failure) {
        state =
            state.copyWith(newTodoListStatus: TodoListError(failure: failure));
      },
      (success) {
        if (success.todos?.isNotEmpty ?? false) {
          pageNumber++;
        }
        todoList.addAll(success.todos ?? []);

        if (todoList.isEmpty) {
          state = state.copyWith(newTodoListStatus: TodoListEmpty());
        } else {
          state = state.copyWith(
              newTodoListStatus: TodoListCompleted(list: todoList));
        }
      },
    );
  }
}
