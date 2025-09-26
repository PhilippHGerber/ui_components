import 'package:jaspr/jaspr.dart';
import 'package:universal_web/js_interop.dart';
import 'package:universal_web/web.dart' show Event, HTMLElement, HTMLInputElement, document;

import '../../base/ui_component.dart';
import '../../base/ui_component_attributes.dart';
import '../../elements/container.dart';
import 'diff_style.dart';

// ############################################################################
// # 1. The Internal, Client-Side State Controller
// ############################################################################

/// An internal, client-side component responsible for making the `Diff` interactive.
///
/// **Note for developers:** This component is an internal implementation detail.
/// You should always use the public `Diff` component in your application.
///
/// This component's name must be public (no underscore) so that Jaspr's build
/// system can reference it when generating client-side hydration code.
@client
class DiffController extends StatefulComponent {
  const DiffController({
    required this.containerId,
    required this.initialValue,
  });

  /// The unique ID of the parent `Diff` container, used to find the DOM elements.
  final String containerId;

  /// The initial value of the slider.
  final double initialValue;

  @override
  State<DiffController> createState() => _DiffControllerState();
}

/// The state for the [DiffController], which handles all browser-side logic.
/// This class can remain private as it's only used within this library file.
class _DiffControllerState extends State<DiffController> {
  @override
  void initState() {
    super.initState();

    if (kIsWeb) {
      Future.microtask(() {
        final container = document.getElementById(component.containerId) as HTMLElement?;
        if (container == null) {
          print(
            "Warning: Diff component container with ID '${component.containerId}' not found in the DOM.",
          );
          return;
        }

        final slider = container.querySelector('input[type=range]') as HTMLInputElement?;

        if (slider != null) {
          container.style.setProperty('--p', '${component.initialValue}%');

          final eventListener = (Event event) {
            container.style.setProperty('--p', '${slider.value}%');
          }.toJS;

          slider.addEventListener('input', eventListener);
        }
      });
    }
  }

  /// This component renders no visible output itself; its purpose is purely
  /// to attach the interactive logic to the existing DOM structure.
  @override
  Component build(BuildContext context) {
    return const Component.fragment([]);
  }
}

// ############################################################################
// # 2. The Public-Facing, Server-Rendered Component
// ############################################################################

/// A component for visually comparing two pieces of content ("before" and "after")
/// side-by-side using a draggable resizer.
///
/// This component is a "smart container" that expects a [DiffItem1] and a
/// [DiffItem2] as its direct children. It renders the complete visual structure
/// on the server and then embeds the client-side `DiffController`
/// to handle the interactivity in the browser.
///
/// Correct Usage:
/// ```dart
/// Diff(
///   [
///     DiffItem1([ /* Your "before" content here */ ]),
///     DiffItem2([ /* Your "after" content here */ ]),
///   ],
///   ariaLabel: 'Before and after code comparison',
/// )
/// ```
class Diff extends StatelessComponent {
  /// Creates an interactive Diff component.
  ///
  /// - [children]: A list that **must** contain one [DiffItem1] and one [DiffItem2].
  /// - [tag]: The HTML tag for the root element, defaults to 'div'.
  /// - [initialValue]: The initial position of the slider, from 0 to 100. Defaults to 50.
  /// - [style]: A list of [DiffStyling] instances to apply to the main container.
  /// - [ariaLabel]: An accessible name for the comparison group. Recommended for accessibility.
  /// - Other parameters like `id`, `classes`, `css`, and `attributes` are
  ///   applied to the root element.
  const Diff(
    this.children, {
    this.tag = 'div',
    this.initialValue = 50.0,
    this.style,
    this.id,
    this.classes,
    this.css,
    this.attributes,
    this.ariaLabel,
    super.key,
  });

  final List<Component> children;
  final String tag;
  final double initialValue;
  final List<DiffStyling>? style;
  final String? id;
  final String? classes;
  final Styles? css;
  final Map<String, String>? attributes;
  final String? ariaLabel;

