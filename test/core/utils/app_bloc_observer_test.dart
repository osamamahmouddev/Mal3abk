import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/utils/app_bloc_observer.dart';

class _TestCubit extends Cubit<int> {
  _TestCubit() : super(0);

  void increment() => emit(state + 1);

  void triggerError(Object error) {
    addError(error, StackTrace.current);
  }
}

void main() {
  group('AppBlocObserver', () {
    late AppBlocObserver observer;

    setUp(() {
      observer = const AppBlocObserver();
    });

    test('can be instantiated with const constructor', () {
      expect(observer, isNotNull);
    });

    test('onChange handles state changes gracefully', () {
      final cubit = _TestCubit();
      const change = Change<int>(currentState: 0, nextState: 1);

      expect(() => observer.onChange(cubit, change), returnsNormally);
      cubit.close();
    });

    test('onError handles errors gracefully without rethrowing', () {
      final cubit = _TestCubit();
      final exception = Exception('Test cubit exception');
      final stack = StackTrace.current;

      expect(() => observer.onError(cubit, exception, stack), returnsNormally);
      cubit.close();
    });

    test('intercepts cubit state changes when registered as Bloc.observer', () {
      Bloc.observer = observer;
      final cubit = _TestCubit();

      expect(() => cubit.increment(), returnsNormally);
      expect(cubit.state, 1);

      cubit.close();
    });

    test('intercepts cubit errors when registered as Bloc.observer', () {
      Bloc.observer = observer;
      final cubit = _TestCubit();

      expect(
        () => cubit.triggerError(Exception('Async unhandled error')),
        returnsNormally,
      );

      cubit.close();
    });
  });
}
