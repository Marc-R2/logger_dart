part of 'logger.dart';

class Log extends MessageTemplate {
  const Log({
    this.id = 0,
    this.parent,
    String? session,
    super.function,
    super.klasse,
    super.tags,
  })  : assert(id >= 0, 'Log id must be greater than or equal to 0'),
        assert(session != null || parent != null,
            'Log session must not be null if parent is null'),
        _session = session;

  final int id;

  final String? _session;

  final Log? parent;

  String get session => _session ?? parent!.session;

  @override
  List<String> get tags => [...super.tags, 'session:$session', 'id:$id'];
}
