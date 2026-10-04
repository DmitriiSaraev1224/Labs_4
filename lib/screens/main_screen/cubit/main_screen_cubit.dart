import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'main_screen_state.dart';

class MainScreenCubit extends Cubit<MainScreenState> {
  // стартовое состояние — результата ещё нет
  MainScreenCubit() : super(MainScreenInitialState());

  // сюда вынесена вся бизнес-логика
  void calculate({
    required double mass,
    required double radius,
    required bool agreement,
  }) {
    // проверка согласия
    if (!agreement) {
      emit(MainScreenErrorState(
        message: 'Необходимо согласие на обработку персональных данных',
      ));
      return;
    }

    // защита от деления на ноль
    if (radius <= 0) {
      emit(MainScreenErrorState(message: 'Радиус должен быть больше нуля'));
      return;
    }

    // сам расчёт — первая космическая скорость
    const g = 6.674e-11;
    final v = sqrt(g * mass / radius);

    emit(MainScreenResultState(result: v));
  }

  // сброс результата (например, по кнопке «Сбросить»)
  void reset() {
    emit(MainScreenInitialState());
  }
}