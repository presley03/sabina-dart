import '../generated/app_localizations.dart';
import '../services/screening_result_service.dart';

/// Menerjemahkan kunci label severity (mis. `'sevHighRisk'`) yang disimpan di
/// [ScreeningResultService]/[HistoryService] menjadi teks sesuai bahasa aktif.
///
/// Entri lama (sebelum migrasi ini) menyimpan teks Indonesia yang sudah
/// dirender langsung — bila [key] tidak cocok dengan salah satu kunci ARB di
/// bawah, kembalikan apa adanya agar riwayat lama tetap tampil (tidak retroaktif
/// diterjemahkan, sesuai perilaku riwayat pada umumnya).
String translateSeverityLabel(AppLocalizations l10n, String key) {
  switch (key) {
    case 'sevImmediateCheck':
      return l10n.sevImmediateCheck;
    case 'sevNeedRest':
      return l10n.sevNeedRest;
    case 'sevStayAlert':
      return l10n.sevStayAlert;
    case 'sevNeedMonitoring':
      return l10n.sevNeedMonitoring;
    case 'sevGoodCondition':
      return l10n.sevGoodCondition;
    case 'sevNormal':
      return l10n.sevNormal;
    case 'sevNoIssue':
      return l10n.sevNoIssue;
    case 'sevNeedAttention':
      return l10n.sevNeedAttention;
    case 'sevFetalActive':
      return l10n.sevFetalActive;
    case 'sevHighRisk':
      return l10n.sevHighRisk;
    case 'sevLowRisk':
      return l10n.sevLowRisk;
    case 'sevMediumRisk':
      return l10n.sevMediumRisk;
    case 'sevNoRisk':
      return l10n.sevNoRisk;
    default:
      return key;
  }
}

/// Nama jenis pemeriksaan (mis. "Sakit Kepala" / "Headache") sesuai bahasa
/// aktif, dari `type` locale-independent yang tersimpan (lihat konstanta di
/// [ScreeningResultService]).
String translateScreeningType(AppLocalizations l10n, String type) {
  switch (type) {
    case ScreeningResultService.preeklampsia:
      return l10n.preeklampsiaTitle;
    case ScreeningResultService.penapisan:
      return l10n.penapisanCardTitle;
    case ScreeningResultService.mualMuntah:
      return l10n.mualMuntahTitle;
    case ScreeningResultService.sakitKepala:
      return l10n.sakitKepalaTitle;
    case ScreeningResultService.keluarDarah:
      return l10n.keluarDarahTitle;
    case ScreeningResultService.keluarCairan:
      return l10n.keluarCairanTitle;
    case ScreeningResultService.bengkak:
      return l10n.bengkakTitle;
    case ScreeningResultService.pergerakanJanin:
      return l10n.pergerakanJaninTitle;
    default:
      return type;
  }
}

/// "Baru saja" / "Just now" dst., dihitung dari [timestamp] dan diterjemahkan
/// sesuai bahasa aktif — pengganti `ScreeningResult.timeAgoLabel` yang
/// hardcode Indonesia.
String translateTimeAgo(AppLocalizations l10n, DateTime timestamp) {
  final now = DateTime.now();
  final hours = now.difference(timestamp).inHours;
  final daysAgo = now.difference(timestamp).inDays;
  if (hours < 1) return l10n.timeJustNow;
  if (hours < 24) return l10n.timeHoursAgo(hours);
  if (daysAgo == 1) return l10n.timeYesterday;
  if (daysAgo < 30) return l10n.timeDaysAgo(daysAgo);
  return l10n.timeMonthsAgo((daysAgo / 30).floor());
}
