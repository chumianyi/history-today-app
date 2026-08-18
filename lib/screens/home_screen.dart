import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/history_event.dart';
import '../services/api_service.dart';
import '../widgets/neu_widgets.dart';
import '../widgets/history_tile.dart';
import '../widgets/state_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  late DateTime _selectedDate;
  List<HistoryEvent> _events = [];
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final events = await _apiService.fetchEvents(
        _selectedDate.month,
        _selectedDate.day,
      );
      if (!mounted) return;
      setState(() {
        _events = events;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = '网络连接异常，请检查网络后重试';
        _isLoading = false;
      });
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      helpText: '选择日期',
      cancelText: '取消',
      confirmText: '确定',
      fieldLabelText: '日期',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: NeuColors.primary,
              onPrimary: Colors.white,
              surface: NeuColors.background,
              onSurface: NeuColors.textPrimary,
            ),
            dialogBackgroundColor: NeuColors.background,
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
      _loadEvents();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeuColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final dateStr = DateFormat('yyyy年MM月dd日', 'zh_CN').format(_selectedDate);
    final weekdayStr = _weekdayChinese(_selectedDate.weekday);
    final isToday = _isToday(_selectedDate);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: NeuCard(
        padding: const EdgeInsets.all(18),
        borderRadius: 20,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: NeuColors.cardBackground,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: NeuColors.darkShadow.withOpacity(0.4),
                        offset: const Offset(2, 2),
                        blurRadius: 5,
                      ),
                      BoxShadow(
                        color: NeuColors.lightShadow.withOpacity(0.9),
                        offset: const Offset(-2, -2),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.history_edu,
                    color: NeuColors.primary,
                    size: 26,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '历史上今天',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: NeuColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        isToday ? '今天发生了哪些大事' : '历史上的这一天',
                        style: const TextStyle(
                          fontSize: 12,
                          color: NeuColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                NeuCircleButton(
                  icon: Icons.calendar_today,
                  onPressed: _pickDate,
                  size: 44,
                ),
              ],
            ),
            const SizedBox(height: 14),
            GestureDetector(
              onTap: _pickDate,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: NeuColors.cardBackground,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: NeuColors.darkShadow.withOpacity(0.35),
                      offset: const Offset(2, 2),
                      blurRadius: 5,
                      spreadRadius: 0.5,
                    ),
                    BoxShadow(
                      color: NeuColors.lightShadow.withOpacity(0.9),
                      offset: const Offset(-2, -2),
                      blurRadius: 5,
                      spreadRadius: 0.5,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.event,
                        color: NeuColors.accent, size: 20),
                    const SizedBox(width: 10),
                    Text(
                      '$dateStr  $weekdayStr',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: NeuColors.textPrimary,
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_forward_ios,
                        size: 14, color: NeuColors.textSecondary),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const LoadingState();
    }
    if (_error != null) {
      return ErrorState(message: _error!, onRetry: _loadEvents);
    }
    if (_events.isEmpty) {
      return EmptyState(onRetry: _loadEvents);
    }
    return RefreshIndicator(
      color: NeuColors.primary,
      backgroundColor: NeuColors.background,
      onRefresh: _loadEvents,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: _events.length + 1,
        itemBuilder: (context, index) {
          if (index == _events.length) {
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: Text(
                  '共 ${_events.length} 条历史记录',
                  style: const TextStyle(
                    fontSize: 12,
                    color: NeuColors.textSecondary,
                  ),
                ),
              ),
            );
          }
          return HistoryTile(event: _events[index], index: index);
        },
      ),
    );
  }

  String _weekdayChinese(int weekday) {
    const days = ['', '周一', '周二', '周三', '周四', '周五', '周六', '周日'];
    return days[weekday];
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }
}
