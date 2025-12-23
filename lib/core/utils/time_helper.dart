class TimeHelper {
  String calculateReadingTime({required String content}) {
    final int wordCount = content.split(RegExp(r'\s+')).length;
    final double readTime = 255 / wordCount;
    return readTime.ceil().toString();
  }
}
