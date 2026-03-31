import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'tokens/tokens.dart';

/// App Theme - 应用主题配置
/// 使用 Flat Design 设计原则
class AppTheme {
  AppTheme._();

  // ═══════════════════════════════════════════════════════════════════════════
  // DEPRECATED - 向后兼容的旧 API
  // 将在未来版本中移除，请使用新的 Token API
  // ═══════════════════════════════════════════════════════════════════════════

  @Deprecated('使用 AppColors.primary 替代')
  static const Color primaryColor = AppColors.primary;

  @Deprecated('使用 AppColors.primaryLight 替代')
  static const Color primaryColorDark = AppColors.primaryLight;

  @Deprecated('使用 AppColors.secondary 替代')
  static const Color secondaryColor = AppColors.secondary;

  @Deprecated('使用 AppColors.warning 替代')
  static const Color warningColor = AppColors.warning;

  @Deprecated('使用 AppColors.error 替代')
  static const Color errorColor = AppColors.error;

  @Deprecated('使用 LightColors.surfaceVariant 替代')
  static const Color lightGray = LightColors.surfaceVariant;

  @Deprecated('使用 LightColors.textSecondary 替代')
  static const Color mediumGray = LightColors.textSecondary;

  @Deprecated('使用 LightColors.textPrimary 替代')
  static const Color darkGray = LightColors.textPrimary;

  @Deprecated('使用 AppColors.white 替代')
  static const Color white = AppColors.white;

  @Deprecated('使用 DarkColors.background 替代')
  static const Color darkBackground = DarkColors.background;

  @Deprecated('使用 DarkColors.surface 替代')
  static const Color darkSurface = DarkColors.surface;

  @Deprecated('使用 DarkColors.surfaceVariant 替代')
  static const Color darkSurface2 = DarkColors.surfaceVariant;

  @Deprecated('使用 DarkColors.surface 替代')
  static const Color darkCard = DarkColors.surface;

  @Deprecated('使用 DarkColors.border 替代')
  static const Color darkBorder = DarkColors.border;

  @Deprecated('使用 DarkColors.borderLight 替代')
  static const Color darkBorderLight = DarkColors.borderLight;

  @Deprecated('使用 DarkColors.textPrimary 替代')
  static const Color darkTextPrimary = DarkColors.textPrimary;

  @Deprecated('使用 DarkColors.textSecondary 替代')
  static const Color darkTextSecondary = DarkColors.textSecondary;

  @Deprecated('使用 AppRadius.md 替代')
  static const double flatRadius = AppRadius.md;

  @Deprecated('使用 AppRadius.lg 替代')
  static const double flatRadiusLg = AppRadius.lg;

  @Deprecated('使用 AppSpacing.lg 替代')
  static const double flatPadding = AppSpacing.lg;

  @Deprecated('使用 AppSpacing.md 替代')
  static const double flatPaddingSm = AppSpacing.md;

  @Deprecated('使用 LightColors.border 替代')
  static const Color flatBorder = LightColors.border;

  @Deprecated('使用 LightColors.borderLight 替代')
  static const Color flatBorderLight = LightColors.borderLight;

  @Deprecated('使用 DarkColors.border 替代')
  static const Color flatBorderDark = DarkColors.border;

  @Deprecated('使用 AppRadius.card 替代')
  static const double cardBorderRadius = AppRadius.card;

  @Deprecated('使用 AppSpacing.cardPadding 替代')
  static const double cardPadding = AppSpacing.cardPadding;

  @Deprecated('使用 AppSpacing.cardMargin 替代')
  static const double cardMargin = AppSpacing.cardMargin;

  @Deprecated('使用 AppShadows.none 替代')
  static const BoxShadow cardShadow = BoxShadow(
    color: Color(0x00000000),
    blurRadius: 0,
    spreadRadius: 0,
    offset: Offset.zero,
  );

  @Deprecated('使用 AppShadows.none 替代')
  static const BoxShadow darkCardShadow = BoxShadow(
    color: Color(0x00000000),
    blurRadius: 0,
    spreadRadius: 0,
    offset: Offset.zero,
  );

