import 'dart:async';

import 'package:flutter_hooks/flutter_hooks.dart';

/// Whole seconds left until [until], ticking every second; 0 when it has
/// passed or is null.
int useSecondsUntil(DateTime? until) {
  int remaining() {
    if (until == null) return 0;
    final left = until.difference(DateTime.now()).inMilliseconds;
    return left <= 0 ? 0 : (left / 1000).ceil();
  }

  final seconds = useState(remaining());
  useEffect(() {
    seconds.value = remaining();
    if (seconds.value == 0) return null;
    final timer = Timer.periodic(const Duration(seconds: 1), (t) {
      seconds.value = remaining();
      if (seconds.value == 0) t.cancel();
    });
    return timer.cancel;
  }, [until]);
  return seconds.value;
}
