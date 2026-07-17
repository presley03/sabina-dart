import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sabina/core/theme/app_theme.dart';

/// Shared widget library for all article reader screens.
/// Medium-inspired: content-first, clean typography, generous whitespace.
///
/// Components:
///   ArticleSectionLabel   — uppercase section header with left accent bar
///   ArticleStandfirst     — opening paragraph (larger, slightly bolder)
///   ArticleBody           — standard body paragraph
///   ArticleCallout        — left-bordered insight / warning box
///   ArticlePullQuote      — large editorial pulled-out quote
///   ArticleHighlightText  — body text with keyword highlighting
///   ArticleNumberedItem   — numbered section, circle badge (legacy; kept for
///                           screens outside the "Jurnal" reading redesign)
///   ArticleBulletList     — uniform dash-marker bullet list, ink text
///   MarkedText            — body text with `==term==` stabilo highlighting
///   ArticleMagazineNumber — large thin serif number + ink title
///   ArticleMagazineSection— magazine number + paragraph/bullets, no divider
///   ArticleWeekTimeline   — dot+line timeline for week-by-week sections
///   ArticleMiniLabel      — small caps sub-heading above a bullet list
///   ArticleInlineImage    — image with caption + tap-to-zoom
///   ArticleReferenceList  — numbered reference list
///   ArticleDivider        — thin section separator with vertical spacing

// ── 0. Article Header ───────────────────────────────────────────────────────

/// Full-bleed gradient header for article screens.
/// Contains back button, category tags, title, optional meta row,
/// and a hero image with rounded corners below the gradient.
class ArticleHeader extends StatelessWidget {
  final String title;
  final String imagePath;
  final List<String> tags;

  /// Two-stop gradient [start, end]. Defaults to SABINA primary purple.
  final List<Color>? gradientColors;

  /// Estimated read time in minutes. Omit to hide.
  final int? readMinutes;

  /// Pre-formatted date string. Omit to hide.
  final String? dateLabel;

  const ArticleHeader({
    super.key,
    required this.title,
    required this.imagePath,
    this.tags = const [],
    this.gradientColors,
    this.readMinutes,
    this.dateLabel,
  });

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.of(context).padding.top;
    final gradient =
        gradientColors ?? [SabinaColors.primary700, const Color(0xFFC26A5A)];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Gradient section ────────────────────────────────────────────────
        Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(20, topPad + 12, 20, 28),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.22),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Category tag chips
              if (tags.isNotEmpty) ...[
                Wrap(spacing: 8, children: tags.map(_tagChip).toList()),
                const SizedBox(height: 14),
              ],
              // Article title — Fraunces (editorial "Jurnal" voice)
              Text(
                title,
                style: GoogleFonts.fraunces(
                  fontSize: 29,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  height: 1.15,
                  letterSpacing: -0.4,
                ),
              ),
            ],
          ),
        ),

        // ── Meta info row ──────────────────────────────────────────────────
        if (readMinutes != null || dateLabel != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
            child: Row(
              children: [
                if (readMinutes != null) ...[
                  const Icon(
                    Icons.timer_outlined,
                    size: 14,
                    color: SabinaColors.neutral500,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '$readMinutes menit baca',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      color: SabinaColors.neutral500,
                    ),
                  ),
                ],
                if (readMinutes != null && dateLabel != null)
                  const SizedBox(width: 16),
                if (dateLabel != null) ...[
                  const Icon(
                    Icons.calendar_today_outlined,
                    size: 14,
                    color: SabinaColors.neutral500,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    dateLabel!,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      color: SabinaColors.neutral500,
                    ),
                  ),
                ],
              ],
            ),
          ),

        // ── Hero image ─────────────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
              bottomLeft: Radius.circular(18),
              bottomRight: Radius.circular(18),
            ),
            child: Image.asset(
              imagePath,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  Widget _tagChip(String label) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.22),
          borderRadius: BorderRadius.circular(20),
          border:
              Border.all(color: Colors.white.withValues(alpha: 0.4), width: 1),
        ),
        child: Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      );
}

// ── Inline markup renderer ───────────────────────────────────────────────────

/// Fixed highlighter-marker colors — deliberately NOT theme-derived. A real
/// yellow marker always shows dark ink underneath regardless of paper color,
/// so both the mark and the text on it stay the same in light and dark mode
/// (an ink-toned marker text would vanish against the marker in dark mode).
const _markerYellow = Color(0xFFFDE24A);
const _markerTextDark = Color(0xFF2A2113);

