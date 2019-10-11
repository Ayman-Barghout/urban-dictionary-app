class Definition {
  final String definition;
  final int thumbsUp;
  final int thumbsDown;
  final String author;
  final String example;

  Definition(this.definition, this.thumbsUp, this.thumbsDown, this.author,
      this.example);

  Definition.fromJson(Map<String, dynamic> json)
      : definition = json['definition'],
        thumbsUp = json['thumbs_up'],
        thumbsDown = json['thumbs_down'],
        author = json['author'],
        example = json['example'];

  Map<String, dynamic> toJson() => {
        'definition': definition,
        'thumbs_up': thumbsUp,
        'thumbs_down': thumbsDown,
        'author': author,
        'example': example,
      };
}
