part of 'todo_cubit.dart';

sealed class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

final class TodoLoadingState extends TodoState {}

final class TodoLoadedeState extends TodoState {
  const TodoLoadedeState({required this.todoList});
  final List<TodoData> todoList;
}

final class TodoCreateSuccessState extends TodoState {}

final class TodoDetetedSuccessState extends TodoState {}

final class TodoUpdatedSuccessState extends TodoState {}

final class TodoErrorState extends TodoState {}
