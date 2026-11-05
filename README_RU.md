<p align="center">
  <img src="https://github.com/Pavluke/censor_it_flutter/blob/main/images/banner.gif?raw=true" alt="Banner" />
</p>

[![Pub](https://img.shields.io/pub/v/censor_it_flutter.svg)](https://pub.dartlang.org/packages/censor_it_flutter)

[En](README.md) | **Ru**

Flutter виджет для цензурирования текста на основе предопределенных паттернов с
настраиваемыми стратегиями. Построен на базе пакета
[censor_it](https://pub.dev/packages/censor_it).

<p align="center">Для лучшего понимания работы перейдите на <a href="https://pavluke.github.io/packages/?pkg=censor_it_flutter">демо</a> страницу</p>

<div align="center">
  <a href="https://pavluke.github.io/packages/?pkg=censor_it_flutter" 
     style="background: #10ac84; color: white; padding: 12px 24px; 
            text-decoration: none; border-radius: 6px; 
            font-weight: bold; display: inline-block;">
    Открыть демо
  </a>
</div>

## Введение

Когда дело доходит до цензурирования мата в вашем Flutter приложении, вам может
понадобиться обработка нескольких языков и настройка визуального представления
цензурированного контента. `CensorItWidget` предоставляет простое в
использовании решение с тремя различными стратегиями цензурирования.

## Поддерживаемые языки

- 🇺🇸 Английский (EN)
- 🇫🇮 Финский (FI)
- 🇫🇷 Французский (FR)
- 🇩🇪 Немецкий (DE)
- 🇮🇹 Итальянский (IT)
- 🇰🇿 Казахский (KK)
- 🇱🇻 Латышский (LV)
- 🇱🇹 Литовский (LT)
- 🇵🇹 Португальский (PT)
- 🇵🇱 Польский (PL)
- 🇷🇺 Русский (RU)
- 🇪🇸 Испанский (ES)
- 🇸🇪 Шведский (SV)
- 🇺🇦 Украинский (UK)

## Начало работы

Добавьте censor_it_flutter в ваш `pubspec.yaml`:

```yaml
dependencies:
  censor_it_flutter: ^2.2.0
```

Или используя команду:

```bash
flutter pub add censor_it_flutter
```

Импортируйте пакет в ваш Dart файл:

```dart
import 'package:censor_it_flutter/censor_it_flutter.dart';
```

## Использование

### Базовый пример

```dart
import 'package:flutter/material.dart';
import 'package:censor_it_flutter/censor_it_flutter.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: CensorItWidget.textBuilder(
            'Это работает, блять!',
            builder: (context, word) => '[цензура]',
            pattern: LanguagePattern.russian,
            censoredStyle: TextStyle(
              color: Colors.red,
              fontWeight: .bold,
            ),
          ),
        ),
      ),
    );
  }
}
```

## Фабричные конструкторы (v2.0.0+)

CensorItWidget v2.0.0 вводит три фабричных конструктора для различных стратегий
цензурирования:

### 1. CensorItWidget.textBuilder() - Замена текста

Заменяет мат на кастомный текст.

```dart
CensorItWidget.textBuilder(
  'Это пиздец!',
  builder: (context, word) => '[цензура]',
  pattern: LanguagePattern.russian,
  style: TextStyle(color: Colors.black),
  censoredStyle: TextStyle(color: Colors.red, fontWeight: .bold),
)
```

**Вывод:** "Это [цензура] [цензура]!" (цензурированные слова красным)

**Применение:** Простое текстовое цензурирование с кастомной стилизацией.

### 2. CensorItWidget.widgetBuilder() - Замена виджетами

Заменяет мат на Flutter виджеты.

```dart
CensorItWidget.widgetBuilder(
  'Это пиздец!',
  builder: (context, word) => Icon(Icons.block, size: 16, color: Colors.red),
  pattern: LanguagePattern.russian,
  alignment: .middle,
)
```

**Вывод:** "Это 🚫 🚫!" (мат заменён иконками)

**Применение:** Визуальное цензурирование иконками, изображениями или кастомными
виджетами.

### 3. CensorItWidget.overlayBuilder() - Визуальные эффекты

Применяет визуальные эффекты поверх мата, сохраняя оригинальный текст в макете.

```dart
CensorItWidget.overlayBuilder(
  'Это пиздец!',
  builder: (context, word, revealed) => Container(
    decoration: BoxDecoration(
      color: revealed ? Colors.transparent : Colors.black.withOpacity(0.8),
      borderRadius: .circular(4),
    ),
  ),
  pattern: LanguagePattern.russian,
  onTap: (revealed) => !revealed, // Нажми чтобы открыть/скрыть
)
```

**Вывод:** Мат покрыт тёмным оверлеем, нажмите чтобы открыть

**Применение:** Интерактивное цензурирование с эффектами размытия, оверлеями или
нажми-чтобы-открыть.

## Продвинутое использование

### Динамическая замена текста

```dart
CensorItWidget.textBuilder(
  'Это пиздец!',
  builder: (context, word) {
    // Разные замены в зависимости от длины слова
    if (word.length > 5) return '[ЦЕНЗУРА]';
    return '***';
  },
  pattern: LanguagePattern.russian,
)
```

### Кастомное цензурирование виджетами

```dart
CensorItWidget.widgetBuilder(
  'Пиздец!',
  builder: (context, word) => Container(
    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
    decoration: BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text('***', style: TextStyle(color: Colors.white, fontSize: 10)),
  ),
  pattern: LanguagePattern.russian,
  alignment: .middle,
  baseline: .alphabetic,
)
```

### Эффект размытия с оверлеем

```dart
import 'dart:ui';

CensorItWidget.overlayBuilder(
  'Пиздец!',
  builder: (context, word, revealed) => ClipRRect(
    child: BackdropFilter(
      filter: .blur(
        sigmaX: revealed ? 0 : 5,
        sigmaY: revealed ? 0 : 5,
      ),
      child: Container(color: Colors.transparent),
    ),
  ),
  pattern: LanguagePattern.russian,
  onTap: (revealed) => !revealed,
)
```

**Применение:** Элегантный эффект размытия с переключением.

### Анимированное открытие

```dart
CensorItWidget.overlayBuilder(
  'Пиздец!',
  builder: (context, word, revealed) => AnimatedContainer(
    duration: Duration(milliseconds: 300),
    decoration: BoxDecoration(
      gradient: revealed
          ? null
          : LinearGradient(colors: [Colors.purple, Colors.blue]),
      borderRadius: .circular(4),
    ),
  ),
  pattern: LanguagePattern.russian,
  onTap: (revealed) => !revealed,
)
```

**Применение:** Плавные анимированные переходы для открытия/скрытия.

## Языковые паттерны

### Использование предопределенных паттернов

```dart
// Один язык
CensorItWidget.textBuilder(
  'Пиздец!',
  builder: (context, word) => '***',
  pattern: LanguagePattern.russian,
)

// Все языки
CensorItWidget.textBuilder(
  'Fuck this блять!',
  builder: (context, word) => '***',
  pattern: LanguagePattern.all,
)
```

### Комбинирование нескольких языков

```dart
// Объединить конкретные языки
CensorItWidget.textBuilder(
  'Fuck this puta!',
  builder: (context, word) => '***',
  pattern: CensorPattern.multi([
    LanguagePattern.english,
    LanguagePattern.spanish,
  ]),
)
```

### Выбор паттерна по локали

```dart
// Получить паттерн по коду локали
final latvian = LanguagePattern.fromLocale('lv');
CensorItWidget.textBuilder(
  'pizdets',
  builder: (context, word) => '***',
  pattern: latvian,
)

// Несколько локалей
final multi = LanguagePattern.fromLocales(['en', 'es']);
CensorItWidget.textBuilder(
  'fuck this puta',
  builder: (context, word) => '***',
  pattern: multi,
)
```

### Пользовательские паттерны с RegExp

```dart
// Создать пользовательский паттерн с RegExp
final customPattern = CensorPattern.fromRegExp(
  RegExp(r'плохоеслово|другоеплохое', caseSensitive: false),
);

CensorItWidget.textBuilder(
  'плохоеслово здесь',
  builder: (context, word) => '[цензура]',
  pattern: customPattern,
)
```

## Возможности

- **Три стратегии цензурирования**: Выбирайте из текстового, виджетного или
  оверлейного цензурирования
- **Фабричные конструкторы**: Чистый API с `CensorItWidget.textBuilder()`,
  `CensorItWidget.widgetBuilder()` и т.д.
- **Кастомная стилизация**: Отдельные `style` и `censoredStyle` для обычного и
  цензурированного текста
- **Интерактивность**: Колбэк `onTap` для функционала открытия/скрытия в overlay
  builder
- **Выравнивание виджетов**: Контроль вертикального выравнивания с
  `PlaceholderAlignment` и `TextBaseline`
- **Обнаружение мата**: Построен на пакете `censor_it` с надёжным сопоставлением
  паттернов
- **Многоязычная поддержка**: 14+ языков с поддержкой Unicode
- **Высокая производительность**: Оптимизированное построение текстовых спанов
  для плавного рендеринга

## Что нового в v2.0.0

### Фабричные конструкторы

- ✅ **`CensorItWidget.textBuilder()`** - Замена на кастомный текст
- ✅ **`CensorItWidget.widgetBuilder()`** - Замена на виджеты
- ✅ **`CensorItWidget.overlayBuilder()`** - Применение визуальных эффектов

### Новые параметры

- ✅ **`censoredStyle`** - Кастомная стилизация для цензурированного текста
- ✅ **`onTap`** - Интерактивное нажми-чтобы-открыть в overlay builder
- ✅ **`alignment`** - Контроль вертикального выравнивания виджетов
- ✅ **`baseline`** - Выравнивание по базовой линии для виджетов

### Критические изменения

- ❌ **Удалён прямой конструктор** - Используйте фабричные конструкторы
- ❌ **Удалён параметр `chars`** - Реализуйте в функции builder
- ❌ **Переименован `CensorPattern`** в `LanguagePattern`

Смотрите [MIGRATION.md](MIGRATION.md) для инструкций по обновлению.

## История изменений

Список изменений доступен в файле [CHANGELOG.md](CHANGELOG.md)

## Участие в разработке

Не стесняйтесь вносить вклад в этот проект. Если вы нашли баг или хотите
добавить новую функцию, но не знаете, как это исправить/реализовать, пожалуйста,
напишите в [issues](https://github.com/pavluke/censor_it_flutter/issues). Если
вы исправили баг или реализовали какую-то функцию, пожалуйста, сделайте
[pull request](https://github.com/pavluke/censor_it_flutter/pulls).

## Лицензия

MIT License - подробности в файле [LICENSE](LICENSE)