/// Punctuation that should sit flush against a highlight span instead of
/// floating behind its right padding (e.g. "…2 minggu, kondisi" must not
/// render as "…2 minggu , kondisi").
final RegExp _trailingPunctuation = RegExp(r'^[,.;:!?]');

/// Paints a highlighter-marker stroke behind its child: a rough, faintly
/// wavy quadrilateral with tapered ends — like a real felt-tip swipe, not a
/// perfect rounded rectangle. Deterministic per [seed] (the term's hashCode)
/// so it never flickers or reshuffles across rebuilds.
class _HighlighterMarkerPainter extends CustomPainter {
  final Color color;
  final int seed;
  const _HighlighterMarkerPainter({required this.color, required this.seed});

  @override
  void paint(Canvas canvas, Size size) {
    final rnd = math.Random(seed);
    final w = size.width;
    final h = size.height;
    double j(double scale) => (rnd.nextDouble() - 0.5) * h * scale;

    canvas.save();
    canvas.translate(w / 2, h / 2);
    canvas.rotate((rnd.nextDouble() - 0.5) * 0.05);
    canvas.translate(-w / 2, -h / 2);

    final path = Path()
      ..moveTo(-2, h * 0.5 + j(0.3))
      ..quadraticBezierTo(w * 0.08, j(0.22), w * 0.32, j(0.18))
      ..quadraticBezierTo(w * 0.55, j(0.22), w * 0.78, j(0.18))
      ..quadraticBezierTo(w * 0.95, j(0.2), w + 2, h * 0.5 + j(0.3))
      ..quadraticBezierTo(
          w * 0.95, h - j(0.2), w * 0.78, h - j(0.18))
      ..quadraticBezierTo(w * 0.55, h - j(0.22), w * 0.32, h - j(0.18))
      ..quadraticBezierTo(w * 0.08, h - j(0.22), -2, h * 0.5 + j(0.3))
      ..close();

    canvas.drawPath(path, Paint()..color = color);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_HighlighterMarkerPainter old) =>
      old.color != color || old.seed != seed;
}

/// Builds the hand-drawn "highlighter marker" span for a single marked term.
/// Shared by [parseMarkedText] (public, unit-tested) and [_buildInlineSpans]
/// (internal, also supports **bold**) so the two never visually drift apart.
///
/// [tightRight] drops the right padding when the character immediately
/// following the marker is punctuation, so the mark doesn't create a visual
/// gap before it.
WidgetSpan _highlightSpan(
  String term,
  TextStyle base,
  Color highlightBg,
  Color textColor, {
  bool tightRight = false,
}) {
  return WidgetSpan(
    alignment: PlaceholderAlignment.middle,
    child: CustomPaint(
      painter: _HighlighterMarkerPainter(
        color: highlightBg,
        seed: term.hashCode,
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(4, 2, tightRight ? 2 : 4, 2),
        child: Text(term, style: base.copyWith(color: textColor)),
      ),
    ),
  );
}

/// Parses `==term==` markers in [text] into a soft, rounded stabilo-highlight
/// span (background [highlightBg], text [textColor]); everything else keeps
/// [base]. Pure and context-free so it can be unit-tested directly — see
/// `test/marked_text_test.dart`.
///
/// Used by [MarkedText] for reading content (article/care/trimester body
/// copy) where an important term — a medical word, a dosage limit — deserves
/// a highlighter sweep instead of a bold or colored word.
List<InlineSpan> parseMarkedText(
  String text, {
  required TextStyle base,
  required Color highlightBg,
  required Color textColor,
}) {
  final pattern = RegExp(r'==(.*?)==');
  final spans = <InlineSpan>[];
  int lastEnd = 0;

  for (final match in pattern.allMatches(text)) {
    if (match.start > lastEnd) {
      spans.add(TextSpan(text: text.substring(lastEnd, match.start), style: base));
    }
    final following = match.end < text.length ? text[match.end] : '';
    spans.add(_highlightSpan(
      match.group(1)!,
      base,
      highlightBg,
      textColor,
      tightRight: _trailingPunctuation.hasMatch(following),
    ));
    lastEnd = match.end;
  }
  if (lastEnd < text.length || spans.isEmpty) {
    spans.add(TextSpan(text: text.substring(lastEnd), style: base));
  }
  return spans;
}

