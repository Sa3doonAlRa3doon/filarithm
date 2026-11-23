import 'package:flutter/widgets.dart';

class AppStrings {
  AppStrings(this.locale);

  final Locale locale;

  bool get isArabic => locale.languageCode == 'ar';

  static const _english = <String, String>{
    'appName': 'Filarithm',
    'tagline': 'Price every layer. Protect every margin.',
    'dashboard': 'Dashboard',
    'calculator': 'Calculator',
    'scanner': 'Scan',
    'inventory': 'Inventory',
    'jobs': 'Jobs',
    'viewer': '3D Studio',
    'newQuote': 'New quote',
    'importSlicer': 'Import slicer file',
    'scanResult': 'Scan slicer result',
    'quickStart': 'Quick start',
    'materials': 'Materials',
    'spools': 'Spools',
    'activeJobs': 'Active jobs',
    'language': 'العربية',
    'comingReady': 'Ready for your workshop',
  };

  static const _arabic = <String, String>{
    'appName': 'فيلاريثم',
    'tagline': 'سعّر كل طبقة. واحمِ هامش ربحك.',
    'dashboard': 'لوحة التحكم',
    'calculator': 'الحاسبة',
    'scanner': 'المسح',
    'inventory': 'المخزون',
    'jobs': 'الطلبات',
    'viewer': 'استوديو ثلاثي الأبعاد',
    'newQuote': 'عرض سعر جديد',
    'importSlicer': 'استيراد ملف التقطيع',
    'scanResult': 'مسح نتيجة التقطيع',
    'quickStart': 'بدء سريع',
    'materials': 'الخامات',
    'spools': 'البكرات',
    'activeJobs': 'الطلبات النشطة',
    'language': 'English',
    'comingReady': 'جاهز لورشتك',
  };

  String text(String key) =>
      (isArabic ? _arabic[key] : _english[key]) ?? _english[key] ?? key;

  static AppStrings of(BuildContext context) =>
      AppStrings(Localizations.localeOf(context));
}
