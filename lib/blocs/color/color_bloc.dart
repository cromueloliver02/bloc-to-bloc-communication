import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'color_event.dart';
part 'color_state.dart';

class ColorBloc extends Bloc<ColorEvent, ColorState> {
  ColorBloc() : super(ColorState.initial()) {
    on<ChangeColorEvent>(_changeColor);
  }

  void _changeColor(
    ChangeColorEvent event,
    Emitter<ColorState> emit,
  ) {
    final color = state.color;

    if (color == Colors.red) emit(state.copyWith(color: Colors.green));
    if (color == Colors.green) emit(state.copyWith(color: Colors.blue));
    if (color == Colors.blue) emit(state.copyWith(color: Colors.black));
    if (color == Colors.black) emit(state.copyWith(color: Colors.red));
  }
}
