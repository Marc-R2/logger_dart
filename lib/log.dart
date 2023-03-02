part of 'logger.dart';

/// Log with context
class Log extends MessageTemplate {
  /// Creates a log with [parent] context and [id]
  Log({
    this.id = 0,
    this.parent,
    String? session,
    super.function,
    super.klasse,
    super.tags,
  })  : assert(id >= 0, 'Log id must be greater than or equal to 0'),
        assert(
          session != null || parent != null,
          'Log session must not be null if parent is null',
        ),
        _session = session {
    parent?.addChild(this);
  }

  /// The id of the log
  final int id;

  final String? _session;

  /// The parent log
  final Log? parent;

  final Set<Log> _children = {};

  /// The start time of the log
  final DateTime startTime = DateTime.now();

  /// Get the session id
  ///
  /// either from the current log or from the parent
  String get session => _session ?? parent!.session;

  @override
  List<String> get tags => [...super.tags, 'session:$session', 'id:$id'];

  /// Add a child log
  void addChild(Log child) => _children.add(child);

  /// ## Finish the log
  ///
  /// This will log the duration of the log if it is greater than [threshold]
  ///
  /// By default the [threshold] is 2000 microseconds (2 milliseconds)
  bool finish({int threshold = 2000}) {
    final endTime = DateTime.now();
    final duration = endTime.difference(startTime).inMicroseconds;

    if (duration > threshold) {
      info(
        title: 'Execution time',
        message: 'Took {ms}ms',
        values: {'ms': duration ~/ 1000},
        tags: ['duration', 'ex_mc:$duration'], // ex_mc: execution microsecond
      );
      return true;
    }

    return false;
  }

  /// ## Finish the log with return
  ///
  /// This will log the duration of the log if it is greater than [threshold]
  /// in microseconds.
  ///
  /// By default the [threshold] is 2000 microseconds (2 milliseconds)
  ///
  /// You can wrap the run expression in the [result] of this function
  ///
  /// By default the result will be returned without anything happening
  ///
  /// But if you set [includeResult] to true, the result
  /// and time will be logged as a message
  ///
  /// It is recommended to only include short results
  T finishWithReturn<T>(
    T result, {
    int threshold = 2000,
    bool includeResult = false,
  }) {
    final endTime = DateTime.now();
    final duration = endTime.difference(startTime).inMicroseconds;

    if (duration > threshold || includeResult) {
      if (includeResult) {
        info(
          title: 'Execution Result',
          message: 'Result: {result}, took {ms}ms',
          values: {'result': result, 'ms': duration ~/ 1000},
          tags: ['duration', 'ex_mc:$duration', 'result:$result'],
        );
      } else {
        info(
          title: 'Execution time',
          message: 'took {ms}ms',
          values: {'ms': duration ~/ 1000},
          tags: ['duration', 'ex_mc:$duration'], // ex_mc: execution microsecond
        );
      }
    }

    return result;
  }
}
