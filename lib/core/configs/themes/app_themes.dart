import 'package:flutter/material.dart';
import 'package:merc_mania/core/configs/themes/app_colors.dart';

class AppTheme {
  //Light mode
  static final lightTheme = ThemeData(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.lightBackground,
      brightness: Brightness.light,
      //App Bar
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primary,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold, 
          color: AppColors.title,
          fontSize: 25
        ),
        iconTheme: IconThemeData(
        color: AppColors.title,
        size: 25,
      )),
      //Elevated button
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.title,
              textStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)))),
      //Text button
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.title,
          textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30))
        )
      ),
      //Text 
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.primary
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.all(AppColors.title),
        overlayColor: WidgetStateProperty.all(AppColors.primary)
      ),
      cardTheme: CardTheme(
        color: AppColors.lightCardBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.grey[400])
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.primary,
      ),
      listTileTheme: ListTileThemeData(
        selectedTileColor: const Color.fromARGB(50, 255, 193, 214),
        textColor: AppColors.title,
        iconColor: AppColors.title
      ),
      bottomSheetTheme: BottomSheetThemeData(
        modalBackgroundColor: Colors.white
      ),
      tabBarTheme: TabBarTheme(
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        unselectedLabelColor: AppColors.title
      ),
      navigationBarTheme: NavigationBarThemeData(
        labelTextStyle: WidgetStatePropertyAll(TextStyle(color: AppColors.title, fontWeight: FontWeight.w600)),
        iconTheme: WidgetStatePropertyAll(IconThemeData(color: AppColors.title))
      )
  );
  //Dark mode
  static final darkTheme = ThemeData(
      primaryColor: Colors.grey[900],
      scaffoldBackgroundColor: AppColors.darkBackground,
      brightness: Brightness.dark,
      //App Bar
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primary,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold, 
          color: AppColors.title,
          fontSize: 25
        ),
        iconTheme: IconThemeData(
        color: AppColors.title,
        size: 25
      )),
      iconTheme: IconThemeData(
        color: AppColors.title,
        size: 30
      ),
      //Elevated button
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.title,
              textStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)))),
      //Text button
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30))
        )
      ),
      //Text 
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.primary
      ),
      textTheme: TextTheme(
        
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.all(AppColors.primary),
        overlayColor: WidgetStateProperty.all(AppColors.primary)
      ),
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: AppColors.primary),
        border: UnderlineInputBorder(),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
          color: AppColors.primary)),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
          color: AppColors.primary,
          width: 3)
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.primary,
      ),
      listTileTheme: ListTileThemeData(
        selectedTileColor: Colors.grey[800]
      ),
      tabBarTheme: TabBarTheme(
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        indicator: BoxDecoration( // Creates border
          color: AppColors.tab
        ),
        labelColor: AppColors.tabLabel,
        unselectedLabelColor: AppColors.title
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary
      )
  );
}