/// Body text with `==term==` stabilo highlighting, theme-aware via
/// [context.palette]. Drop-in replacement for a plain [Text] anywhere in the
/// reading experience — bullets, callouts, paragraphs.
class MarkedText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const MarkedText(this.text, {super.key, this.style});

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final base = style ??
        GoogleFonts.literata(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: palette.ink,
          height: 1.65,
        );
    final spans = parseMarkedText(
      text,
      base: base,
      highlightBg: _markerYellow,
      textColor: _markerTextDark,
    );
    if (spans.length == 1 && spans.single is TextSpan) {
      return Text(text, style: base);
    }
    return Text.rich(TextSpan(children: spans));
  }
}

/// Parses inline markup and returns a list of [InlineSpan]s.
///
/// Supported syntax:
///   **text**   → bold (palette.ink, w700)
///   ==text==   → stabilo highlight, see [parseMarkedText]
///
/// Plain text outside markers inherits [base].
List<InlineSpan> _buildInlineSpans(
  String text,
  TextStyle base,
  SabinaPalette palette,
) {
  final boldStyle = base.copyWith(
    fontWeight: FontWeight.w700,
    color: palette.ink,
    background: null,
  );

  final pattern = RegExp(r'\*\*(.*?)\*\*|==(.*?)==');
  final spans = <InlineSpan>[];
  int lastEnd = 0;

  for (final match in pattern.allMatches(text)) {
    if (match.start > lastEnd) {
      spans.add(
        TextSpan(text: text.substring(lastEnd, match.start), style: base),
      );
    }
    if (match.group(1) != null) {
      spans.add(TextSpan(text: match.group(1)!, style: boldStyle));
    } else if (match.group(2) != null) {
      final following = match.end < text.length ? text[match.end] : '';
      spans.add(_highlightSpan(
        match.group(2)!,
        base,
        _markerYellow,
        _markerTextDark,
        tightRight: _trailingPunctuation.hasMatch(following),
      ));
    }
    lastEnd = match.end;
  }
  if (lastEnd < text.length) {
    spans.add(TextSpan(text: text.substring(lastEnd), style: base));
  }
  return spans;
}

// ── 1. Section Label ─────────────────────────────────────────────────────────

class ArticleSectionLabel extends StatelessWidget {
  final String text;
  final Color? accentColor;

  const ArticleSectionLabel(this.text, {super.key, this.accentColor});

  @override
  Widget build(BuildContext context) {
    final color = accentColor ?? context.palette.ink;
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Text(
        text,
        style: GoogleFonts.fraunces(
          fontSize: 21,
          fontWeight: FontWeight.w500,
          color: color,
          height: 1.25,
          letterSpacing: -0.2,
        ),
      ),
    );
  }
}

// ── 2. Standfirst (opening paragraph) ────────────────────────────────────────

/// First paragraph of an article — larger and slightly bolder than body text.
/// Use this ONCE, at the very top of the article body to hook the reader.
class ArticleStandfirst extends StatelessWidget {
  final String text;

  const ArticleStandfirst(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    final base = GoogleFonts.literata(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: context.palette.ink,
      height: 1.6,
    );
    final spans = _buildInlineSpans(text, base, context.palette);
    if (spans.length == 1) return Text(text, style: base);
    return Text.rich(TextSpan(children: spans));
  }
}

// ── 3. Body text ──────────────────────────────────────────────────────────────

/// Standard body paragraph. Use for secondary prose sections.
/// Reading voice: Literata (serif dibaca nyaman, ala Medium) ~16px,
/// line-height 1.6–1.7, always ink.
class ArticleBody extends StatelessWidget {
  final String text;

  const ArticleBody(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    final base = GoogleFonts.literata(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: context.palette.ink,
      height: 1.65,
    );
    final spans = _buildInlineSpans(text, base, context.palette);
    if (spans.length == 1) return Text(text, style: base);
    return Text.rich(TextSpan(children: spans));
  }
}

// ── 4. Callout box ────────────────────────────────────────────────────────────

/// Left-bordered box that draws attention to an important insight or warning.
/// Use sparingly — maximum 1–2 times per article for maximum impact.
class ArticleCallout extends StatelessWidget {
  final String text;

  /// Accent color for the left border and icon. Defaults to primary purple.
  final Color? color;

