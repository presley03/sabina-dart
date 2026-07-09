# Flutter wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }
-dontwarn io.flutter.embedding.**

# Play Core (deferred components / split install), referenced by Flutter's
# embedding even when not used directly.
-dontwarn com.google.android.play.core.**

# Keep annotations and generic signatures used by reflection-based plugins.
-keepattributes *Annotation*, Signature, Exception
