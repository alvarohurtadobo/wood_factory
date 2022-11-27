String getDatetime(DateTime myTime) {
  return "${myTime.toIso8601String().substring(0, 10)} ${myTime.toIso8601String().substring(11, 16)}";
}

String getDatetimeForFileName(DateTime myTime) {
  return getDatetime(myTime).replaceAll(" ", "_");
}