  /// Optional icon displayed in the left margin of the callout.
  final IconData? icon;

  const ArticleCallout(this.text, {super.key, this.color, this.icon});

  @override
  Widget build(BuildContext context) {
    final c = color ?? SabinaColors.primary700;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.06),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
        border: Border(left: BorderSide(color: c, width: 3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Icon(icon!, size: 13, color: c),
            ),
            const SizedBox(width: 10),
          ],
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.literata(
                fontSize: 14.5,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500,
                color: context.palette.ink,
                height: 1.75,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── 4b. Pull quote ────────────────────────────────────────────────────────────

/// Large pulled-out quote — an excerpt already present in the surrounding
/// body text, set big and editorial (Medium-style) as a visual breather.
/// Use once, maybe twice per article; never introduce new copy here — pull
/// an existing sentence out, don't write one.
class ArticlePullQuote extends StatelessWidget {
  final String text;

  const ArticlePullQuote(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(width: 32, height: 3, color: p.primary),
          const SizedBox(height: 16),
          Text(
            text,
            style: GoogleFonts.fraunces(
              fontSize: 23,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic,
              color: p.ink,
              height: 1.4,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 16),
          Container(width: 32, height: 3, color: p.primary),
        ],
      ),
    );
  }
}

// ── 5. Highlight text ─────────────────────────────────────────────────────────

/// Body text with inline keyword highlighting.
/// Pass [highlights] with the exact terms (case-insensitive) to mark.
/// Works for both ID and EN — include both language variants in [highlights].
///
/// Example:
/// ```dart
/// ArticleHighlightText(
///   l10n.someContent,
///   highlights: ['asam folat', 'folic acid', 'kalsium', 'calcium'],
/// )
/// ```
class ArticleHighlightText extends StatelessWidget {
  final String text;
  final List<String> highlights;
  final TextStyle? baseStyle;
  final Color? highlightBg;
  final Color? highlightFg;

  const ArticleHighlightText(
    this.text, {
    super.key,
    this.highlights = const [],
    this.baseStyle,
    this.highlightBg,
    this.highlightFg,
  });

  @override
  Widget build(BuildContext context) {
    final base = baseStyle ??
        GoogleFonts.literata(
          fontSize: 15,
          color: SabinaColors.neutral700,
          height: 1.8,
        );
    if (highlights.isEmpty) return Text(text, style: base);

    final spans = _buildSpans(text, highlights, base, highlightBg, highlightFg);
    return Text.rich(TextSpan(children: spans));
  }

  static List<TextSpan> _buildSpans(
    String text,
    List<String> keywords,
    TextStyle base,
    Color? bg,
    Color? fg,
  ) {
    final bgColor = bg ?? const Color(0xFFD4F0E8); // teal-100
    final fgColor = fg ?? const Color(0xFF6F937D); // teal

    // Collect all match ranges
    final ranges = <_HighlightRange>[];
    for (final kw in keywords) {
      int start = 0;
      while (true) {
        final idx = text.toLowerCase().indexOf(kw.toLowerCase(), start);
        if (idx == -1) break;
        ranges.add(_HighlightRange(idx, idx + kw.length));
        start = idx + kw.length;
      }
    }
    ranges.sort((a, b) => a.start.compareTo(b.start));

    // Merge overlapping ranges
    final merged = <_HighlightRange>[];
    for (final r in ranges) {
      if (merged.isNotEmpty && r.start <= merged.last.end) {
        if (r.end > merged.last.end) merged.last.end = r.end;
      } else {
        merged.add(r);
      }
    }

    // Build spans
    final spans = <TextSpan>[];
    int pos = 0;
    for (final r in merged) {
      if (pos < r.start) {
        spans.add(TextSpan(text: text.substring(pos, r.start), style: base));
      }
      spans.add(
        TextSpan(
          text: text.substring(r.start, r.end),
          style: base.copyWith(
            backgroundColor: bgColor,
            color: fgColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
      pos = r.end;
    }
    if (pos < text.length) {
      spans.add(TextSpan(text: text.substring(pos), style: base));
    }
    return spans;
  }
}

class _HighlightRange {
  int start;
  int end;
  _HighlightRange(this.start, this.end);
}

// ── 6. Numbered item ─────────────────────────────────────────────────────────

/// Universal numbered section used across all article screens.
///
/// Supply either [content] (single paragraph) or [items] (bullet list).
/// Both [icon] and [accentColor] are optional — color defaults to primary purple.
class ArticleNumberedItem extends StatelessWidget {
  final int number;
  final String title;
  final IconData? icon;
  final Color color;

  /// Paragraph content — mutually exclusive with [items].
  final String? content;

  /// Bullet list items — mutually exclusive with [content].
  final List<String>? items;

  final bool isLast;

  const ArticleNumberedItem({
    super.key,
    required this.number,
    required this.title,
    this.icon,
    this.color = const Color(0xFF8A5C7C), // SabinaColors.primary700
    this.content,
    this.items,
    this.isLast = false,
  }) : assert(
          content != null || items != null,
          'ArticleNumberedItem: provide either content or items',
        );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Header row ────────────────────────────────────────────────────────
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _badge(),
            const SizedBox(width: 12),
            if (icon != null) ...[
              Icon(icon!, size: 13, color: color),
              const SizedBox(width: 8),
            ],
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: SabinaColors.neutral900,
                  height: 1.3,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // ── Content ───────────────────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.only(left: 40),
          child: content != null
              ? Text(
                  content!,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 15,
                    color: SabinaColors.neutral700,
                    height: 1.8,
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: items!.map(_bulletRow).toList(),
                ),
        ),

        if (!isLast) ...[
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Divider(color: SabinaColors.neutral300),
          ),
          const SizedBox(height: 24),
        ] else
          const SizedBox(height: 8),
      ],
    );
  }

  Widget _badge() => Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            '$number',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
        ),
      );

  Widget _bulletRow(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Container(
                width: 5,
                height: 5,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                text,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 15,
                  color: SabinaColors.neutral700,
                  height: 1.75,
                ),
              ),
            ),
          ],
        ),
      );
}

