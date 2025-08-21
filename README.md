# UI Components

This repository contains a Proof of Concept UI component packages for [Jaspr](https://jaspr.site), built with Dart.

## Package

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

## Run Tailwind

```bash
npx @tailwindcss/cli -i ./web/styles.tw.css -o ./web/styles.css --watch
```

## Install Jaspr CLI

```bash
dart pub global activate jaspr_cli
```

### Install Dependencies

Run in each package or example folder:

```bash
dart pub get
```

## License

MIT License — see [LICENSE](LICENSE)
