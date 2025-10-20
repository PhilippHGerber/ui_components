import 'package:jaspr/jaspr.dart' show Key, Styles;

import '../../base/style_type.dart';
import '../../base/ui_component.dart';
import '../../base/ui_component_attributes.dart';
import '../../base/ui_events.dart';
import 'modal_style.dart';

/// A modal component that shows a dialog or box when triggered.
///
/// The Modal component supports multiple activation methods:
/// 1. **HTML `<dialog>` element (recommended):**
///    Set `tag: 'dialog'` and use JavaScript `showModal()` and `close()` methods.
/// 2. **Checkbox method (legacy):**
///    Use a hidden checkbox with `modal-toggle` class to control the modal state.
/// 3. **Anchor links method (legacy):**
///    Use URL anchors to show/hide the modal.
///
/// Example usage:
/// ```dart
/// // Method 1: Dialog (recommended)
/// Modal(
///   [
///     ModalBox([
///       h3([text('Hello!')]),
///       p([text('Press ESC key or click the button below to close')]),
///       ModalAction([
///         form(attributes: {'method': 'dialog'}, [
///           Button([text('Close')]),
///         ]),
///       ]),
///     ]),
///   ],
///   tag: 'dialog',
///   id: 'my_modal_1',
/// )
/// ```
class Modal extends UiComponent {
  /// Creates a Modal component.
  ///
  /// - [children]: The content of the modal, typically containing [ModalBox].
  /// - [tag]: The HTML tag, defaults to 'div'. Use 'dialog' for the recommended method.
  /// - [style]: A list of [ModalStyling] instances for positioning and behavior.
  /// - [role]: ARIA role, defaults to 'dialog' when tag is not 'dialog'.
  /// - Other parameters are inherited from [UiComponent].
  const Modal(
    super.children, {
    super.tag = 'div',
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

  /// Optional ARIA role for the modal.
  final String? role;

  @override
  String get baseClass => 'modal';

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);

    // Set ARIA role if not using dialog element
    if (role != null) {
      attributes.addRole(role!);
    } else if (tag != 'dialog') {
      attributes.addRole('dialog');
    }
  }

  @override
  Modal copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return Modal(
      children,
      tag: tag,
      style: style as List<ModalStyling>?,
      role: role,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      child: child,
      key: key ?? this.key,
    );
  }

  // --- Static Modal Modifiers (Placement & Behavior) ---

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

  /// Keeps the modal open (can be controlled via JavaScript). `modal-open`
  static const ModalStyle open = ModalStyle('modal-open', type: StyleType.state);
}

/// The content container of a modal.
///
/// Typically contains the main content, title, and body text of the modal.
/// Should be placed as a child of [Modal].
class ModalBox extends UiComponent {
  /// Creates a ModalBox component.
  ///
  /// - [children]: The content to display within the modal box.
  /// - [tag]: The HTML tag, defaults to 'div'.
  /// - [styles]: A list of general utility modifiers for styling.
  /// - Other parameters are inherited from [UiComponent].
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
  ///
  /// - [children]: The action elements, typically buttons.
  /// - [tag]: The HTML tag, defaults to 'div'.
  /// - [styles]: A list of general utility modifiers for styling.
  /// - Other parameters are inherited from [UiComponent].
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
/// When clicked, it can close the modal. Used primarily with the checkbox
/// and anchor link methods. For dialog method, use a form with method="dialog".
class ModalBackdrop extends UiComponent {
  /// Creates a ModalBackdrop component.
  ///
  /// - [children]: Optional content, typically just text like "Close".
  /// - [tag]: The HTML tag, defaults to 'label' for checkbox method, 'div' for others.
  /// - [htmlFor]: The 'for' attribute, used with checkbox method to target the checkbox ID.
  /// - [styles]: A list of general utility modifiers for styling.
  /// - Other parameters are inherited from [UiComponent].
  const ModalBackdrop(
    super.children, {
    super.tag = 'label',
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
///
/// Used with the checkbox method where labels toggle the checkbox
/// to open/close the modal.
class ModalToggle extends UiComponent {
  /// Creates a ModalToggle component.
  ///
  /// - [id]: Required unique ID that labels will reference.
  /// - [styles]: A list of general utility modifiers.
  /// - Other parameters are inherited from [UiComponent].
  ModalToggle({
    required String id,
    super.style,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.key,
  }) : super(
         [], // No children for input element
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
