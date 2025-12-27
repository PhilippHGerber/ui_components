import 'dart:async';

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:universal_web/web.dart' show HTMLDialogElement, document;

import '../../base/stateful_ui_component.dart';
import '../../base/style_type.dart';
import '../../base/ui_component.dart';
import '../../base/ui_component_attributes.dart';
import '../../base/ui_events.dart';
import 'modal_style.dart';

/// A modal component that shows a dialog or box when triggered.
///
/// The `Modal` component works as a controlled component via the [open] property.
/// It supports two rendering modes based on the [tag]:
///
/// 1.  **`<dialog>` (Recommended):** Uses the native HTML Dialog API.
///     -   Handles focus trapping and accessibility automatically.
///     -   Closes on ESC key.
///     -   Requires [open] state synchronization via JS interop (handled internally).
///
/// 2.  **`<div>` (Legacy/CSS-only):**
///     -   Toggles visibility by adding/removing the `modal-open` class.
///     -   Useful for simple overlays or environments where `<dialog>` isn't desired.
///
/// ### Example (Recommended):
/// ```dart
/// Modal(
///   open: isModalOpen,
///   onToggle: (isOpen) => setState(() => isModalOpen = isOpen),
///   tag: 'dialog',
///   [
///     ModalBox([
///       h3([text('Hello!')]),
///       ModalAction([
///         Button([text('Close')], onClick: () => setState(() => isModalOpen = false)),
///       ]),
///     ]),
///   ],
/// )
/// ```
class Modal extends StatefulUiComponent {
  /// Creates a Modal component.
  ///
  /// - [children]: The content of the modal, typically containing [ModalBox].
  /// - [open]: Whether the modal is currently visible.
  /// - [onToggle]: Callback triggered when the modal opens or closes (e.g., via ESC key).
  /// - [tag]: The HTML tag. Defaults to 'dialog' (recommended). Set to 'div' for CSS-class mode.
  /// - [style]: A list of [ModalStyling] instances for positioning and behavior.
  /// - [role]: ARIA role, defaults to 'dialog'.
  /// - Other parameters are inherited from [UiComponent].
  const Modal(
    super.children, {
    this.open = false,
    this.onToggle,
    super.tag = 'dialog',
    List<ModalStyling>? style,
    this.role,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.child,
    super.key,
  }) : super(style: style);

  /// Whether the modal is currently open.
  final bool open;

  /// Callback called when the modal state changes (e.g. closed by ESC key).
  final ValueChanged<bool>? onToggle;

  /// Optional ARIA role for the modal.
  final String? role;

  @override
  String get baseClass => 'modal';

  @override
  State<Modal> createState() => _ModalState();

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    // Static attributes logic
    if (role != null) {
      attributes.addRole(role!);
    } else {
      attributes.addRole('dialog');
    }
  }

  // --- Static Static Style Modifiers ---

  /// Moves the modal to the top of the screen. `modal-top`
  static const ModalStyle top = ModalStyle('modal-top', type: StyleType.layout);

  /// Moves the modal to the middle of the screen (default). `modal-middle`
  static const ModalStyle middle = ModalStyle('modal-middle', type: StyleType.layout);

  /// Moves the modal to the bottom of the screen. `modal-bottom`
  static const ModalStyle bottom = ModalStyle('modal-bottom', type: StyleType.layout);

  /// Moves the modal to the start horizontally. `modal-start`
  static const ModalStyle start = ModalStyle('modal-start', type: StyleType.layout);

  /// Moves the modal to the end horizontally. `modal-end`
  static const ModalStyle end = ModalStyle('modal-end', type: StyleType.layout);
}

class _ModalState extends StatefulUiComponentState<Modal> {
  /// Generates a unique ID if one wasn't provided, ensuring we can find the element.
  String get _elementId => component.id ?? 'modal_${component.hashCode}'; // Fallback ID

