import 'package:flutter/material.dart';

abstract class ProfileState {
  ThemeMode get themeMode;
  Locale? get locale;
}

class ThemeLight extends ProfileState {
  final Locale? _locale;
  ThemeLight({Locale? locale}) : _locale = locale;

  @override
  ThemeMode get themeMode => ThemeMode.light;

  @override
  Locale? get locale => _locale;
}

class ThemeDark extends ProfileState {
  final Locale? _locale;
  ThemeDark({Locale? locale}) : _locale = locale;

  @override
  ThemeMode get themeMode => ThemeMode.dark;

  @override
  Locale? get locale => _locale;
}
