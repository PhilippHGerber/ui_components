# Changelog

## 0.1.4

### Added

* **New Component**: `Timeline` component for displaying a list of events in chronological order.
* **Responsive API Enhancement:** The core styling API has been extended to support `max-width` breakpoints. All styling components now have a `.below(Breakpoint)` method, enabling styles that apply only *up to* a certain screen size (e.g., `Timeline.compact.below(Breakpoint.md)`). This also allows for creating ranged styles by chaining methods (e.g., `MyStyle.at(Breakpoint.sm).below(Breakpoint.lg)`).

## 0.1.3

### Added

* **New Component**: `Status` component for displaying small status indicators.
* **New Component**: `Countdown` component for displaying animated numerical transitions.
* **New Component**: `RadialProgress` component to show progress in a circular style.
* **New Component**: `Stat` and `Stats` components for displaying statistical data.
* **New Component**: `List`, `ListRow`, and `ListCol` components for creating structured lists.
* **New Component**: `Mask` component with a full set of shape modifiers.
* **New Component**: `Table` component to be a 1:1 match with all official DaisyUI examples.

## 0.1.2

### Fixed

* **`Dropdown`:** Addressed a critical cross-browser compatibility issue where focus-based dropdowns failed to position correctly in Safari. The component now works seamlessly across all modern browsers.
* **`Diff`:** The `Diff` component is now fully interactive. Fixed a fundamental bug that made the comparison slider non-functional.

### Changed

* **`Diff` Architecture:** Refactored `Diff` to be a stateful, client-side component to enable interactivity.
  * **Breaking Change:** The `item1` and `item2` named parameters have been removed. `DiffItem1` and `DiffItem2` must now be passed as direct children in a list.

## 0.1.1

### Fixed

* **`Modal` Closing on Safari:** Fixed a critical cross-browser issue where `Modal` components using the native `<dialog>` tag could not be closed by a `Button` inside a `<form method="dialog">`. This was most noticeable on Safari. The issue was caused by Jaspr's default event handling (`preventDefault()`) interfering with the native browser behavior required to close the dialog.

### Added

* **`Button.isNativeSubmit` Property:** To solve the modal issue, a new `isNativeSubmit` boolean property was added to the `Button` component. When set to `true`, the `Button` renders as a primitive element without Jaspr's event listeners, allowing its native form submission behavior to proceed. This is now the recommended way to create close buttons for dialog-based modals.

## 0.1.0

### Added

* **`Join`** - A smart container to seamlessly group related components like buttons or inputs.
* **`Tooltip`** - A pop-up that displays information on hover, supporting both simple text and rich content.
* **`Indicator`** - A container to place a badge or item on the corner of another element.
* **`Modal`** - A dialog/overlay component for displaying important messages or interactive content.
* **`Tabs`** - A component for creating tabbed content views, allowing users to switch between different sections.
* **`Dropdown`** - A key interactive component for creating context menus and action lists, refactored for a more declarative and type-safe API.

## 0.0.4

### Added

* **`Checkbox`** - Boolean selection with custom styling
* **`Radio`** - Single choice selection from multiple options
* **`Toggle`** - Modern switch-style boolean input
* **`Textarea`** - Multi-line text input with resize options
* **`Select`** - Dropdown selection with custom styling
* **`Progress`** - Task completion and loading progress bars
* **`Link`** - Enhanced hyperlinks with hover states

## 0.0.3

### Added

* **`Loading`** - to show animations for loading states.
* **`Divider`** - to separate content.

## 0.0.2

### Added

* **`Input`** - Text input field with full styling support
* **`Badge`** - Status indicators and labels
* **`Alert`** - User notification messages
* **`Card`** - Content containers and layout blocks

## 0.0.1

* Initial project setup and foundation for the `deepyr` package.
* Proof of Concept (PoC) release with the first component: `Button`.
* Basic API structure for creating and styling DaisyUI components in Jaspr.
