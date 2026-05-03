import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_media_app/app/utils/theme/size.dart';
import 'app_colors.dart';
import 'app_typography.dart';


abstract class AppTheme {


  // ══════════════════════════════════════════
  //  LIGHT THEME
  // ══════════════════════════════════════════


  static ThemeData get light => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: _lightColorScheme,
    textTheme: AppTypography.buildTextTheme(isDark: false),
    scaffoldBackgroundColor: AppColors.neutral0,
    fontFamily: 'Poppins',

    // ── AppBar ─────────────────────────
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleTextStyle: AppTypography.appBar(color: AppColors.neutral900),
      toolbarHeight: 60,

      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      iconTheme: const IconThemeData(
        color: AppColors.neutral700,
        size: 24,
      ),
      actionsIconTheme: const IconThemeData(
        color: AppColors.neutral700,
        size: 24,
      ),
    ),

    // ── Bottom Navigation ───────────────
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.neutral0,
      selectedItemColor: AppColors.primary500,
      unselectedItemColor: AppColors.neutral400,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      selectedLabelStyle: AppTypography.labelSmall(),
      unselectedLabelStyle: AppTypography.labelSmall(),
    ),

    // ── Navigation Bar (M3) ─────────────
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.neutral0,
      indicatorColor: AppColors.primary100,
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: AppColors.primary600, size: 24);
        }
        return const IconThemeData(color: AppColors.neutral500, size: 24);
      }),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppTypography.labelSmall(color: AppColors.primary600);
        }
        return AppTypography.labelSmall(color: AppColors.neutral500);
      }),
      elevation: 0,
      height: 72,
    ),

    // ── Elevated Button ─────────────────
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary500,
        foregroundColor: AppColors.neutral0,
        disabledBackgroundColor: AppColors.neutral200,
        disabledForegroundColor: AppColors.neutral400,
        elevation: 0,
        shadowColor: Colors.transparent,
        padding: AppSpacing.buttonPadding,
        minimumSize: const Size(0, 48),
        textStyle: AppTypography.labelLarge(),
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.radiusMd,
        ),
      ).copyWith(
        elevation: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) return 0;
          if (states.contains(WidgetState.hovered)) return 2;
          return 0;
        }),
        overlayColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return AppColors.white20;
          }
          return null;
        }),
      ),
    ),

    // ── Outlined Button ─────────────────
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary500,
        disabledForegroundColor: AppColors.neutral400,
        padding: AppSpacing.buttonPadding,
        minimumSize: const Size(0, 48),
        textStyle: AppTypography.labelLarge(),
        side: const BorderSide(color: AppColors.neutral300, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.radiusMd,
        ),
      ).copyWith(
        side: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.focused)) {
            return const BorderSide(color: AppColors.primary500, width: 1.5);
          }
          return const BorderSide(color: AppColors.neutral300, width: 1.5);
        }),
      ),
    ),

    // ── Text Button ─────────────────────
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary500,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        textStyle: AppTypography.labelLarge(),
        minimumSize: const Size(0, 36),
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.radiusMd,
        ),
      ),
    ),

    // ── FilledButton ─────────────────────
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.primary500,
        foregroundColor: AppColors.neutral0,
        padding: AppSpacing.buttonPadding,
        minimumSize: const Size(0, 48),
        textStyle: AppTypography.labelLarge(),
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.radiusMd,
        ),
      ),
    ),

    // ── FAB ─────────────────────────────
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary500,
      foregroundColor: AppColors.neutral0,
      elevation: 4,
      highlightElevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.radiusXl,
      ),
      extendedTextStyle: AppTypography.labelLarge(),
      extendedPadding:
      const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
    ),

    // ── Input / TextField ───────────────
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.neutral100,
      contentPadding: AppSpacing.inputPadding,
      hintStyle: AppTypography.bodyMedium(color: AppColors.neutral400),
      labelStyle: AppTypography.bodyMedium(color: AppColors.neutral600),
      floatingLabelStyle: AppTypography.labelMedium(
        color: AppColors.primary500,
      ),
      errorStyle: AppTypography.bodySmall(color: AppColors.error500),
      helperStyle: AppTypography.bodySmall(color: AppColors.neutral500),
      prefixIconColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.focused)) {
          return AppColors.primary500;
        }
        return AppColors.neutral400;
      }),
      suffixIconColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.focused)) {
          return AppColors.primary500;
        }
        return AppColors.neutral400;
      }),
      border: OutlineInputBorder(
        borderRadius: AppRadius.radiusMd,
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: AppRadius.radiusMd,
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppRadius.radiusMd,
        borderSide: const BorderSide(
          color: AppColors.primary500,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: AppRadius.radiusMd,
        borderSide: const BorderSide(color: AppColors.error500, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: AppRadius.radiusMd,
        borderSide: const BorderSide(color: AppColors.error500, width: 2),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: AppRadius.radiusMd,
        borderSide: BorderSide.none,
      ),
      isDense: false,
      alignLabelWithHint: true,
    ),

    // ── Card ─────────────────────────────
    cardTheme: CardThemeData(
      color: AppColors.neutral0,
      shadowColor: Colors.black.withOpacity(0.06),
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.radiusLg,
        side: const BorderSide(color: AppColors.neutral200, width: 1),
      ),
      clipBehavior: Clip.antiAlias,
    ),

    // ── Chip ─────────────────────────────
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.neutral100,
      selectedColor: AppColors.primary100,
      disabledColor: AppColors.neutral100,
      labelStyle: AppTypography.labelMedium(color: AppColors.neutral700),
      secondaryLabelStyle:
      AppTypography.labelMedium(color: AppColors.primary700),
      padding: AppSpacing.chipPadding,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.radiusFull,
        side: const BorderSide(color: AppColors.neutral200),
      ),
      showCheckmark: false,
      elevation: 0,
      pressElevation: 0,
    ),

    // ── Dialog ───────────────────────────
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.neutral0,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shadowColor: Colors.black.withOpacity(0.12),
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.radiusXl2,
      ),
      titleTextStyle: AppTypography.titleLarge(color: AppColors.neutral900),
      contentTextStyle:
      AppTypography.bodyMedium(color: AppColors.neutral600),
    ),

    // ── Bottom Sheet ─────────────────────
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.neutral0,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      modalElevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadius.xl2),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      dragHandleColor: AppColors.neutral300,
      dragHandleSize: const Size(40, 4),
      showDragHandle: true,
    ),

    // ── Snack Bar ────────────────────────
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.neutral900,
      contentTextStyle: AppTypography.bodyMedium(color: AppColors.neutral50),
      actionTextColor: AppColors.primary300,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.radiusMd),
      elevation: 4,
      width: null,
      insetPadding: const EdgeInsets.all(AppSpacing.lg),
    ),

    // ── List Tile ────────────────────────
    listTileTheme: ListTileThemeData(
      contentPadding:
      const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      titleTextStyle: AppTypography.titleMedium(color: AppColors.neutral900),
      subtitleTextStyle:
      AppTypography.bodySmall(color: AppColors.neutral500),
      iconColor: AppColors.neutral500,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.radiusMd),
      minVerticalPadding: AppSpacing.md,
      dense: false,
    ),

    // ── Divider ──────────────────────────
    dividerTheme: const DividerThemeData(
      color: AppColors.neutral200,
      thickness: 1,
      space: 1,
    ),

    // ── Switch ───────────────────────────
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.neutral0;
        }
        return AppColors.neutral400;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary500;
        }
        return AppColors.neutral200;
      }),
      trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
    ),

    // ── Checkbox ─────────────────────────
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary500;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(AppColors.neutral0),
      side: const BorderSide(color: AppColors.neutral400, width: 1.5),
      shape: RoundedRectangleBorder(borderRadius: AppRadius.radiusXs),
    ),

    // ── Radio ────────────────────────────
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary500;
        }
        return AppColors.neutral400;
      }),
    ),

    // ── Slider ───────────────────────────
    sliderTheme: SliderThemeData(
      activeTrackColor: AppColors.primary500,
      inactiveTrackColor: AppColors.neutral200,
      thumbColor: AppColors.primary500,
      overlayColor: AppColors.primary100,
      valueIndicatorColor: AppColors.neutral900,
      valueIndicatorTextStyle:
      AppTypography.labelSmall(color: AppColors.neutral0),
      trackHeight: 4,
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
      overlayShape: const RoundSliderOverlayShape(overlayRadius: 24),
    ),

    // ── Progress indicator ───────────────
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primary500,
      linearTrackColor: AppColors.primary100,
      circularTrackColor: AppColors.primary100,
      linearMinHeight: 4,
    ),

    // ── Tab Bar ──────────────────────────
    tabBarTheme: TabBarThemeData(
      labelColor: AppColors.primary600,
      unselectedLabelColor: AppColors.neutral500,
      indicatorColor: AppColors.primary500,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: AppTypography.labelMedium(color: AppColors.primary600),
      unselectedLabelStyle:
      AppTypography.labelMedium(color: AppColors.neutral500),
      dividerColor: AppColors.neutral200,
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          return AppColors.primary50;
        }
        return Colors.transparent;
      }),
    ),

    // ── Popup Menu ───────────────────────
    popupMenuTheme: PopupMenuThemeData(
      color: AppColors.neutral0,
      surfaceTintColor: Colors.transparent,
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.12),
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.radiusMd,
        side: const BorderSide(color: AppColors.neutral200),
      ),
      textStyle: AppTypography.bodyMedium(color: AppColors.neutral800),
      labelTextStyle: WidgetStateProperty.all(
        AppTypography.bodyMedium(color: AppColors.neutral800),
      ),
    ),

    // ── Tooltip ──────────────────────────
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: AppColors.neutral900,
        borderRadius: AppRadius.radiusSm,
      ),
      textStyle: AppTypography.bodySmall(color: AppColors.neutral50),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      verticalOffset: 12,
    ),

    // ── Icon ─────────────────────────────
    iconTheme: const IconThemeData(
      color: AppColors.neutral700,
      size: 24,
    ),

    // ── Badge ────────────────────────────
    badgeTheme: BadgeThemeData(
      backgroundColor: AppColors.error500,
      textColor: AppColors.neutral0,
      textStyle: AppTypography.labelSmall(color: AppColors.neutral0),
      padding: const EdgeInsets.symmetric(horizontal: 6),
      smallSize: 8,
      largeSize: 20,
    ),
  );

  // ══════════════════════════════════════════
  //  DARK THEME
  // ══════════════════════════════════════════
  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: _darkColorScheme,
    textTheme: AppTypography.buildTextTheme(isDark: true),
    scaffoldBackgroundColor: AppColors.neutral950,
    fontFamily: 'Poppins',

    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleTextStyle: AppTypography.appBar(color: AppColors.neutral50),
      toolbarHeight: 60,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      iconTheme: const IconThemeData(color: AppColors.neutral300, size: 24),
      actionsIconTheme:
      const IconThemeData(color: AppColors.neutral300, size: 24),

    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.neutral900,
      selectedItemColor: AppColors.primary400,
      unselectedItemColor: AppColors.neutral500,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      selectedLabelStyle: AppTypography.labelSmall(),
      unselectedLabelStyle: AppTypography.labelSmall(),
    ),

    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.neutral900,
      indicatorColor: AppColors.primary900,
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: AppColors.primary300, size: 24);
        }
        return const IconThemeData(color: AppColors.neutral500, size: 24);
      }),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppTypography.labelSmall(color: AppColors.primary300);
        }
        return AppTypography.labelSmall(color: AppColors.neutral500);
      }),
      elevation: 0,
      height: 72,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary500,
        foregroundColor: AppColors.neutral0,
        disabledBackgroundColor: AppColors.neutral800,
        disabledForegroundColor: AppColors.neutral600,
        elevation: 0,
        shadowColor: Colors.transparent,
        padding: AppSpacing.buttonPadding,
        minimumSize: const Size(0, 48),
        textStyle: AppTypography.labelLarge(),
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.radiusMd,
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary300,
        padding: AppSpacing.buttonPadding,
        minimumSize: const Size(0, 48),
        textStyle: AppTypography.labelLarge(),
        side: const BorderSide(color: AppColors.neutral700, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.radiusMd,
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary400,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        textStyle: AppTypography.labelLarge(),
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.radiusMd,
        ),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.neutral800,
      contentPadding: AppSpacing.inputPadding,
      hintStyle: AppTypography.bodyMedium(color: AppColors.neutral600),
      labelStyle: AppTypography.bodyMedium(color: AppColors.neutral400),
      floatingLabelStyle:
      AppTypography.labelMedium(color: AppColors.primary400),
      errorStyle: AppTypography.bodySmall(color: AppColors.error500),
      helperStyle: AppTypography.bodySmall(color: AppColors.neutral500),
      border: OutlineInputBorder(
        borderRadius: AppRadius.radiusMd,
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: AppRadius.radiusMd,
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppRadius.radiusMd,
        borderSide: const BorderSide(color: AppColors.primary400, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: AppRadius.radiusMd,
        borderSide: const BorderSide(color: AppColors.error500, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: AppRadius.radiusMd,
        borderSide: const BorderSide(color: AppColors.error500, width: 2),
      ),
    ),

    cardTheme: CardThemeData(
      color: AppColors.neutral800,
      shadowColor: Colors.black.withOpacity(0.3),
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.radiusLg,
        side: const BorderSide(color: AppColors.neutral700, width: 1),
      ),
      clipBehavior: Clip.antiAlias,
    ),

    dividerTheme: const DividerThemeData(
      color: AppColors.neutral800,
      thickness: 1,
      space: 1,
    ),

    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.neutral0;
        }
        return AppColors.neutral500;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary500;
        }
        return AppColors.neutral700;
      }),
      trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
    ),

    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary500;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(AppColors.neutral0),
      side: const BorderSide(color: AppColors.neutral600, width: 1.5),
      shape: RoundedRectangleBorder(borderRadius: AppRadius.radiusXs),
    ),

    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primary400,
      linearTrackColor: AppColors.neutral800,
      circularTrackColor: AppColors.neutral800,
      linearMinHeight: 4,
    ),

    chipTheme: ChipThemeData(
      backgroundColor: AppColors.neutral800,
      selectedColor: AppColors.primary900,
      labelStyle: AppTypography.labelMedium(color: AppColors.neutral300),
      padding: AppSpacing.chipPadding,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.radiusFull,
        side: const BorderSide(color: AppColors.neutral700),
      ),
      showCheckmark: false,
      elevation: 0,
    ),

    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.neutral50,
      contentTextStyle:
      AppTypography.bodyMedium(color: AppColors.neutral900),
      actionTextColor: AppColors.primary600,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.radiusMd),
      elevation: 4,
      insetPadding: const EdgeInsets.all(AppSpacing.lg),
    ),

    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.neutral900,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadius.xl2),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      dragHandleColor: AppColors.neutral700,
      dragHandleSize: const Size(40, 4),
      showDragHandle: true,
    ),

    iconTheme: const IconThemeData(color: AppColors.neutral300, size: 24),

    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: AppColors.neutral100,
        borderRadius: AppRadius.radiusSm,
      ),
      textStyle: AppTypography.bodySmall(color: AppColors.neutral900),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),

    tabBarTheme: TabBarThemeData(
      labelColor: AppColors.primary300,
      unselectedLabelColor: AppColors.neutral500,
      indicatorColor: AppColors.primary400,
      labelStyle: AppTypography.labelMedium(color: AppColors.primary300),
      unselectedLabelStyle:
      AppTypography.labelMedium(color: AppColors.neutral500),
      dividerColor: AppColors.neutral800,
    ),

    popupMenuTheme: PopupMenuThemeData(
      color: AppColors.neutral800,
      surfaceTintColor: Colors.transparent,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.radiusMd,
        side: const BorderSide(color: AppColors.neutral700),
      ),
      textStyle: AppTypography.bodyMedium(color: AppColors.neutral100),
    ),

    badgeTheme: BadgeThemeData(
      backgroundColor: AppColors.error500,
      textColor: AppColors.neutral0,
      textStyle: AppTypography.labelSmall(color: AppColors.neutral0),
      padding: const EdgeInsets.symmetric(horizontal: 6),
      smallSize: 8,
      largeSize: 20,
    ),

    listTileTheme: ListTileThemeData(
      contentPadding:
      const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      titleTextStyle: AppTypography.titleMedium(color: AppColors.neutral50),
      subtitleTextStyle:
      AppTypography.bodySmall(color: AppColors.neutral500),
      iconColor: AppColors.neutral500,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.radiusMd),
      minVerticalPadding: AppSpacing.md,
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary500,
      foregroundColor: AppColors.neutral0,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.radiusXl),
      extendedTextStyle: AppTypography.labelLarge(),
    ),
  );

  // ── Color Schemes ─────────────────────────
  static const ColorScheme _lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primary500,
    onPrimary: AppColors.neutral0,
    primaryContainer: AppColors.primary100,
    onPrimaryContainer: AppColors.primary800,
    secondary: AppColors.secondary500,
    onSecondary: AppColors.neutral0,
    secondaryContainer: AppColors.secondary100,
    onSecondaryContainer: AppColors.secondary700,
    tertiary: AppColors.warning500,
    onTertiary: AppColors.neutral0,
    tertiaryContainer: AppColors.warning50,
    onTertiaryContainer: AppColors.warning700,
    error: AppColors.error500,
    onError: AppColors.neutral0,
    errorContainer: AppColors.error50,
    onErrorContainer: AppColors.error700,
    surface: AppColors.neutral0,
    onSurface: AppColors.neutral900,
    surfaceContainerHighest: AppColors.neutral100,
    onSurfaceVariant: AppColors.neutral600,
    outline: AppColors.neutral300,
    outlineVariant: AppColors.neutral200,
    shadow: Colors.black,
    scrim: Colors.black,
    inverseSurface: AppColors.neutral900,
    onInverseSurface: AppColors.neutral50,
    inversePrimary: AppColors.primary300,
  );

  static const ColorScheme _darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.primary400,
    onPrimary: AppColors.neutral900,
    primaryContainer: AppColors.primary800,
    onPrimaryContainer: AppColors.primary100,
    secondary: AppColors.secondary400,
    onSecondary: AppColors.neutral900,
    secondaryContainer: AppColors.secondary700,
    onSecondaryContainer: AppColors.secondary100,
    tertiary: AppColors.warning500,
    onTertiary: AppColors.neutral900,
    tertiaryContainer: AppColors.warning700,
    onTertiaryContainer: AppColors.warning50,
    error: AppColors.error500,
    onError: AppColors.neutral900,
    errorContainer: AppColors.error700,
    onErrorContainer: AppColors.error50,
    surface: AppColors.neutral900,
    onSurface: AppColors.neutral50,
    surfaceContainerHighest: AppColors.neutral800,
    onSurfaceVariant: AppColors.neutral400,
    outline: AppColors.neutral700,
    outlineVariant: AppColors.neutral800,
    shadow: Colors.black,
    scrim: Colors.black,
    inverseSurface: AppColors.neutral50,
    onInverseSurface: AppColors.neutral900,
    inversePrimary: AppColors.primary600,
  );
}