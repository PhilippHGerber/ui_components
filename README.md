# UI Components for Jaspr

This repository contains multiple UI component packages for [Jaspr](https://jaspr.site), built with Dart.

Each package is designed to be modular and reusable in your Jaspr web projects.

> [!WARNING]
> Please keep in mind that Deepyr is still under active development
> and therefore full backward compatibility is not guaranteed before reaching v1.0.0.

---

## Repository Structure

```bash
ui-components/
├── packages/
│   └── deepyr/
└── README.md
```

---

## Packages

| Package  | Description                                  |
| -------- | -------------------------------------------- |
| `deepyr` | Shared core utilities and base functionality |

Deepyr components are one-to-one realisation of the DaisyUI components with all
the advantages of Dart.

---

## Getting Started

### TailwindCSS and DaisyUI

```bash
npm init -y
npm install -D tailwindcss@latest daisyui@latest
````

```bash
npm list tailwindcss daisyui
npm update tailwindcss daisyui
npm install -D tailwindcss@latest daisyui@latest
```

## Run Tailwind

```bash
npx @tailwindcss/cli -i ./web/styles.tw.css -o ./web/styles.css --watch
```

### Prerequisites

- [Dart SDK](https://dart.dev/get-dart) (>=3.x)
- [Jaspr CLI](https://jaspr.dev/docs/get-started/)

Install Jaspr CLI:

```bash
dart pub global activate jaspr_cli
```

---

### Install Dependencies

Run in each package or example folder:

```bash
dart pub get
```

---

### Run Example

For example, to run `example_components`:

```bash
cd examples/deepyr_example
jaspr serve
```

---

## Using the Packages

Add to your `pubspec.yaml`:

---

## Greatest Advantages of the deepyr Package

### Core Implementation Strategy

The library abstracts DaisyUI's class-based system into a robust, type-safe collection of Dart components and styling objects.

Styling is managed through a clever system of Dart classes that represent CSS utilities. Component-specific styles (e.g., `Button.primary`) and general-purpose utilities (e.g., `Spacing.p(4)`, `TextUtil.center`) are unified under a common `Styling` interface. This allows developers to apply both types of styles together in a component's `style` list, offering a high degree of flexibility and code clarity.

`deepyr`  is a foundational library that provides a 1:1, type-safe mapping of DaisyUI components and their modifiers.

### Greatest Advantages of the `deepyr` Package

The `deepyr` package's architecture provides several key benefits for developers building web applications with Jaspr:

- **Type Safety and Autocomplete:** By replacing raw CSS strings like `'btn-primary'` with Dart objects like `Button.primary`, the library eliminates a common source of typos and errors. This approach leverages Dart's strong type system, allowing the compiler to catch mistakes at build time. Furthermore, it provides an excellent developer experience with full IDE autocomplete for discovering available components and their modifiers.

- **Fluent API for Responsive and State-based Design:** A standout feature is the fluent API for applying responsive and state-based variations. Instead of manually concatenating prefixes, developers can use intuitive methods like `.at(Breakpoint.md)` and `.on(Is.hover)`. This makes the code for complex, adaptive user interfaces significantly more readable and maintainable.

- **High-Level Abstraction and Maintainability:** The package provides high-level abstractions for DaisyUI components. Developers can work with familiar components like `Card`, `Modal`, and `Drawer` without needing to memorize the specific underlying HTML structure and class names that DaisyUI requires. This abstraction also means that if DaisyUI were to update its class names, the changes could be handled within the `deepyr` library, insulating developers from breaking changes.

- **Focus on Accessibility:** The base `UiComponent` class includes a dedicated `configureAttributes` method, encouraging the proper setup of ARIA roles and other accessibility attributes from the component level. This built-in consideration for accessibility is a crucial aspect of modern web development.

In summary, the `deepyr` package architecture prioritizes type safety, developer experience, and maintainability, providing a solid and scalable foundation for building sophisticated user interfaces with Jaspr and DaisyUI.

## License

MIT License — see [LICENSE](LICENSE)
