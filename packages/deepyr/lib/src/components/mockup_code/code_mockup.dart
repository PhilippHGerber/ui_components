import 'package:jaspr/jaspr.dart';

import '../../../deepyr.dart';
import 'code_mockup_style.dart';

/// A data class representing a single line of code within a [MockupCode] component.
///
/// This is a plain data object, not a renderable component. It is used to
/// configure the content, prefix, and styling for each line that the
/// [MockupCode] component will render.
class CodeLine {
  /// Creates a data object for a line of code.
  const CodeLine(this.text, {this.prefix, this.style});

  /// The text content of the code line.
  final String text;

  /// An optional prefix to display before the line, rendered as a `data-prefix` attribute.
  /// This can be a symbol (like `$`) or a line number.
  final String? prefix;

  /// An optional list of deepyr styling utilities to apply to this specific line,
  /// for effects like highlighting (e.g., `[BgUtil.warning, TextUtil.warningContent]`).
  final List<Styling>? style;
}

/// A component that shows a block of code in a box styled like a code editor.
///
/// This is a "smart component" that handles the rendering of individual code lines.
/// It is highly recommended to use the convenient factory constructors like
/// [MockupCode.fromString] or [MockupCode.fromList] for the best developer experience.
///
/// Example using the `fromString` factory:
/// ```dart
/// MockupCode.fromString(
///   """
/// npm i daisyui
/// installing...
/// Done!
///   """,
///   showLineNumbers: true,
/// )
/// ```
///
/// Example with full customization:
/// ```dart
/// MockupCode(
///   lines: [
///     CodeLine('npm i daisyui', prefix: '\$'),
///     CodeLine('installing...', prefix: '>', style: [TextUtil.warning]),
///     CodeLine('Done!', prefix: '>', style: [TextUtil.success]),
///   ],
/// )
/// ```
class MockupCode extends UiComponent {
  /// The primary constructor for full, per-line customization.
  ///
  /// - [lines]: A list of [CodeLine] data objects, each defining a line's
  ///   content, prefix, and style.
  /// - [style]: A list of [MockupCodeStyling] instances to apply to the main
  ///   container, typically for background and text colors.
  /// - Other parameters are inherited from [UiComponent].
  const MockupCode({
    required this.lines,
    List<MockupCodeStyling>? style,
    super.tag = 'div',
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.key,
  }) : super(null, style: style);

  /// A convenience factory to create a [MockupCode] component from a single,
  /// multi-line string.
  ///
  /// - [multilineCode]: The code to display, with lines separated by newlines (`\n`).
  /// - [showLineNumbers]: If true, each line will be automatically prefixed with its line number.
  /// - [style]: Styles to apply to the main container.
  factory MockupCode.fromString(
    String multilineCode, {
    bool showLineNumbers = false,
    List<MockupCodeStyling>? style,
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Key? key,
  }) {
    final codeLines = multilineCode.split('\n');
    return MockupCode.fromList(
      codeLines,
      showLineNumbers: showLineNumbers,
      style: style,
      id: id,
      classes: classes,
      css: css,
      attributes: attributes,
      key: key,
    );
  }

  /// A convenience factory to create a [MockupCode] component from a list of strings.
  ///
  /// - [lines]: A list of strings, where each string is a line of code.
  /// - [showLineNumbers]: If true, each line will be automatically prefixed with its line number.
  /// - [style]: Styles to apply to the main container.
  factory MockupCode.fromList(
    List<String> lines, {
    bool showLineNumbers = false,
    List<MockupCodeStyling>? style,
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Key? key,
  }) {
    final codeLines = [
      for (var i = 0; i < lines.length; i++)
        CodeLine(
          lines[i],
          prefix: showLineNumbers ? (i + 1).toString() : null,
        ),
    ];
    return MockupCode(
      lines: codeLines,
      style: style,
      id: id,
      classes: classes,
      css: css,
      attributes: attributes,
      key: key,
    );
  }

  /// The list of [CodeLine] data objects that this component will render.
  final List<CodeLine> lines;

  @override
  String get baseClass => 'mockup-code';

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: tag,
      id: id,
      classes: combinedClasses,
      styles: this.css,
      attributes: componentAttributes,
      events: this.events,
      children: [
        for (final line in lines)
          pre(
            attributes: line.prefix != null ? {'data-prefix': line.prefix!} : null,
            classes: line.style?.toClasses(),
            [
              code([text(line.text)]),
            ],
          ),
      ],
    );
  }

  @override
  MockupCode copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
    List<CodeLine>? lines,
  }) {
    return MockupCode(
      lines: lines ?? this.lines,
      style: style as List<MockupCodeStyling>?,
      tag: tag,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      key: key ?? this.key,
    );
  }
}
