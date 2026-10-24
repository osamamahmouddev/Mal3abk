import 'package:flutter_bloc/flutter_bloc.dart';

mixin SafeEmitCubitMixin<State> on Cubit<State> {
  void emitIfOpen(State state) {
    if (isClosed) {
      return;
    }
    emit(state);
  }
}
