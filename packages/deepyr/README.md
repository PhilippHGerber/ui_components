# Deepyr

[![pub version](https://img.shields.io/pub/v/deepyr.svg)](https://pub.dev/packages/deepyr)

Jaspr + DaisyUI => Deepyr

A type-safe Dart implementation of DaisyUI components for Jaspr, providing a fluent API for building beautiful web apps with Tailwind CSS.

## Proof of concept

This package currently serves as a proof-of-concept for integrating DaisyUI with Jaspr using a type-safe Dart API.

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
      deepyr: ^0.0.4
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

### **Phase 1: Core Foundation**

Essential building blocks - No dependencies required

- ✅ **Button**
- ✅ **Input**
- ✅ **Badge**
- ✅ **Loading**
- ✅ **Alert**
- ✅ **Card**
- ✅ **Divider**

---

### **Phase 2: Form Components**

Essential form inputs and controls

- 🔲 **Checkbox** - Boolean selection with custom styling
- 🔲 **Radio** - Single choice selection from multiple options
- 🔲 **Toggle** - Modern switch-style boolean input
- 🔲 **Textarea** - Multi-line text input with resize options
- 🔲 **Select** - Dropdown selection with custom styling
- 🔲 **Progress** - Task completion and loading progress bars
- 🔲 **Link** - Enhanced hyperlinks with hover states

---

### **Phase 3: Layout & Navigation**

Page structure and user navigation

- 🔲 **Navbar** - Header navigation bars
- 🔲 **Footer** - Page footers with links and branding
- 🔲 **Breadcrumbs** - Navigation hierarchy display
- 🔲 **Hero** - Landing page headers and call-to-action sections
- 🔲 **Skeleton** - Loading state placeholders
- 🔲 **Avatar** - User profile images and placeholders

---

### **Phase 4: Data Display**

Presenting information and data

- 🔲 **Table** - Structured data presentation
- 🔲 **Stats** - Metrics and statistics display
- 🔲 **List** - Structured content organization
- 🔲 **Timeline** - Chronological data visualization
- 🔲 **Kbd** - Keyboard shortcut display
- 🔲 **Mask** - Image and content shape transformations

---

### **Phase 5: Advanced Feedback**

Enhanced user notifications and status

- 🔲 **Toast** - Floating notification messages
- 🔲 **Radial Progress** - Circular progress indicators
- 🔲 **Status** - Small online/offline indicators
- 🔲 **Indicator** - Corner notification badges
- 🔲 **Steps** - Multi-step process visualization
- 🔲 **Countdown** - Timer and countdown displays

---

### **Phase 6: Container Components**

Component organization and grouping

- 🔲 **Join** - Group related components together
- 🔲 **Stack** - Layer elements on top of each other
- 🔲 **Collapse** - Expandable content sections
- 🔲 **Swap** - Toggle between two content states
- 🔲 **Fieldset** - Form section grouping
- 🔲 **Label** - Enhanced form field labeling

---

### **Phase 7: Interactive Components**

Complex user interactions

- 🔲 **Modal** - Dialog boxes and overlays
- 🔲 **Dropdown** - Context menus and action lists
- 🔲 **Drawer** - Sliding side navigation
- 🔲 **Menu** - Navigation and context menus
- 🔲 **Tabs** - Tabbed content interfaces
- 🔲 **Carousel** - Content sliders and galleries

---

### **Phase 8: Advanced Components**

Specialized inputs and complex patterns

- 🔲 **File Input** - File upload interfaces
- 🔲 **Range** - Slider value selection
- 🔲 **Rating** - Star ratings and feedback
- 🔲 **Filter** - Content filtering controls
- 🔲 **Pagination** - Page navigation controls
- 🔲 **Theme Controller** - Dynamic theme switching
- 🔲 **Validator** - Form validation with visual feedback
- 🔲 **Diff** - Side-by-side content comparison

---

### **Phase 9: Display & Demo**

Presentation and demonstration components

- 🔲 **Mockup Browser** - Browser window frames
- 🔲 **Mockup Phone** - Mobile device frames
- 🔲 **Mockup Window** - Desktop window frames
- 🔲 **Mockup Code** - Code block presentation
- 🔲 **Chat** - Messaging interface components
- 🔲 **Calendar** - Date selection integration

---