  /// A constant string of utility classes for the invisible range slider.
  static const _sliderClasses =
      'absolute top-0 left-0 h-full w-full appearance-none bg-transparent opacity-0 [&::-webkit-slider-thumb]:pointer-events-auto [&::-moz-range-thumb]:pointer-events-auto [&::-ms-thumb]:pointer-events-auto';

  @override
  Component build(BuildContext context) {
    final item1 = children.whereType<DiffItem1>().firstOrNull;
    final item2 = children.whereType<DiffItem2>().firstOrNull;

    assert(
      item1 != null && item2 != null,
      'A Diff component must have exactly one DiffItem1 and one DiffItem2 as direct children.',
    );

    final containerId = id ?? 'deepyr-diff-${key.hashCode}';

    final userProvidedAttributes = attributes ?? {};
    final builder = UiComponentAttributes(userProvidedAttributes);

    builder.add('role', userProvidedAttributes['role'] ?? 'group');
    if (ariaLabel != null) {
      builder.addAria('label', ariaLabel!);
    }

    final utilityClasses = style?.map((s) => s.toString()).join(' ') ?? '';
    final combinedClasses = [
      'diff',
      utilityClasses,
      classes ?? '',
    ].where((c) => c.isNotEmpty).join(' ');

    return Container(
      tag: tag,
      id: containerId,
      classes: combinedClasses,
      css: css,
      attributes: builder.build(),
      [
        item1!,
        item2!,
        const DiffResizer(),
        input(
          type: InputType.range,
          value: initialValue.clamp(0.0, 100.0).toString(),
          classes: _sliderClasses,
          attributes: {
            'aria-label': 'Comparison slider',
            'min': '0',
            'max': '100',
          },
        ),
        // Embed the public, client-side controller.
        DiffController(
          containerId: containerId,
          initialValue: initialValue,
        ),
      ],
    );
  }
}

/// Represents the first item (typically "before" or "old") in a [Diff] comparison.
class DiffItem1 extends UiComponent {
  /// Creates a DiffItem1 component.
  ///
  /// - [children] or [child]: The content of this diff item.
  /// - [tag]: The HTML tag, defaults to 'div'.
  /// - Other parameters from [UiComponent].
  const DiffItem1(
    super.children, {
    super.tag = 'div',
    super.style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.child,
    super.key,
  }) : super();

  @override
  String get baseClass => 'diff-item-1';

  @override
  DiffItem1 copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Key? key,
  }) {
    return DiffItem1(
      children,
      tag: tag,
      style: style,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      child: child,
      key: key ?? this.key,
    );
  }
}

/// Represents the second item (typically "after" or "new") in a [Diff] comparison.
class DiffItem2 extends UiComponent {
  /// Creates a DiffItem2 component.
  ///
  /// - [children] or [child]: The content of this diff item.
  /// - [tag]: The HTML tag, defaults to 'div'.
  /// - Other parameters from [UiComponent].
  const DiffItem2(
    super.children, {
    super.tag = 'div',
    super.style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.child,
    super.key,
  }) : super();

  @override
  String get baseClass => 'diff-item-2';

  @override
  DiffItem2 copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Key? key,
  }) {
    return DiffItem2(
      children,
      tag: tag,
      style: style,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      child: child,
      key: key ?? this.key,
    );
  }
}

/// Represents the draggable resizer control within a [Diff] component.
class DiffResizer extends UiComponent {
  /// Creates a DiffResizer component.
  /// This component typically does not have children.
  const DiffResizer({
    super.tag = 'div',
    super.style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.key,
  }) : super(null);

  @override
  String get baseClass => 'diff-resizer';

  @override
  DiffResizer copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Key? key,
  }) {
    return DiffResizer(
      tag: tag,
      style: style,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      key: key ?? this.key,
    );
  }
}
