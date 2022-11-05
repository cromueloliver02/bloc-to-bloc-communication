import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter/material.dart';
import '../color/color_bloc.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  final ColorBloc colorBloc;
  late final StreamSubscription _colorSubscription;
  var _incrementSize = 1;

  CounterBloc({
    required this.colorBloc,
  }) : super(CounterState.initial()) {
    _colorSubscription = colorBloc.stream.listen(_colorListener);

    on<IncrementCounterEvent>(_incrementCounter);
  }

  @override
  Future<void> close() {
    _colorSubscription.cancel();
    return super.close();
  }

  void _colorListener(ColorState colorState) {
    final color = colorState.color;

    if (color == Colors.red) _incrementSize = 1;
    if (color == Colors.green) _incrementSize = 10;
    if (color == Colors.blue) _incrementSize = 100;
    if (color == Colors.black) {
      _incrementSize = -100;
      add(IncrementCounterEvent());
    }
  }

  void _incrementCounter(
    IncrementCounterEvent event,
    Emitter<CounterState> emit,
  ) {
    emit(state.copyWith(counter: state.counter + _incrementSize));
  }
}