  @override
  String get baseClass => component.baseClass;

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);

    // Dynamic attributes
    if (component.tag != 'dialog') {
      // For div-based modals, we manage visibility via aria-hidden
      attributes.addAria('hidden', (!component.open).toString());
    }
  }

  @override
  String get combinedClasses {
    var classes = super.combinedClasses;
    // For div-based modals, we use the 'modal-open' class to control visibility.
    if (component.tag != 'dialog' && component.open) {
      classes += ' modal-open';
    }
    return classes;
  }

  @override
  void initState() {
    super.initState();
    if (component.tag == 'dialog') {
      _syncDialogState();
    }
  }

  @override
  void didUpdateComponent(Modal oldComponent) {
    super.didUpdateComponent(oldComponent);
    // Sync state if the open prop changed
    if (component.tag == 'dialog' && oldComponent.open != component.open) {
      _syncDialogState();
    }
  }

  /// Synchronizes the \<dialog> element with the [component.open] state.
  void _syncDialogState() {
    if (!kIsWeb) return;

    // Schedule execution to ensure DOM is ready (post-render)
    Future.delayed(Duration.zero, () {
      final dialog = document.getElementById(_elementId) as HTMLDialogElement?;
      if (dialog == null) return;

      if (component.open) {
        if (!dialog.open) {
          dialog.showModal();
        }
      } else {
        if (dialog.open) {
          dialog.close();
        }
      }
    });
  }

  @override
  Component build(BuildContext context) {
    // We need to attach an event listener for the native 'close' event
    // to sync state when the user presses ESC.
    final events = Map<String, EventCallback>.from(eventMap);

    if (component.tag == 'dialog') {
      events['close'] = (dynamic event) {
        if (component.open && component.onToggle != null) {
          // If the dialog closed natively but we think it's open, update state.
          component.onToggle!(false);
        }
      };
    }

    return Component.element(
      tag: component.tag,
      id: _elementId, // Use the guaranteed ID
      classes: combinedClasses,
      styles: component.css,
      attributes: componentAttributes,
      events: events,
      children: children ?? (child != null ? [child!] : null),
    );
  }
}

/// The content container of a modal.
///
/// Typically contains the main content, title, and body text of the modal.
/// Should be placed as a child of [Modal].
class ModalBox extends UiComponent {
  /// Creates a ModalBox component.
  const ModalBox(
    super.children, {
    super.tag = 'div',
    super.style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.child,
    super.key,
  });

  @override
  String get baseClass => 'modal-box';

  @override
  ModalBox copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return ModalBox(
      children,
      tag: tag,
      style: style,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      child: child,
      key: key ?? this.key,
    );
  }
}

/// The action area of a modal, typically containing buttons.
///
/// Usually placed at the bottom of [ModalBox] and contains buttons
/// like "OK", "Cancel", "Close", etc.
class ModalAction extends UiComponent {
  /// Creates a ModalAction component.
  const ModalAction(
    super.children, {
    super.tag = 'div',
    super.style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.child,
    super.key,
  });

  @override
  String get baseClass => 'modal-action';

  @override
  ModalAction copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return ModalAction(
      children,
      tag: tag,
      style: style,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      child: child,
      key: key ?? this.key,
    );
  }
}

/// A backdrop that covers the screen when the modal is open.
///
/// Typically used with `form method="dialog"` to allow clicking outside to close.
/// Can also be used with the legacy checkbox method.
class ModalBackdrop extends UiComponent {
  /// Creates a ModalBackdrop component.
  ///
  /// - [tag]: Defaults to 'form' (for dialog method) or 'label' (for checkbox method).
  /// - [htmlFor]: used if tag is 'label'.
  const ModalBackdrop(
    super.children, {
    super.tag = 'form',
    this.htmlFor,
    super.style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.child,
    super.key,
  });

  /// The HTML 'for' attribute, used with checkbox method.
  final String? htmlFor;

  @override
  String get baseClass => 'modal-backdrop';

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);
    if (htmlFor != null && tag == 'label') {
      attributes.add('for', htmlFor!);
    }
    if (tag == 'form') {
      attributes.add('method', 'dialog');
    }
  }

  @override
  ModalBackdrop copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return ModalBackdrop(
      children,
      tag: tag,
      htmlFor: htmlFor,
      style: style,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      child: child,
      key: key ?? this.key,
    );
  }
}

/// A hidden checkbox that controls the modal state (legacy method).
class ModalToggle extends UiComponent {
  /// Creates a ModalToggle component.
  ///
  /// - [id]: Required unique ID that labels will reference.
  ModalToggle({
    required String id,
    super.style,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.key,
  }) : super(
         [],
         tag: 'input',
         id: id,
       );

  @override
  String get baseClass => 'modal-toggle';

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);
    attributes.add('type', 'checkbox');
  }

  @override
  ModalToggle copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return ModalToggle(
      id: id ?? this.id!,
      style: style,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      key: key ?? this.key,
    );
  }
}
