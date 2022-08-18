class Info {
  int count;
  int pages;
  String next;

  Info({
    required this.count,
    required this.pages,
    required this.next,
  });

  factory Info.fromJson(Map<String, dynamic> json) => Info(
    count: json["count"],
    pages: json["pages"],
    next: json["next"],
  );
}