import 'package:flutter/material.dart';

class AppTheme{
  static const Color primaryBlue = Color(0xFF4C7FFF); // أزرق نقي للإجراءات الهامة (مثل FAB)
  static const Color primaryMint = Color(0xFF6DE0B9);  // أخضر نعناعي للأيقونات والتقدم
  static const Color secondaryDarkBlue = Color(0xFF2E63A7); // أزرق داكن للنصوص أو الأيقونات الثانوية

  // 2. ألوان الخلفية والمكونات (Background & Surface Colors)
  static const Color backgroundLight = Color(0xFFE8F0FF); // خلفية التطبيق العامة الفاتحة جداً
  static const Color surfaceCard = Color(0xFFFFFFFF); // خلفية البطاقات والمكونات
  static Color shadowSoft = Colors.grey.withOpacity(0.1); // ظل ناعم للبطاقات

  // 3. ألوان التدرجات (Gradients)
  // تدرج من الأزرق الهادئ إلى الأخضر النعناعي
  static const Gradient mainGradient = LinearGradient(
    colors: [Color(0xFF8BB8FF), Color(0xFF6DE0B9)], // Light Blue to Mint
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const Gradient HabitGradient = LinearGradient(
    colors: [Color(0xFF6DE0B9), Color(0xFFFFFFFF)], // Light Blue to Mint
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const Gradient HabitGradient2 = LinearGradient(
    colors: [Color(0xFF8BB8FF), Color(0xFFFFFFFF)], // Light Blue to Mint
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  // تدرج للأزرار الصغيرة أو مؤشرات التقدم
  static const Gradient buttonGradient = LinearGradient(
    colors: [Color(0xFF8BB8FF), Color(0xFFB4EEDD)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );


  // 4. ألوان النصوص (Text Colors)
  static const Color textPrimary = Color(0xFF212121); // أسود داكن للنصوص الرئيسية
  static const Color textSecondary = Color(0xFF757575); // رمادي فاتح للنصوص الثانوية والوصف

  // 5. ألوان الحالة (State Colors)
  static const Color errorRed = Color(0xFFFF5252); // للأخطاء أو الحذف
  static const Color streakOrange = Color(0xFFFF9800); // لون محفز لأيام التتابع (Streak)
  static ThemeData themeWhite=ThemeData(

    textTheme: const TextTheme(
      // للعناوين الكبيرة
      titleLarge: TextStyle(color: textPrimary, fontWeight: FontWeight.bold),
      // للنصوص الأساسية
      bodyMedium: TextStyle(color: textPrimary),
    ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        type: BottomNavigationBarType.fixed,
        selectedItemColor:  Colors.amber,
        unselectedItemColor: Colors.white,
        showSelectedLabels: true,
        showUnselectedLabels: true,


      )
  );
}