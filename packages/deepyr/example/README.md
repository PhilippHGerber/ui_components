# Deepyr Example

A new Jaspr project

## Setup

Install tailwindcss and daisyui

```bash
npm init -y
npm install -D tailwindcss@latest daisyui@latest
```

## Run Tailwind

```bash
npx @tailwindcss/cli -i ./web/styles.tw.css -o ./web/styles.css --watch
```

## Running the project

Run your project using `jaspr serve`.

The development server will be available on `http://localhost:8080`.

## Building the project

Build your project using `jaspr build`.

The output will be located inside the `build/jaspr/` directory.
