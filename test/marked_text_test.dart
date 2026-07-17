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
      final highlighted = (spans[1] as WidgetSpan).child as CustomPaint;
      final label = (highlighted.child as Padding).child as Text;
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
      Text labelOf(WidgetSpan span) =>
          ((span.child as CustomPaint).child as Padding).child as Text;
      expect(labelOf(widgetSpans[0]).data, 'Preeklampsia');
      expect(labelOf(widgetSpans[1]).data, 'SIDS');
      // "dan " and " perlu diwaspadai." surround/between the two markers.
      final plain = spans.whereType<TextSpan>().map((s) => s.text).toList();
      expect(plain, [' dan ', ' perlu diwaspadai.']);
    });

    test('a marker followed by a comma has no right padding', () {
      final spans = parseMarkedText(
        'Berlangsung ==lebih dari 2 minggu==, segera periksa.',
        base: base,
        highlightBg: highlightBg,
        textColor: textColor,
      );

      final highlight = spans.whereType<WidgetSpan>().single;
      final paint = highlight.child as CustomPaint;
      final padding = (paint.child as Padding).padding as EdgeInsets;
      expect(padding.right, 2);
      expect(padding.left, 4);
    });

    test('a marker NOT followed by punctuation keeps right padding', () {
      final spans = parseMarkedText(
        'Batasi ==200 mg== per hari.',
        base: base,
        highlightBg: highlightBg,
        textColor: textColor,
      );

      final highlight = spans.whereType<WidgetSpan>().single;
      final paint = highlight.child as CustomPaint;
      final padding = (paint.child as Padding).padding as EdgeInsets;
      expect(padding.right, 4);
    });
  });
}
