import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/history_event.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
    headers: {
      'User-Agent':
          'Mozilla/5.0 (Linux; Android 12) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0 Mobile Safari/537.36',
      'Referer': 'https://baike.baidu.com/',
    },
  ));

  static const String _baseUrl =
      'https://baike.baidu.com/cms/home/eventsOnHistory';

  Future<List<HistoryEvent>> fetchEvents(int month, int day) async {
    final monthStr = month.toString().padLeft(2, '0');
    final dayStr = day.toString().padLeft(2, '0');
    final key = '$monthStr$dayStr';
    final url = '$_baseUrl/$monthStr.json';

    try {
      final response = await _dio.get(url);
      if (response.statusCode == 200 && response.data != null) {
        final data = response.data is String
            ? jsonDecode(response.data)
            : response.data;
        final monthData = data[monthStr] as Map<String, dynamic>?;
        if (monthData != null && monthData.containsKey(key)) {
          final list = monthData[key] as List;
          final events = list
              .map((e) => HistoryEvent.fromJson(e as Map<String, dynamic>))
              .toList();
          events.sort((a, b) => b.year.compareTo(a.year));
          await _cacheEvents(key, events);
          return events;
        }
      }
      final cached = await _getCachedEvents(key);
      if (cached != null) return cached;
      return [];
    } catch (e) {
      final cached = await _getCachedEvents(key);
      if (cached != null) return cached;
      rethrow;
    }
  }

  Future<void> _cacheEvents(String key, List<HistoryEvent> events) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = jsonEncode(events
        .map((e) => {
              'year': e.year,
              'title': e.title,
              'desc': e.description,
              'link': e.link,
              'type': e.type,
            })
        .toList());
    await prefs.setString('cache_$key', jsonStr);
    await prefs.setString('cache_time_$key',
        DateTime.now().millisecondsSinceEpoch.toString());
  }

  Future<List<HistoryEvent>?> _getCachedEvents(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString('cache_$key');
    if (jsonStr == null) return null;
    final list = jsonDecode(jsonStr) as List;
    return list
        .map((e) => HistoryEvent.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
