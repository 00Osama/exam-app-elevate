import 'package:flutter/material.dart';

import 'app_colors.dart';

// Default border for all text fields
final OutlineInputBorder _border = OutlineInputBorder(
  borderRadius: BorderRadius.circular(4),
  borderSide: const BorderSide(color: AppColors.grey),
);

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.background,

  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    primary: AppColors.primary,
    error: AppColors.error,
    surface: AppColors.background,
  ),

  // App bar: back arrow and title on the left, no shadow
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.background,
    surfaceTintColor: Colors.transparent, // stops color change on scroll
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: false,
    titleSpacing: 0,
    iconTheme: IconThemeData(color: AppColors.black),
    titleTextStyle: TextStyle(
      color: AppColors.black,
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
  ),

  // Text fields: label always on top of the border, red when there is an error
  inputDecorationTheme: InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    labelStyle: const TextStyle(color: AppColors.grey, fontSize: 12),
    floatingLabelStyle: WidgetStateTextStyle.resolveWith(
      (states) => TextStyle(
        color: states.contains(WidgetState.error)
            ? AppColors.error
            : AppColors.grey,
        fontSize: 12,
      ),
    ),
    hintStyle: const TextStyle(color: AppColors.hint, fontSize: 14),
    errorStyle: const TextStyle(color: AppColors.error, fontSize: 12),
    border: _border,
    enabledBorder: _border,
    focusedBorder: _border.copyWith(
      borderSide: const BorderSide(color: AppColors.primary),
    ),
    errorBorder: _border.copyWith(
      borderSide: const BorderSide(color: AppColors.error),
    ),
    focusedErrorBorder: _border.copyWith(
      borderSide: const BorderSide(color: AppColors.error),
    ),
  ),

  // Main button: rounded, full width, grey when onPressed is null
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      disabledBackgroundColor: AppColors.disabled,
      disabledForegroundColor: AppColors.white,
      minimumSize: const Size(double.infinity, 48),
      shape: const StadiumBorder(),
      elevation: 0,
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    ),
  ),

  // Small underlined text buttons like "Forget password?"
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.black,
      padding: EdgeInsets.zero,
      minimumSize: Size.zero,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      textStyle: const TextStyle(
        fontSize: 12,
        decoration: TextDecoration.underline,
      ),
    ),
  ),

  // Remember me checkbox
  checkboxTheme: CheckboxThemeData(
    side: const BorderSide(color: AppColors.grey, width: 1.5),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
    fillColor: WidgetStateProperty.resolveWith(
      (states) => states.contains(WidgetState.selected)
          ? AppColors.primary
          : Colors.transparent,
    ),
    checkColor: const WidgetStatePropertyAll(AppColors.white),
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    visualDensity: VisualDensity.compact,
  ),

  // Text sizes used across the app
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: AppColors.black,
    ),
    bodyLarge: TextStyle(fontSize: 16, color: AppColors.black),
    bodyMedium: TextStyle(fontSize: 14, color: AppColors.black),
    bodySmall: TextStyle(fontSize: 13, color: AppColors.black),
  ),
);