  @Deprecated('使用 AppTypography.headlineMedium 替代')
  static const TextStyle titleStyle = AppTypography.headlineMedium;

  @Deprecated('使用 AppTypography.bodyMedium 替代')
  static const TextStyle bodyStyle = AppTypography.bodyMedium;

  @Deprecated('使用 AppTypography.bodySmall 替代')
  static const TextStyle smallStyle = AppTypography.bodySmall;

  @Deprecated('使用 AppTypography.headlineMedium 并设置颜色替代')
  static TextStyle get darkTitleStyle => AppTypography.headlineMedium.copyWith(
    color: DarkColors.textPrimary,
  );

  @Deprecated('使用 AppTypography.bodyMedium 并设置颜色替代')
  static TextStyle get darkBodyStyle => AppTypography.bodyMedium.copyWith(
    color: DarkColors.textPrimary,
  );

  @Deprecated('使用 AppTypography.bodySmall 并设置颜色替代')
  static TextStyle get darkSmallStyle => AppTypography.bodySmall.copyWith(
    color: DarkColors.textSecondary,
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // Light Theme
  // ═══════════════════════════════════════════════════════════════════════════

  static ThemeData get lightThemeData {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      // Color Scheme
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        onPrimary: AppColors.white,
        primaryContainer: AppColors.primaryMuted,
        onPrimaryContainer: AppColors.primaryDark,
        secondary: AppColors.secondary,
        onSecondary: AppColors.white,
        secondaryContainer: AppColors.secondaryMuted,
        onSecondaryContainer: AppColors.secondaryDark,
        error: AppColors.error,
        onError: AppColors.white,
        surface: LightColors.surface,
        onSurface: LightColors.textPrimary,
        onSurfaceVariant: LightColors.textSecondary,
        outline: LightColors.border,
        outlineVariant: LightColors.borderLight,
        surfaceContainerHighest: LightColors.surfaceVariant,
        shadow: AppColors.black,
        scrim: AppColors.black,
      ),
      // Scaffold
      scaffoldBackgroundColor: LightColors.background,

      // ═══════════════════════════════════════════════════════════════════════════
      // FLAT DESIGN - 禁用 Material 水波纹效果
      // 使用 NoSplash.splashFactory 替代默认的 InkSplash
      // ═══════════════════════════════════════════════════════════════════════════
      splashFactory: NoSplash.splashFactory,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      // Card
      cardColor: LightColors.surface,
      cardTheme: CardThemeData(
        color: LightColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.cardRadius,
        ),
        margin: const EdgeInsets.all(AppSpacing.cardMargin),
      ),
      // Divider
      dividerColor: LightColors.border,
      dividerTheme: const DividerThemeData(
        color: LightColors.border,
        thickness: 1,
        space: 0,
      ),
      // Text Theme
      textTheme: const TextTheme(
        displayLarge: AppTypography.displayLarge,
        displayMedium: AppTypography.displayMedium,
        displaySmall: AppTypography.displaySmall,
        headlineLarge: AppTypography.headlineLarge,
        headlineMedium: AppTypography.headlineMedium,
        headlineSmall: AppTypography.headlineSmall,
        titleLarge: AppTypography.titleLarge,
        titleMedium: AppTypography.titleMedium,
        titleSmall: AppTypography.titleSmall,
        bodyLarge: AppTypography.bodyLarge,
        bodyMedium: AppTypography.bodyMedium,
        bodySmall: AppTypography.bodySmall,
        labelLarge: AppTypography.labelLarge,
        labelMedium: AppTypography.labelMedium,
        labelSmall: AppTypography.labelSmall,
      ).apply(
        bodyColor: LightColors.textPrimary,
        displayColor: LightColors.textPrimary,
      ),
      // AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: LightColors.surface,
        foregroundColor: LightColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: AppTypography.headlineMedium.copyWith(
          color: LightColors.textPrimary,
        ),
        iconTheme: const IconThemeData(
          color: LightColors.textPrimary,
          size: 24,
        ),
      ),
      // Bottom Navigation
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: LightColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: LightColors.textSecondary,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: AppTypography.labelSmall,
        unselectedLabelStyle: AppTypography.labelSmall,
      ),
      // List Tile
      listTileTheme: const ListTileThemeData(
        tileColor: LightColors.surface,
        iconColor: LightColors.textPrimary,
        textColor: LightColors.textPrimary,
        contentPadding: AppSpacing.listItemPadding,
        minLeadingWidth: 24,
      ),
      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: LightColors.surfaceVariant,
        border: OutlineInputBorder(
          borderRadius: AppRadius.inputRadius,
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.inputRadius,
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.inputRadius,
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppRadius.inputRadius,
          borderSide: BorderSide.none,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: AppRadius.inputRadius,
          borderSide: BorderSide.none,
        ),
        contentPadding: AppSpacing.inputPadding,
        hintStyle: AppTypography.bodyMedium.copyWith(
          color: LightColors.textSecondary,
        ),
        labelStyle: AppTypography.bodyMedium.copyWith(
          color: LightColors.textSecondary,
        ),
        floatingLabelStyle: AppTypography.bodyMedium.copyWith(
          color: AppColors.primary,
        ),
        errorStyle: AppTypography.caption.copyWith(
          color: AppColors.error,
        ),
      ),
      // Buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          elevation: 0,
          shadowColor: AppColors.transparent,
          splashFactory: NoSplash.splashFactory,
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.buttonRadius,
          ),
          padding: AppSpacing.buttonPadding,
          textStyle: AppTypography.labelLarge,
          minimumSize: const Size(64, 44),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          splashFactory: NoSplash.splashFactory,
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.buttonRadius,
          ),
          padding: AppSpacing.buttonPadding,
          textStyle: AppTypography.labelLarge,
          minimumSize: const Size(64, 44),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          backgroundColor: LightColors.surfaceVariant,
          side: BorderSide.none,
          splashFactory: NoSplash.splashFactory,
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.buttonRadius,
          ),
          padding: AppSpacing.buttonPadding,
          textStyle: AppTypography.labelLarge,
          minimumSize: const Size(64, 44),
        ),
      ),
      // Switch
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return LightColors.textDisabled;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary.withAlpha(102);
          }
          return LightColors.border;
        }),
        trackOutlineColor: WidgetStateProperty.all(LightColors.border),
      ),
      // Checkbox
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return LightColors.surface;
        }),
        checkColor: WidgetStateProperty.all(AppColors.white),
        side: const BorderSide(color: LightColors.border),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      // Radio
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return LightColors.border;
        }),
      ),
      // Snackbar
      snackBarTheme: SnackBarThemeData(
        backgroundColor: LightColors.textPrimary,
        contentTextStyle: AppTypography.bodyMedium.copyWith(
          color: AppColors.white,
        ),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.cardRadius,
        ),
        behavior: SnackBarBehavior.floating,
        insetPadding: const EdgeInsets.all(AppSpacing.lg),
      ),
      // Dialog
      dialogTheme: DialogThemeData(
        backgroundColor: LightColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.dialogRadius,
        ),
        // Flat Design: 禁用对话框按钮的水波纹
      ),
      // Bottom Sheet
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: LightColors.surface,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: AppRadius.topLg,
        ),
      ),
      // Tooltip
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: LightColors.textPrimary,
          borderRadius: AppRadius.allSm,
        ),
        textStyle: AppTypography.caption.copyWith(
          color: AppColors.white,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
      ),
      // Chip
      chipTheme: ChipThemeData(
        backgroundColor: LightColors.surfaceVariant,
        selectedColor: AppColors.primaryMuted,
        disabledColor: LightColors.surfaceVariant,
        labelStyle: AppTypography.bodySmall,
        secondaryLabelStyle: AppTypography.bodySmall.copyWith(
          color: AppColors.primary,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.chip),
        ),
      ),
      // TabBar
      tabBarTheme: const TabBarThemeData(
        labelColor: AppColors.primary,
        unselectedLabelColor: LightColors.textSecondary,
        indicatorColor: AppColors.primary,
        dividerColor: LightColors.border,
      ),
      // Progress Indicator
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary,
        linearTrackColor: LightColors.border,
        circularTrackColor: LightColors.border,
      ),
      // Slider
      sliderTheme: SliderThemeData(
        activeTrackColor: AppColors.primary,
        inactiveTrackColor: LightColors.border,
        thumbColor: AppColors.primary,
        overlayColor: AppColors.primary.withAlpha(26),
        trackHeight: 4,
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // Dark Theme
  // ═══════════════════════════════════════════════════════════════════════════

  static ThemeData get darkThemeData {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      // Color Scheme
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryLight,
        onPrimary: DarkColors.background,
        primaryContainer: Color(0x1A3B82F6), // AppColors.primary with 10% opacity
        onPrimaryContainer: AppColors.primaryLight,
        secondary: AppColors.secondaryLight,
        onSecondary: DarkColors.background,
        secondaryContainer: Color(0x1A10B981), // AppColors.secondary with 10% opacity
        onSecondaryContainer: AppColors.secondaryLight,
        error: AppColors.error,
        onError: DarkColors.background,
        surface: DarkColors.surface,
        onSurface: DarkColors.textPrimary,
        onSurfaceVariant: DarkColors.textSecondary,
        outline: DarkColors.border,
        outlineVariant: DarkColors.borderLight,
        surfaceContainerHighest: DarkColors.surfaceVariant,
        shadow: AppColors.black,
        scrim: AppColors.black,
      ),
      // Scaffold
      scaffoldBackgroundColor: DarkColors.background,

      // ═══════════════════════════════════════════════════════════════════════════
      // FLAT DESIGN - 禁用 Material 水波纹效果
      // ═══════════════════════════════════════════════════════════════════════════
      splashFactory: NoSplash.splashFactory,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      // Card
      cardColor: DarkColors.surface,
      cardTheme: CardThemeData(
        color: DarkColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.cardRadius,
        ),
        margin: const EdgeInsets.all(AppSpacing.cardMargin),
      ),
      // Divider
      dividerColor: DarkColors.border,
      dividerTheme: const DividerThemeData(
        color: DarkColors.border,
        thickness: 1,
        space: 0,
      ),
      // Text Theme
      textTheme: const TextTheme(
        displayLarge: AppTypography.displayLarge,
        displayMedium: AppTypography.displayMedium,
        displaySmall: AppTypography.displaySmall,
        headlineLarge: AppTypography.headlineLarge,
        headlineMedium: AppTypography.headlineMedium,
        headlineSmall: AppTypography.headlineSmall,
        titleLarge: AppTypography.titleLarge,
        titleMedium: AppTypography.titleMedium,
        titleSmall: AppTypography.titleSmall,
        bodyLarge: AppTypography.bodyLarge,
        bodyMedium: AppTypography.bodyMedium,
        bodySmall: AppTypography.bodySmall,
        labelLarge: AppTypography.labelLarge,
        labelMedium: AppTypography.labelMedium,
        labelSmall: AppTypography.labelSmall,
      ).apply(
        bodyColor: DarkColors.textPrimary,
        displayColor: DarkColors.textPrimary,
      ),
      // AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: DarkColors.surface,
        foregroundColor: DarkColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: AppTypography.headlineMedium.copyWith(
          color: DarkColors.textPrimary,
        ),
        iconTheme: const IconThemeData(
          color: DarkColors.textPrimary,
          size: 24,
        ),
      ),
      // Bottom Navigation
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: DarkColors.surface,
        selectedItemColor: AppColors.primaryLight,
        unselectedItemColor: DarkColors.textSecondary,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: AppTypography.labelSmall,
        unselectedLabelStyle: AppTypography.labelSmall,
      ),
      // List Tile
      listTileTheme: const ListTileThemeData(
        tileColor: DarkColors.surface,
        iconColor: DarkColors.textPrimary,
        textColor: DarkColors.textPrimary,
        contentPadding: AppSpacing.listItemPadding,
        minLeadingWidth: 24,
      ),
      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: DarkColors.surfaceVariant,
        border: OutlineInputBorder(
          borderRadius: AppRadius.inputRadius,
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.inputRadius,
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.inputRadius,
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppRadius.inputRadius,
          borderSide: BorderSide.none,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: AppRadius.inputRadius,
          borderSide: BorderSide.none,
        ),
        contentPadding: AppSpacing.inputPadding,
        hintStyle: AppTypography.bodyMedium.copyWith(
          color: DarkColors.textSecondary,
        ),
        labelStyle: AppTypography.bodyMedium.copyWith(
          color: DarkColors.textSecondary,
        ),
        floatingLabelStyle: AppTypography.bodyMedium.copyWith(
          color: AppColors.primaryLight,
        ),
        errorStyle: AppTypography.caption.copyWith(
          color: AppColors.error,
        ),
      ),
      // Buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryLight,
          foregroundColor: DarkColors.background,
          elevation: 0,
          shadowColor: AppColors.transparent,
          splashFactory: NoSplash.splashFactory,
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.buttonRadius,
          ),
          padding: AppSpacing.buttonPadding,
          textStyle: AppTypography.labelLarge,
          minimumSize: const Size(64, 44),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryLight,
          splashFactory: NoSplash.splashFactory,
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.buttonRadius,
          ),
          padding: AppSpacing.buttonPadding,
          textStyle: AppTypography.labelLarge,
          minimumSize: const Size(64, 44),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryLight,
          backgroundColor: DarkColors.surfaceVariant,
          side: BorderSide.none,
          splashFactory: NoSplash.splashFactory,
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.buttonRadius,
          ),
          padding: AppSpacing.buttonPadding,
          textStyle: AppTypography.labelLarge,
          minimumSize: const Size(64, 44),
        ),
      ),
      // Switch
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryLight;
          }
          return DarkColors.textDisabled;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryLight.withAlpha(102);
          }
          return DarkColors.border;
        }),
        trackOutlineColor: WidgetStateProperty.all(DarkColors.border),
      ),
      // Checkbox
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryLight;
          }
          return DarkColors.surface;
        }),
        checkColor: WidgetStateProperty.all(DarkColors.background),
        side: const BorderSide(color: DarkColors.border),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      // Radio
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryLight;
          }
          return DarkColors.border;
        }),
      ),
      // Snackbar
      snackBarTheme: SnackBarThemeData(
        backgroundColor: DarkColors.surfaceElevated,
        contentTextStyle: AppTypography.bodyMedium.copyWith(
          color: DarkColors.textPrimary,
        ),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.cardRadius,
          side: const BorderSide(color: DarkColors.border, width: 1),
        ),
        behavior: SnackBarBehavior.floating,
        insetPadding: const EdgeInsets.all(AppSpacing.lg),
      ),
      // Dialog
      dialogTheme: DialogThemeData(
        backgroundColor: DarkColors.surfaceVariant,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.dialogRadius,
        ),
      ),
      // Bottom Sheet
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: DarkColors.surface,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: AppRadius.topLg,
        ),
      ),
      // Tooltip
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: DarkColors.surfaceElevated,
          borderRadius: AppRadius.allSm,
          border: Border.all(color: DarkColors.border),
        ),
        textStyle: AppTypography.caption.copyWith(
          color: DarkColors.textPrimary,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
      ),
      // Chip
      chipTheme: ChipThemeData(
        backgroundColor: DarkColors.surfaceVariant,
        selectedColor: AppColors.primary.withAlpha(51),
        disabledColor: DarkColors.surfaceVariant,
        labelStyle: AppTypography.bodySmall.copyWith(
          color: DarkColors.textPrimary,
        ),
        secondaryLabelStyle: AppTypography.bodySmall.copyWith(
          color: AppColors.primaryLight,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.chip),
        ),
      ),
      // TabBar
      tabBarTheme: const TabBarThemeData(
        labelColor: AppColors.primaryLight,
        unselectedLabelColor: DarkColors.textSecondary,
        indicatorColor: AppColors.primaryLight,
        dividerColor: DarkColors.border,
      ),
      // Progress Indicator
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primaryLight,
        linearTrackColor: DarkColors.border,
        circularTrackColor: DarkColors.border,
      ),
      // Slider
      sliderTheme: SliderThemeData(
        activeTrackColor: AppColors.primaryLight,
        inactiveTrackColor: DarkColors.border,
        thumbColor: AppColors.primaryLight,
        overlayColor: AppColors.primaryLight.withAlpha(26),
        trackHeight: 4,
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // Cupertino Themes
  // ═══════════════════════════════════════════════════════════════════════════

  static CupertinoThemeData get cupertinoThemeData => CupertinoThemeData(
    primaryColor: AppColors.primary,
    primaryContrastingColor: AppColors.secondary,
    scaffoldBackgroundColor: LightColors.background,
    barBackgroundColor: LightColors.surface,
    textTheme: CupertinoTextThemeData(
      navTitleTextStyle: AppTypography.headlineMedium.copyWith(
        color: LightColors.textPrimary,
      ),
      navLargeTitleTextStyle: AppTypography.headlineLarge.copyWith(
        color: LightColors.textPrimary,
      ),
      textStyle: AppTypography.bodyMedium.copyWith(
        color: LightColors.textPrimary,
      ),
      actionTextStyle: AppTypography.bodyMedium.copyWith(
        color: AppColors.primary,
      ),
      tabLabelTextStyle: AppTypography.labelSmall,
    ),
  );

  static CupertinoThemeData get darkCupertinoThemeData => CupertinoThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryLight,
    primaryContrastingColor: AppColors.secondaryLight,
    scaffoldBackgroundColor: DarkColors.background,
    barBackgroundColor: DarkColors.surface,
    textTheme: CupertinoTextThemeData(
      navTitleTextStyle: AppTypography.headlineMedium.copyWith(
        color: DarkColors.textPrimary,
      ),
      navLargeTitleTextStyle: AppTypography.headlineLarge.copyWith(
        color: DarkColors.textPrimary,
      ),
      textStyle: AppTypography.bodyMedium.copyWith(
        color: DarkColors.textPrimary,
      ),
      actionTextStyle: AppTypography.bodyMedium.copyWith(
        color: AppColors.primaryLight,
      ),
      tabLabelTextStyle: AppTypography.labelSmall.copyWith(
        color: DarkColors.textPrimary,
      ),
    ),
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // Helper Methods
  // ═══════════════════════════════════════════════════════════════════════════

  /// 创建卡片容器 (Flat Design 风格)
  static Widget cardContainer({
    required Widget child,
    EdgeInsets? padding,
    EdgeInsets? margin,
    Color? color,
    bool isDark = false,
  }) {
    return Container(
      // margin: margin ?? const EdgeInsets.all(AppSpacing.cardMargin),
      decoration: BoxDecoration(
        color: color ?? (isDark ? DarkColors.surface : LightColors.surface),
      ),
      child:child,
    );
  }

  /// 创建可点击卡片 (Flat Design 风格)
  static Widget cardWithTap({
    required Widget child,
    required VoidCallback onTap,
    EdgeInsets? padding,
    EdgeInsets? margin,
    Color? color,
    bool isDark = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: cardContainer(
          child: child,
          padding: padding,
          margin: margin,
          color: color,
          isDark: isDark,
        ),
      ),
    );
  }

  /// 获取当前主题的边框按钮样式
  static ButtonStyle flatButtonStyle(BuildContext context, {Color? color}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveColor = color ?? AppColors.primary;

    return ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor:
          isDark ? DarkColors.surfaceVariant : LightColors.surfaceVariant,
      foregroundColor: effectiveColor,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.buttonRadius,
        side: BorderSide(
          color: isDark ? DarkColors.border : LightColors.border,
        ),
      ),
      padding: AppSpacing.buttonPadding,
      textStyle: AppTypography.labelLarge,
    );
  }

  /// 兼容旧代码
  @Deprecated('使用 lightThemeData 替代')
  static ThemeData get themeData => lightThemeData;
}
