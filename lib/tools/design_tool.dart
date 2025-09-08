

import 'package:flutter/material.dart';

const double getToolbarHeight = 48;
const double getTabBarHeight = 45;
const double getNavigationBarHeight = 58;

const Color getPrimaryColor = Color(0xFF1EA4FD);
const Color getOnPrimaryColor = Color(0xFF1EA4FD);
const Color getSecondaryColor = Color(0x4D0060F8);
const Color getOnSecondaryColor = Color(0x4D0060F8);
const Color getErrorColor = Color(0xFFFF5A4A);
const Color getOnErrorColor = Color(0xFFFF5A4A);
const Color getSurfaceColor = Color(0xFFFFFFFF);
const Color getOnSurfaceColor = Color(0xFF000000);

const Color getAppBarColor = Color(0xFFFFFFFF);
const Color getNavigationBarColor = Color(0xFFFFFFFF);
const Color getDividerColor = Color(0xFFF1F0F0);

const Color getTextPrimaryColor = Color(0xFF222222);
const Color getTextSecondaryColor = Color(0xFF666666);
const Color getTextHintColor = Color(0xFF999999);

// 需求页面相关颜色
const Color getDemandBackgroundColor = Color(0xFFF7F8FC);
const Color getDemandContactButtonColor = Color(0xFF4678F8);
const Color getDemandBadgeColor = Color(0xFFFF0000);
const Color getDemandTimeColor = Color(0xFFFF8523);
const Color getDemandBorderColor = Color(0xFFDBDFE3);
const Color getDemandUnselectedTextColor = Color(0xFF9D9FA4);

// 配送VIP页面颜色
const Color getDeliveryVipBackgroundColor = Color(0xFF141A28);
const Color getDeliveryVipAccentColor = Color(0xFFB4633E);
const Color getDeliveryVipRecommendColor = Color(0xFFFFD700);
const Color getDeliveryVipPurchasedColor = Color(0xFF4CAF50);
const List<Color> getDeliveryBenefitCardGradient = [
  Color(0xFF212D4F),
  Color(0xFF131C38)
];
const List<Color> getDeliveryVipBuyBtnBgColor = [
  Color(0xFFFFD700),
  Color(0xFFFFA500)
];

const FontWeight getRegular = FontWeight.w400;
const FontWeight getMedium = FontWeight.w500;
const FontWeight getSemiBold = FontWeight.w600;
const FontWeight getBold = FontWeight.w700;
const FontWeight getExtraBold = FontWeight.w800;

class DesignTool {
  static ThemeData theme() {
    TextStyle textStyle = const TextStyle(
      color: getTextPrimaryColor,
      fontWeight: getRegular,
    );
    return ThemeData.from(
      colorScheme: const ColorScheme.light(
        primary: getPrimaryColor,
        onPrimary: getOnPrimaryColor,
        secondary: getSecondaryColor,
        onSecondary: getOnSecondaryColor,
        error: getErrorColor,
        onError: getOnErrorColor,
        surface: getSurfaceColor,
        onSurface: getOnSurfaceColor,
      ),
      textTheme: TextTheme(
        titleLarge: textStyle.copyWith(fontSize: 20),
        titleMedium: textStyle.copyWith(fontSize: 16),
        titleSmall: textStyle.copyWith(fontSize: 14),
        bodyLarge: textStyle.copyWith(fontSize: 16),
        bodyMedium: textStyle.copyWith(fontSize: 14),
        bodySmall: textStyle.copyWith(fontSize: 12),
        labelLarge: textStyle.copyWith(fontSize: 14),
        labelMedium: textStyle.copyWith(fontSize: 12),
        labelSmall: textStyle.copyWith(fontSize: 10),
      ),
    ).copyWith(
      highlightColor: Colors.transparent,
      appBarTheme: AppBarTheme(
        backgroundColor: getAppBarColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        shadowColor: getDividerColor,
        surfaceTintColor: getAppBarColor,
        centerTitle: true,
        toolbarHeight: getToolbarHeight,
        titleTextStyle: textStyle.copyWith(
          fontSize: 18,
          fontWeight: getBold,
        ),
      ),
      tabBarTheme: TabBarTheme(
        // indicator: GetUnderlineIndicator(
        //   borderSide: const BorderSide(
        //     width: 3,
        //     color: getPrimaryColor,
        //   ),
        //   borderRadius: BorderRadius.circular(1.5),
        //   insets: const EdgeInsets.only(left: 5, right: 5, bottom: 1.5),
        // ),
        indicatorSize: TabBarIndicatorSize.label,
        dividerHeight: 0,
        labelPadding: const EdgeInsets.symmetric(horizontal: 10),
        labelStyle: textStyle.copyWith(
          fontSize: 15,
        ),
        unselectedLabelStyle: textStyle.copyWith(
          color: getTextSecondaryColor,
          fontSize: 15,
        ),
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        splashFactory: NoSplash.splashFactory,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: getNavigationBarColor,
        elevation: 0,
      ),
      dividerTheme: const DividerThemeData(
        color: getDividerColor,
        space: 1,
        thickness: 1,
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          highlightColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: getTextPrimaryColor,
          overlayColor: Colors.transparent,
          textStyle: textStyle.copyWith(fontSize: 14),
          splashFactory: NoSplash.splashFactory,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: getTextPrimaryColor,
          overlayColor: Colors.transparent,
          textStyle: textStyle.copyWith(fontSize: 14),
          splashFactory: NoSplash.splashFactory,
        ),
      ),
      splashFactory: NoSplash.splashFactory,
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: textStyle.copyWith(
          color: getTextHintColor,
          fontSize: 14,
        ),
        isCollapsed: true,
        contentPadding: const EdgeInsets.all(16),
        border: InputBorder.none,
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: getTextPrimaryColor,
      ),
    );
  }
}
