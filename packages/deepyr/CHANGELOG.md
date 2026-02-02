# Changelog

## Next release

## 0.6.0

### Removed

* **Breaking Change: Removed `child` named parameter.** The package now strictly follows a "No Child Named Parameter" approach. All components that previously accepted either a `child` (named) or `children` (positional) now **require `children` as a required positional parameter**. This simplifies the API and ensures consistency across the library.

## 0.5.0

### Changed

* **Update to Jaspr 0.22.0**, apply all changed imports and replace all depracated methods and classes. (PR #4, thanks @nemr0)

### Fixed

* **HoverGallery:** update child component assertion to use img type

## 0.4.0

### Fixed

* **Critical State Sync:** Resolved a race condition with Jaspr v0.21.6+ where interactive components (Accordion, Collapse, Drawer, etc.) would lose state/snap shut during re-renders.

### Changed

* **Controlled Components:** `Drawer`, `Modal`, `Swap`, `Checkbox`, `Toggle`, `ThemeController`, `Accordion`, and `Collapse` have been refactored to `StatefulUiComponent`. They now strictly follow the **Controlled Component** pattern (requiring state to be passed in).
* **Tabs:** The `Tab` component now correctly handles radio-input logic to prevent state desynchronization.

### Added

* **Indeterminate State:** Native support for the `indeterminate` visual state on `Checkbox`, `Toggle`, and `Swap` via JS interop.
* **Styling Utilities:** Added `Transition`, `Transform`, and `Group` utility classes for advanced CSS effects.
* **Custom Variants:** Added the `.when()` modifier to `BaseStyle`, allowing for custom state selectors (e.g., `Size.w64.when(DrawerIs.open)`).

## 0.3.0

### Added

* **New Component**: `MockupPhone` for displaying content within an iPhone-style frame, using a simple `content` property for the screen area ([Example](https://deepyr-doc.web.app/components/phone)).
* **New Component**: `MockupWindow` for showing content inside a generic OS-style window frame ([Example](https://deepyr-doc.web.app/components/window)).
* **New Component**: `BrowserMockup` for creating a browser window mockup with a compositional API for the toolbar and content area ([Example](https://deepyr-doc.web.app/components/browser)).
* **New Component**: `MockupCode` for displaying code blocks, featuring a developer-friendly API with `.fromString()` and `.fromList()` factories, automatic line numbering, and per-line styling capabilities ([Example](https://deepyr-doc.web.app/components/code)).

## 0.2.1

fixed README

## 0.2.0

### Added

* **New Component**: `FAB` component for creating a Floating Action Button with "Speed Dial" functionality, implemented as a fully controlled component for Dart-driven interactivity ([Example](https://deepyr-doc.web.app/components/fab)).
* **New Component**: `Dock` component for creating a responsive bottom navigation bar, composed of `DockItem` and `DockLabel` for flexible and type-safe implementation ([Example](https://deepyr-doc.web.app/components/dock)).
* **New Component**: `Filter` component for creating a group of radio buttons to filter items, with support for form-based and CSS-based reset functionality ([Example](https://deepyr-doc.web.app/components/filter)).

## 0.1.8

### Added

* **New Component**: `Carousel` component for creating a scrollable list of items ([Example](https://deepyr-doc.web.app/components/carousel)).

## 0.1.7

### Added

* **New Component**: `Rating` component for selecting a value from a set of icons, with support for half-stars, custom icons via `Mask`, and sizes ([Example](https://deepyr-doc.web.app/components/rating))
* **New Component**: `Toast` component for displaying notifications in various screen positions ([Example](https://deepyr-doc.web.app/components/toast))
* **New Component**: `Steps`, `Step`, and `StepIcon` components for showing progress in a process, with support for colors, custom content, and responsive layouts ([Example](https://deepyr-doc.web.app/components/steps)).
* **New Component**: `Stack` component for layering elements on top of each other, with positional modifiers like `Stack.top`, `Stack.start`, etc. ([Example](https://deepyr-doc.web.app/components/stack)).

## 0.1.6

### Added

* **New Component**: `Chat` component family for displaying conversations, including `Chat`, `ChatBubble`, `ChatImage`, `ChatHeader`, and `ChatFooter` ([Example](https://deepyr-doc.web.app/components/chat)).

## 0.1.5

### Added

* **New Component**: `HoverGallery` component for creating a pure CSS image gallery that reveals different images on horizontal hover ([Example](https://deepyr-doc.web.app/components/hover-gallery)).

## 0.1.4

### Added

* **New Component**: `Timeline` component for displaying a list of events in chronological order ([Example](https://deepyr-doc.web.app/components/timeline)).

* **Responsive API Enhancement:** The core styling API has been extended to support `max-width` breakpoints. All styling components now have a `.below(Breakpoint)` method, enabling styles that apply only *up to* a certain screen size (e.g., `Timeline.compact.below(Breakpoint.md)`). This also allows for creating ranged styles by chaining methods (e.g., `MyStyle.at(Breakpoint.sm).below(Breakpoint.lg)`).

## 0.1.3

### Added

* **New Component**: `Status` component for displaying small status indicators.
* **New Component**: `Countdown` component for displaying animated numerical transitions.
* **New Component**: `RadialProgress` component to show progress in a circular style.
* **New Component**: `Stat` and `Stats` components for displaying statistical data.
* **New Component**: `List`, `ListRow`, and `ListCol` components for creating structured lists.
* **New Component**: `Mask` component with a full set of shape modifiers.
* **New Component**: `Table` component to be a 1:1 match with all official daisyUI examples.

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
* Basic API structure for creating and styling daisyUI components in Jaspr.
