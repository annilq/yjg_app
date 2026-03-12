class WebviewConfig {
  final String url;
  final String title;
  final bool enableJavaScript;
  final bool enableDomStorage;
  final bool enableZoom;

  WebviewConfig({
    required this.url,
    this.title = '',
    this.enableJavaScript = true,
    this.enableDomStorage = true,
    this.enableZoom = false,
  });
}
