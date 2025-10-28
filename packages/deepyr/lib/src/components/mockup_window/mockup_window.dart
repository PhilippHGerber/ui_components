import 'package:jaspr/jaspr.dart';

import '../../base/ui_component.dart';
import '../../base/ui_events.dart';
import 'mockup_window_style.dart';

/// A component that renders a box styled to look like an operating system window,
/// complete with a title bar and window controls generated via CSS.
///
/// This component acts as a direct wrapper for your content. Styling for the
/// window frame, such as background colors and borders, should be applied to
/// this component using general utilities in the `style` property.
///
/// **Note:** Per the DaisyUI specification, the top border on the content area
/// is part of the content's styling, not the window frame. You should apply this
/// border to your content container.
///
/// Example Usage:
/// ```dart
/// MockupWindow(
///   style: [BorderUtil.border, BorderUtil.base300, Size.wFull],
///   [
///     Container(
///       [text('Hello!')],
///       style: [Layout.grid, Alignment.placeContentCenter, Size.h(80)],
///       classes: 'border-t border-base-300', // User applies content border
///     ),
///   ]
/// )
/// ```
class MockupWindow extends UiComponent {
  /// Creates a [MockupWindow] component.
  ///
  /// - [children]: The content to be displayed inside the window frame.
  /// - [style]: A list of [MockupWindowStyling] instances for applying
  ///   general utilities like background colors and borders to the window frame.
  /// - Other parameters are inherited from [UiComponent].
  const MockupWindow(
    super.children, {
    List<MockupWindowStyling>? style,
    super.tag = 'div',
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.child,
    super.key,
  }) : super(style: style);

  @override
  String get baseClass => 'mockup-window';

  @override
  MockupWindow copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return MockupWindow(
      children,
      style: style as List<MockupWindowStyling>?,
      tag: tag,
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
