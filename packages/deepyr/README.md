# Deepyr

[![pub version](https://img.shields.io/pub/v/deepyr.svg)](https://pub.dev/packages/deepyr)

Jaspr + DaisyUI => Deepyr

A type-safe Dart implementation of DaisyUI components for Jaspr, providing a fluent API for building beautiful web apps with Tailwind CSS.

## Proof of concept

This package currently serves as a proof-of-concept for integrating DaisyUI with Jaspr using a type-safe Dart API.

## 🚀 Live Demo & Documentation

Explore all available components and see them in action on the official documentation site:

**[https://deepyr-doc.web.app/](https://deepyr-doc.web.app/)**

## **Design Principles**

- 🎯 **Type Safety** - Catch styling errors at compile time
- 🔧 **Fluent API** - Chain modifiers intuitively
- 📱 **Responsive** - Built-in breakpoint support
- 🎨 **DaisyUI Faithful** - 1:1 component mapping
- ⚡ **Performance** - Minimal runtime overhead

## Getting Started

1. **Add Dependency**

    Add `deepyr` to your `pubspec.yaml`:

    ```yaml
    dependencies:
      deepyr: ^0.1.6
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

## Deepyr Component Roadmap

### **Actions**

- ✅ **Button**
- ✅ **Dropdown**
- 🔲 **FAB / Speed Dial**
- ✅ **Modal**
- ✅ **Swap**
- ✅ **Theme Controller**

---

### **Data display**

- ✅ **Accordion**
- ✅ **Avatar**
- ✅ **Badge**
- ✅ **Card**
- 🔲 **Carousel**
- 🔲 **Chat bubble**
- ✅ **Collapse**
- ✅ **Countdown**
- ✅ **Diff**
- 🔲 **Hover Gallery**
- ✅ **Kbd**
- ✅ **List**
- ✅ **Stat**
- ✅ **Status**
- ✅ **Table**
- 🔲 **Timeline**

---

### **Navigation**

- ✅ **Breadcrumbs**
- 🔲 **Dock**
- ✅ **Link**
- ✅ **Menu**
- ✅ **Navbar**
- ✅ **Pagination**
- 🔲 **Steps**
- ✅ **Tab**

---

### **Feedback**

- ✅ **Alert**
- ✅ **Loading**
- ✅ **Progress**
- ✅ **Radial progress**
- ✅ **Skeleton**
- 🔲 **Toast**
- ✅ **Tooltip**

---

### **Data input**

- 🔲 **Calendar**
- ✅ **Checkbox**
- ✅ **Fieldset**
- ✅ **File Input**
- 🔲 **Filter**
- ✅ **Label**
- ✅ **Radio**
- ✅ **Range**
- 🔲 **Rating**
- ✅ **Select**
- ✅ **Input field (Text Input)**
- ✅ **Textarea**
- ✅ **Toggle**
- ✅ **Validator**

---

### **Layout**

- ✅ **Divider**
- ✅ **Drawer**
- ✅ **Footer**
- ✅ **Hero**
- ✅ **Indicator**
- ✅ **Join (group items)**
- ✅ **Mask**
- 🔲 **Stack**

---

### **Mockup**

- 🔲 **Browser**
- 🔲 **Code**
- 🔲 **Phone**
- 🔲 **Window**