// ── 6b. Bullet list — uniform sage dot ───────────────────────────────────────

/// Shared bullet list for reading content: a small uniform sage dot per line,
/// body text always ink. One accent (sage) for every bullet on every page —
/// no more per-section blue/pink/amber dots competing with each other.
/// Each item supports `==term==` stabilo highlighting via [MarkedText].
class ArticleBulletList extends StatelessWidget {
  final List<String> items;
  final double gap;
  final TextStyle? textStyle;

  /// Warna marker (dash). Default ink netral hitam-putih — boleh dioverride
  /// saat bullet ditampilkan di dalam kotak bertema warna lain.
  final Color? dotColor;

  const ArticleBulletList(this.items,
      {super.key, this.gap = 10, this.textStyle, this.dotColor});

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final base = textStyle ??
        GoogleFonts.literata(
          fontSize: 16,
          color: palette.ink,
          height: 1.65,
        );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map((item) => Padding(
                padding: EdgeInsets.only(bottom: gap),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tanda hubung editorial — bukan bulatan padat yang
                    // terasa seperti bullet UI, lebih menyatu dengan bacaan.
                    Text(
                      '–',
                      style: base.copyWith(
                        fontWeight: FontWeight.w600,
                        color: dotColor ?? palette.inkMuted,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          children: parseMarkedText(
                            item,
                            base: base,
                            highlightBg: _markerYellow,
                            textColor: _markerTextDark,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }
}

// ── 6c. Magazine section number ──────────────────────────────────────────────

/// "Nomor bagian majalah": a large, light-weight serif number in the page's
/// single accent (mulberry), paired with an ink title — replacing the old
/// colored circle badge + icon + colored title combo. One quiet ornament
/// instead of three competing ones.
class ArticleMagazineNumber extends StatelessWidget {
  final int number;
  final String title;

  const ArticleMagazineNumber({
    super.key,
    required this.number,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          number.toString().padLeft(2, '0'),
          style: GoogleFonts.fraunces(
            fontSize: 26,
            fontWeight: FontWeight.w300,
            color: palette.ink,
            height: 1.0,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Text(
            title,
            style: GoogleFonts.fraunces(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: palette.ink,
              height: 1.3,
            ),
          ),
        ),
      ],
    );
  }
}

/// Full numbered section for the reading experience: [ArticleMagazineNumber]
/// header + indented paragraph ([content]) or bullet list ([items]) below.
/// No divider between sections — spacing alone sets the rhythm (28–36px
/// between sections via [isLast], 10–14px within one via [ArticleBulletList]).
class ArticleMagazineSection extends StatelessWidget {
  final int number;
  final String title;

  /// Paragraph content — mutually exclusive with [items].
  final String? content;

  /// Bullet list items — mutually exclusive with [content].
  final List<String>? items;

  final bool isLast;

  const ArticleMagazineSection({
    super.key,
    required this.number,
    required this.title,
    this.content,
    this.items,
    this.isLast = false,
  }) : assert(
          content != null || items != null,
          'ArticleMagazineSection: provide either content or items',
        );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ArticleMagazineNumber(number: number, title: title),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.only(left: 56),
          child: content != null
              ? MarkedText(content!)
              : ArticleBulletList(items!),
        ),
        SizedBox(height: isLast ? 8 : 30),
      ],
    );
  }
}

