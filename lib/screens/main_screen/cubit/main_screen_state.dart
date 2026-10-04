abstract class MainScreenState {}

// Начальное состояние — результата ещё нет
class MainScreenInitialState extends MainScreenState {}

// Состояние с результатом расчёта
class MainScreenResultState extends MainScreenState {
  final double result;
  MainScreenResultState({required this.result});
}

// Состояние с ошибкой (например, не поставлена галочка)
class MainScreenErrorState extends MainScreenState {
  final String message;
  MainScreenErrorState({required this.message});
}