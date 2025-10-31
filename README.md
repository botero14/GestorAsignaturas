# App de ejemplo – MVVM + Provider + Floor

<!-- Badges ESENCIALES -->
![Flutter](https://img.shields.io/badge/Flutter-3.22%2B-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.4%2B-0175C2?logo=dart&logoColor=white)
![Provider](https://img.shields.io/badge/Provider-^6.0.0-5C6BC0)
![Floor](https://img.shields.io/badge/Floor-^1.4.2-455A64)
![Sqflite](https://img.shields.io/badge/sqflite-^2.3.0-546E7A)
![Android](https://img.shields.io/badge/Android-Supported-3DDC84?logo=android&logoColor=white)
[![License](https://img.shields.io/badge/License-MIT-black)](LICENSE)

> App de ejemplo con **MVVM + Provider** y persistencia local en **SQLite (Floor)**.  
> Módulo inicial: **Asignaturas**.

## Requisitos
- Flutter 3.22+ • Dart 3.4+ • Java 17
- Android SDK (si compilas Android)

## Dependencias (pubspec.yaml)
``` yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.0.0
  floor: ^1.4.2
  sqflite: ^2.3.0
  cupertino_icons: ^1.0.8
dev_dependencies:
  flutter_test:
    sdk: flutter
  floor_generator: ^1.4.2
  build_runner: ^2.4.7
  ´´´
  
Primeros pasos
bash
Copiar código
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run
Si cambias entidades/DAOs
bash
Copiar código
flutter pub run build_runner build --delete-conflicting-outputs
Estructura
core/ (db, theme, routing) · features/asignaturas/ (model, data/local, repositories, viewmodel, view)