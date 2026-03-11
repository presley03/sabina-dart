import 'package:flutter/material.dart';
import 'package:sabina/generated/app_localizations.dart';
import '../services/health_analytics_service.dart';
import '../services/app_integration_service.dart';
import '../screens/health_monitoring_screen.dart';

class HealthDashboardWidget extends StatefulWidget {
  const HealthDashboardWidget({super.key});

  @override
  State<HealthDashboardWidget> createState() => _HealthDashboardWidgetState();
}

class _HealthDashboardWidgetState extends State<HealthDashboardWidget>
    with AutomaticKeepAliveClientMixin {
  List<HealthInsight> insights = [];
  int healthScore = 75;
  bool isLoading = true;
  bool _isInitialized = false;

  // Cache for expensive operations
  static final Map<String, dynamic> _cache = {};
  static DateTime? _lastCacheUpdate;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _loadDashboardDataOptimized();
  }

  Future<void> _loadDashboardDataOptimized() async {
    if (_isInitialized && _isCacheValid()) {
      setState(() {
        insights = _cache['insights'] ?? [];
        healthScore = _cache['healthScore'] ?? 75;
        isLoading = false;
      });
      return;
    }

    setState(() => isLoading = true);

    try {
      final results = await Future.wait([
        _loadInsightsWithCache(),
        _loadHealthScoreWithCache(),
      ]);

      final loadedInsights = results[0] as List<HealthInsight>;
      final score = results[1] as int;

      _cache['insights'] = loadedInsights;
      _cache['healthScore'] = score;
      _lastCacheUpdate = DateTime.now();

      if (mounted) {
        setState(() {
          insights = loadedInsights;
          healthScore = score;
          isLoading = false;
          _isInitialized = true;
        });
      }
    } catch (e) {
      debugPrint('Error loading dashboard data: $e');
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  bool _isCacheValid() {
    if (_lastCacheUpdate == null) return false;
    final cacheAge = DateTime.now().difference(_lastCacheUpdate!);
    return cacheAge.inMinutes < 5;
  }

  Future<List<HealthInsight>> _loadInsightsWithCache() async {
    try {
      return await AppIntegrationService.generateDashboardInsights();
    } catch (e) {
      debugPrint('Error loading insights: $e');
      return [];
    }
  }

  Future<int> _loadHealthScoreWithCache() async {
    try {
      return await AppIntegrationService.calculateHealthScore();
    } catch (e) {
      debugPrint('Error calculating health score: $e');
      return 75;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final l10n = AppLocalizations.of(context)!;

    if (isLoading) {
      return _buildLoadingWidget();
    }

    return _buildMinimalistContent(l10n);
  }

  Widget _buildLoadingWidget() {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildMinimalistContent(AppLocalizations l10n) {
    return Column(
      children: [
        // Simple Health Score Card
        _buildSimpleHealthScore(l10n),
        const SizedBox(height: 20),

        // Main Action Button
        _buildMainActionButton(l10n),
        const SizedBox(height: 20),

        // Essential Quick Actions (Only 2)
        _buildEssentialActions(l10n),
        const SizedBox(height: 20),

        // Single Most Important Insight
        _buildSingleInsight(l10n),
      ],
    );
  }

  Widget _buildSimpleHealthScore(AppLocalizations l10n) {
    Color scoreColor = healthScore >= 80
        ? Colors.green
        : healthScore >= 60
            ? Colors.orange
            : Colors.red;

    String statusText = healthScore >= 80
        ? l10n.dashboardStatusHealthy
        : healthScore >= 60
            ? l10n.dashboardStatusGood
            : l10n.dashboardStatusNeedsAttention;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            scoreColor.withValues(alpha: 0.8),
            scoreColor.withValues(alpha: 0.6)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: scoreColor.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.yourHealth,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '$healthScore/100',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  statusText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.favorite,
              color: Colors.white,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainActionButton(AppLocalizations l10n) {
    return SizedBox(
      width: double.infinity,
      height: 64,
      child: ElevatedButton(
        onPressed: _navigateToHealthMonitoring,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.pink[600],
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 8,
          shadowColor: Colors.pink.withValues(alpha: 0.4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.health_and_safety, size: 24),
            ),
            const SizedBox(width: 16),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.dashboardRecordDailyHealth,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  l10n.dashboardMonitorSubtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEssentialActions(AppLocalizations l10n) {
    return Row(
      children: [
        Expanded(
          child: _buildActionCard(
            icon: Icons.calendar_today,
            title: l10n.scheduleCheckup,
            subtitle: l10n.dashboardScheduleSubtitle,
            color: Colors.blue,
            onTap: _showAppointmentDialog,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildActionCard(
            icon: Icons.emergency,
            title: l10n.emergency,
            subtitle: l10n.dashboardEmergencySubtitle,
            color: Colors.red,
            onTap: _showEmergencyDialog,
          ),
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.2)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                color: color,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 11,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSingleInsight(AppLocalizations l10n) {
    if (insights.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.blue[100]!),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.lightbulb_outline,
                  color: Colors.blue[600], size: 24),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.dashboardHealthTipsTitle,
              style: TextStyle(
                color: Colors.blue[800],
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.dashboardHealthTipsEmpty,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 14,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    final insight = insights.first;
    Color priorityColor = insight.priority == InsightPriority.critical
        ? Colors.red
        : insight.priority == InsightPriority.high
            ? Colors.orange
            : insight.priority == InsightPriority.medium
                ? Colors.blue
                : Colors.green;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: priorityColor.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: priorityColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.lightbulb, color: priorityColor, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  l10n.dashboardRecommendation,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            insight.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            insight.recommendation,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToHealthMonitoring() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HealthMonitoringScreen(),
      ),
    );
  }

  void _showAppointmentDialog() {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.calendar_today, color: Colors.blue[600]),
            const SizedBox(width: 12),
            Text(l10n.scheduleCheckup),
          ],
        ),
        content: Text(
          l10n.dashboardScheduleDialogContent,
          style: const TextStyle(height: 1.4),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.dashboardUnderstood),
          ),
        ],
      ),
    );
  }

  void _showEmergencyDialog() {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.emergency, color: Colors.red[600]),
            const SizedBox(width: 12),
            Text(l10n.emergencyContacts),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.emergencyCallToAction,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(l10n.emergencySymptoms),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.local_hospital, color: Colors.red),
              title: Text(l10n.ambulance),
              subtitle: const Text('118 / 119'),
              contentPadding: EdgeInsets.zero,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.close),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _cache.clear();
    _lastCacheUpdate = null;
    super.dispose();
  }
}
