part of 'logger.dart';

/// Log with context
class Log extends MessageTemplate {
  /// Creates a log with [parent] context and [id]
  const Log({
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
        _session = session;

  /// The id of the log
  final int id;

  final String? _session;

  /// The parent log
  final Log? parent;

  /// Get the session id
  ///
  /// either from the current log or from the parent
  String get session => _session ?? parent!.session;

  @override
  List<String> get tags => [...super.tags, 'session:$session', 'id:$id'];
}
