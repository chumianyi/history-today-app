class HistoryEvent {
  final String year;
  final String title;
  final String description;
  final String link;
  final String type;

  HistoryEvent({
    required this.year,
    required this.title,
    required this.description,
    required this.link,
    required this.type,
  });

  factory HistoryEvent.fromJson(Map<String, dynamic> json) {
    return HistoryEvent(
      year: json['year']?.toString() ?? '',
      title: _stripHtml(json['title']?.toString() ?? ''),
      description: _stripHtml(json['desc']?.toString() ?? ''),
      link: json['link']?.toString() ?? '',
      type: json['type']?.toString() ?? 'event',
    );
  }

  static String _stripHtml(String html) {
    final regex = RegExp(r'<[^>]*>');
    return html.replaceAll(regex, '').trim();
  }

  String get typeLabel {
    switch (type) {
      case 'birth':
        return '出生';
      case 'death':
        return '逝世';
      case 'festival':
        return '节日';
      default:
        return '事件';
    }
  }

  String get shareText {
    final sb = StringBuffer();
    sb.writeln('📅 历史上的今天');
    sb.writeln('$year年 · $typeLabel');
    sb.writeln();
    sb.writeln(title);
    if (description.isNotEmpty) {
      sb.writeln();
      sb.writeln(description);
    }
    if (link.isNotEmpty) {
      sb.writeln();
      sb.writeln('🔗 $link');
    }
    return sb.toString();
  }
}
