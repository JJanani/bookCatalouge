class BookResponses{
  List<BookModelResponse> bookModelResponses;

  BookResponses({this.bookModelResponses});


  BookResponses.fromJson(Map<String, dynamic> json) {
    bookModelResponses = List<BookModelResponse>();
    if (json['results'] != null) {
      json['results'].forEach((v) {
        bookModelResponses.add(BookModelResponse.fromJson(v));
      });
    }
  }
}


class BookModelResponse {
  final int id;
  final String title;
  final String mediaType;
  final Authors authors;

  BookModelResponse({this.id, this.title, this.mediaType, this.authors});

  factory BookModelResponse.fromJson(Map<String, dynamic> json) =>
      BookModelResponse(
        id: json['id'] == null ? null : json['id'],
        title: json['title'] == null ? null : json['title'],
        mediaType: json['media_type'] == null ? null : json['media_type'],
        authors: json['authors'] == null ? null : Authors.fromJson(json['authors']),
      );
}

class Authors {
  List<Author> authors;

  Authors({this.authors});

  Authors.fromJson(Map<String, dynamic> json) {
    authors = List<Author>();
    if (json['authors'] != null) {
      json['authors'].forEach((v) {
        authors.add(Author.fromJson(v));
      });
    }
  }
}

class Author {
  final int birthYear;
  final int deathYear;
  final String name;

  Author({this.birthYear, this.deathYear, this.name});

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        birthYear: json['birth_year'] == null ? null : json['birth_year'],
        deathYear: json['death_year'] == null ? null : json['death_year'],
        name: json['name'] == null ? null : json['name'],
      );
}
