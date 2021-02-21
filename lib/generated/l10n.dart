// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Day`
  String get TabBarDay {
    return Intl.message(
      'Day',
      name: 'TabBarDay',
      desc: '',
      args: [],
    );
  }

  /// `Month`
  String get TabBarMonth {
    return Intl.message(
      'Month',
      name: 'TabBarMonth',
      desc: '',
      args: [],
    );
  }

  /// `Week`
  String get TabBarWeek {
    return Intl.message(
      'Week',
      name: 'TabBarWeek',
      desc: '',
      args: [],
    );
  }

  /// `Year`
  String get TabBarYear {
    return Intl.message(
      'Year',
      name: 'TabBarYear',
      desc: '',
      args: [],
    );
  }

  /// `Income`
  String get MoneyWidgetIncome {
    return Intl.message(
      'Income',
      name: 'MoneyWidgetIncome',
      desc: '',
      args: [],
    );
  }

  /// `Money`
  String get MoneyWidgetMoney {
    return Intl.message(
      'Money',
      name: 'MoneyWidgetMoney',
      desc: '',
      args: [],
    );
  }

  /// `Expense`
  String get MoneyWidgetExpense {
    return Intl.message(
      'Expense',
      name: 'MoneyWidgetExpense',
      desc: '',
      args: [],
    );
  }

  /// `Select Theme`
  String get ThemeSelectionQuestion {
    return Intl.message(
      'Select Theme',
      name: 'ThemeSelectionQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Light Theme`
  String get ThemeSelectionOption1 {
    return Intl.message(
      'Light Theme',
      name: 'ThemeSelectionOption1',
      desc: '',
      args: [],
    );
  }

  /// `Dark Theme`
  String get ThemeSelectionOption2 {
    return Intl.message(
      'Dark Theme',
      name: 'ThemeSelectionOption2',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get AddingScreenCategories {
    return Intl.message(
      'Categories',
      name: 'AddingScreenCategories',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get AddingScreenDescription {
    return Intl.message(
      'Description',
      name: 'AddingScreenDescription',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get AddingScreenPrice {
    return Intl.message(
      'Price',
      name: 'AddingScreenPrice',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get AddingScreenDate {
    return Intl.message(
      'Date',
      name: 'AddingScreenDate',
      desc: '',
      args: [],
    );
  }

  /// `Income`
  String get AddingScreenIncome {
    return Intl.message(
      'Income',
      name: 'AddingScreenIncome',
      desc: '',
      args: [],
    );
  }

  /// `Expense`
  String get AddingScreenExpense {
    return Intl.message(
      'Expense',
      name: 'AddingScreenExpense',
      desc: '',
      args: [],
    );
  }

  /// `You've not added expense yet \n Lets start !`
  String get ExpenseListNoneExpense {
    return Intl.message(
      'You\'ve not added expense yet \n Lets start !',
      name: 'ExpenseListNoneExpense',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get AddingScreenSave {
    return Intl.message(
      'Save',
      name: 'AddingScreenSave',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get DrawerThemeText {
    return Intl.message(
      'Theme',
      name: 'DrawerThemeText',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get DrawerLanguageText {
    return Intl.message(
      'Language',
      name: 'DrawerLanguageText',
      desc: '',
      args: [],
    );
  }

  /// `Payment`
  String get CategoryPayment {
    return Intl.message(
      'Payment',
      name: 'CategoryPayment',
      desc: '',
      args: [],
    );
  }

  /// `Dues`
  String get CategoryDues {
    return Intl.message(
      'Dues',
      name: 'CategoryDues',
      desc: '',
      args: [],
    );
  }

  /// `Shopping`
  String get CategoryShopping {
    return Intl.message(
      'Shopping',
      name: 'CategoryShopping',
      desc: '',
      args: [],
    );
  }

  /// `Education`
  String get CategoryEducation {
    return Intl.message(
      'Education',
      name: 'CategoryEducation',
      desc: '',
      args: [],
    );
  }

  /// `Entertainment`
  String get CategoryEntertainment {
    return Intl.message(
      'Entertainment',
      name: 'CategoryEntertainment',
      desc: '',
      args: [],
    );
  }

  /// `Rent`
  String get CategoryRent {
    return Intl.message(
      'Rent',
      name: 'CategoryRent',
      desc: '',
      args: [],
    );
  }

  /// `Self-care`
  String get CategorySelfcare {
    return Intl.message(
      'Self-care',
      name: 'CategorySelfcare',
      desc: '',
      args: [],
    );
  }

  /// `Health`
  String get CategoryHealth {
    return Intl.message(
      'Health',
      name: 'CategoryHealth',
      desc: '',
      args: [],
    );
  }

  /// `Repair`
  String get CategoryRepair {
    return Intl.message(
      'Repair',
      name: 'CategoryRepair',
      desc: '',
      args: [],
    );
  }

  /// `Vacation`
  String get CategoryVacation {
    return Intl.message(
      'Vacation',
      name: 'CategoryVacation',
      desc: '',
      args: [],
    );
  }

  /// `Food`
  String get CategoryEatDrink {
    return Intl.message(
      'Food',
      name: 'CategoryEatDrink',
      desc: '',
      args: [],
    );
  }

  /// `Others`
  String get CategoryOthers {
    return Intl.message(
      'Others',
      name: 'CategoryOthers',
      desc: '',
      args: [],
    );
  }

  /// `Individual`
  String get AppBarIndividual {
    return Intl.message(
      'Individual',
      name: 'AppBarIndividual',
      desc: '',
      args: [],
    );
  }

  /// `Corporate`
  String get AppBarCorporate {
    return Intl.message(
      'Corporate',
      name: 'AppBarCorporate',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'hi'),
      Locale.fromSubtags(languageCode: 'ja'),
      Locale.fromSubtags(languageCode: 'pt'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'tr'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}