// ── 7. Inline image with caption ─────────────────────────────────────────────

/// Image with optional caption. Tap opens full-screen photo viewer.
class ArticleInlineImage extends StatelessWidget {
  final String imagePath;
  final String? caption;
  final double? height;
  final BorderRadius? borderRadius;

  const ArticleInlineImage(
    this.imagePath, {
    super.key,
    this.caption,
    this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final br = borderRadius ?? BorderRadius.circular(14);
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              leading: IconButton(
                icon: const Icon(Icons.close_rounded, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: PhotoView(
              imageProvider: AssetImage(imagePath),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 2,
            ),
          ),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: br,
          boxShadow: [
            BoxShadow(
              color: SabinaColors.neutral900.withValues(alpha: 0.07),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: br,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                imagePath,
                width: double.infinity,
                height: height,
                fit: BoxFit.cover,
              ),
              if (caption != null)
                Container(
                  color: SabinaColors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search_rounded,
                        size: 10,
                        color: SabinaColors.neutral500,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          caption!,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11,
                            fontStyle: FontStyle.italic,
                            color: SabinaColors.neutral500,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── 7b. Week timeline ─────────────────────────────────────────────────────────

/// One row of [ArticleWeekTimeline]: a week-range label + its description.
class ArticleWeekEntry {
  final String week;
  final String desc;
  const ArticleWeekEntry(this.week, this.desc);
}

/// Vertical timeline for "week-by-week development" sections — a dot + line
/// per entry instead of a flat, visually monotonous stack of rows. Node,
/// connector and week-badge are deliberately monochrome (ink/groundAlt), not
/// per-topic accent colors.
class ArticleWeekTimeline extends StatelessWidget {
  final List<ArticleWeekEntry> entries;
  const ArticleWeekTimeline(this.entries, {super.key});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Column(
      children: entries.asMap().entries.map((e) {
        final isLast = e.key == entries.length - 1;
        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 9,
                    height: 9,
                    margin: const EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                      color: p.ink,
                      shape: BoxShape.circle,
                    ),
                  ),
                  if (!isLast)
                    Expanded(
                      child: Container(
                        width: 2,
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        color: p.ink.withValues(alpha: 0.25),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: p.groundAlt,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          e.value.week,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: p.ink,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      MarkedText(e.value.desc),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

// ── 7c. Mini label ────────────────────────────────────────────────────────────

/// Small caps sub-heading above a bullet list, for when a single
/// [ArticleSectionLabel] covers two contrasting lists (e.g. "Recommended &
/// Avoid") and a plain [ArticleBulletList] alone would blur the two together.
/// Deliberately lightweight — no box, no icon, just type and color.
class ArticleMiniLabel extends StatelessWidget {
  final String text;
  final Color color;

  const ArticleMiniLabel(this.text, {super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text.toUpperCase(),
        style: GoogleFonts.plusJakartaSans(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.0,
          color: color,
        ),
      ),
    );
  }
}

// ── 8. Reference list ─────────────────────────────────────────────────────────

/// Numbered reference / source list rendered at the end of an article.
class ArticleReferenceList extends StatelessWidget {
  final List<String> references;

  const ArticleReferenceList({super.key, required this.references});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: references.asMap().entries.map((e) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${e.key + 1}.',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: SabinaColors.neutral500,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  e.value,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    color: SabinaColors.neutral500,
                    height: 1.6,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

// ── 9. Article divider ────────────────────────────────────────────────────────

/// Thin horizontal divider with built-in top/bottom spacing.
class ArticleDivider extends StatelessWidget {
  const ArticleDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Divider(color: SabinaColors.neutral300),
    );
  }
}
