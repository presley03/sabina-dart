import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sabina/widgets/article_reader_widgets.dart';

void main() {
  const base = TextStyle(fontSize: 16);
  const highlightBg = Color(0xFFFBE5DD);
  const textColor = Color(0xFF2C2230);

  group('parseMarkedText', () {
    test('text without a marker stays a single plain span', () {
      final spans = parseMarkedText(
        'Teks biasa tanpa marker.',
        base: base,
        highlightBg: highlightBg,
        textColor: textColor,
      );

      expect(spans, hasLength(1));
      expect(spans.single, isA<TextSpan>());
      expect((spans.single as TextSpan).text, 'Teks biasa tanpa marker.');
    });

    test('a single ==marker== becomes a highlighted WidgetSpan', () {
      final spans = parseMarkedText(
        'Batasi ==200 mg== per hari.',
        base: base,
        highlightBg: highlightBg,
        textColor: textColor,
      );

      expect(spans, hasLength(3));
      expect((spans[0] as TextSpan).text, 'Batasi ');
      expect(spans[1], isA<WidgetSpan>());
      final highlighted = (spans[1] as WidgetSpan).child as Container;
      final label = highlighted.child as Text;
      expect(label.data, '200 mg');
      expect((spans[2] as TextSpan).text, ' per hari.');
    });

    test('two ==marker== occurrences both become WidgetSpans', () {
      final spans = parseMarkedText(
        '==Preeklampsia== dan ==SIDS== perlu diwaspadai.',
        base: base,
        highlightBg: highlightBg,
        textColor: textColor,
      );

      final widgetSpans = spans.whereType<WidgetSpan>().toList();
      expect(widgetSpans, hasLength(2));
      expect(
        ((widgetSpans[0].child as Container).child as Text).data,
        'Preeklampsia',
      );
      expect(
        ((widgetSpans[1].child as Container).child as Text).data,
        'SIDS',
      );
      // "dan " and " perlu diwaspadai." surround/between the two markers.
      final plain = spans.whereType<TextSpan>().map((s) => s.text).toList();
      expect(plain, [' dan ', ' perlu diwaspadai.']);
    });
  });
}
