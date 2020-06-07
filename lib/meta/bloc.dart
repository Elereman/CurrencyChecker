import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:DollarCheck/meta/disposable.dart';
import 'package:flutter/cupertino.dart';

abstract class Bloc<S, E extends BlocEvent<S>> implements Disposable {
  final BehaviorSubject<S> _stateSubject = BehaviorSubject<S>();
  final StreamController<E> _eventStreamController = StreamController<E>();

  Bloc() {
    _eventStreamController.stream.listen((E event) {
      _stateSubject.value = event.reduce(_stateSubject.value);
    });
  }

  @protected
  @override
  void dispose() {
    _stateSubject?.close();
    _eventStreamController?.close();
  }
}

abstract class BlocEvent<S> {
  S reduce(S state);
}

mixin BlocState {
  BlocStatus get status;

  bool get isProcessing => status == BlocStatus.processing;

  bool get hasError => error != null;

  Object get error;
}

enum BlocStatus { idle, processing }
