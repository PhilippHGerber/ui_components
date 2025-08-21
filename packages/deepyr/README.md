# Deepyr

[![pub version](https://img.shields.io/pub/v/deepyr.svg)](https://pub.dev/packages/deepyr)

Jaspr + DaisyUI => Deepyr

A type-safe Dart implementation of DaisyUI components for Jaspr, providing a fluent API for building beautiful web apps with Tailwind CSS.

## Proof of concept

This package currently serves as a proof-of-concept for integrating DaisyUI with Jaspr using a type-safe Dart API.

## Core Features

- **Type-Safe & Autocomplete:** Replace raw CSS strings like `'btn-primary'` with Dart objects like `Button.primary`, catching typos at compile time.
- **Fluent API:** Intuitively chain modifiers for responsive and state-based designs, like `Button.lg.at(Breakpoint.md)` or `TextUtil.center.on(Is.hover)`.
- **Component-First:** Work with high-level abstractions like `Card`, `Modal`, and `Drawer` without needing to memorize the underlying HTML structure.

## Getting Started

1. **Add Dependency**

    Add `deepyr` to your `pubspec.yaml`:

    ```yaml
    dependencies:
      deepyr: ^0.0.1
    ```

2. **Setup Tailwind CSS**

    `deepyr` is a component library, not a CSS framework. You must have **Tailwind CSS v4** and **DaisyUI v5** installed and configured in your Jaspr project for the components to be styled correctly.

## Usage Example

```dart
import 'package:jaspr/jaspr.dart';
import 'package:deepyr/deepyr.dart';

class MyComponent extends StatelessComponent {
  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield Button(
      [
        Icon('favorite'),
        text('Click Me'),
      ],
      // Apply styles in a type-safe list
      style: [
        Button.primary, // Apply the primary color
        Button.lg.at(Breakpoint.md), // Becomes large on medium screens and up
      ],
      onClick: (_) => print('Button clicked!'),
    );
  }
}
```
