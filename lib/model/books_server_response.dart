import 'package:book_catalog/model/book_model_response.dart';

// To parse this JSON data, do
//
//     final booksServerResponse = booksServerResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class BooksServerResponse {
  BooksServerResponse({
    @required this.count,
    @required this.next,
    @required this.previous,
    @required this.results,
  });

  final int count;
  String next;
  final dynamic previous;
  final List<Result> results;

  BooksServerResponse copyWith({
    int count,
    String next,
    dynamic previous,
    List<Result> results,
  }) =>
      BooksServerResponse(
        count: count ?? this.count,
        next: next ?? this.next,
        previous: previous ?? this.previous,
        results: results ?? this.results,
      );

  factory BooksServerResponse.fromJson(Map<String, dynamic> str) => BooksServerResponse.fromMap(str);

  String toJson() => json.encode(toMap());

  factory BooksServerResponse.fromMap(Map<String, dynamic> json) => BooksServerResponse(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: List<Result>.from(json["results"].map((x) => Result.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": List<dynamic>.from(results.map((x) => x.toMap())),
  };
}

class Result {
  Result({
    @required this.id,
    @required this.authors,
    @required this.bookshelves,
    @required this.downloadCount,
    @required this.formats,
    @required this.languages,
    @required this.mediaType,
    @required this.subjects,
    @required this.title,
  });

  final int id;
  final List<Author> authors;
  final List<String> bookshelves;
  final int downloadCount;
  final Formats formats;
  final List<Language> languages;
  final MediaType mediaType;
  final List<String> subjects;
  final String title;

  Result copyWith({
    int id,
    List<Author> authors,
    List<String> bookshelves,
    int downloadCount,
    Formats formats,
    List<Language> languages,
    MediaType mediaType,
    List<String> subjects,
    String title,
  }) =>
      Result(
        id: id ?? this.id,
        authors: authors ?? this.authors,
        bookshelves: bookshelves ?? this.bookshelves,
        downloadCount: downloadCount ?? this.downloadCount,
        formats: formats ?? this.formats,
        languages: languages ?? this.languages,
        mediaType: mediaType ?? this.mediaType,
        subjects: subjects ?? this.subjects,
        title: title ?? this.title,
      );

  factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Result.fromMap(Map<String, dynamic> json) => Result(
    id: json["id"],
    authors: List<Author>.from(json["authors"].map((x) => Author.fromMap(x))),
    bookshelves: List<String>.from(json["bookshelves"].map((x) => x)),
    downloadCount: json["download_count"],
    formats: Formats.fromMap(json["formats"]),
    languages: List<Language>.from(json["languages"].map((x) => languageValues.map[x])),
    mediaType: mediaTypeValues.map[json["media_type"]],
    subjects: List<String>.from(json["subjects"].map((x) => x)),
    title: json["title"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "authors": List<dynamic>.from(authors.map((x) => x.toMap())),
    "bookshelves": List<dynamic>.from(bookshelves.map((x) => x)),
    "download_count": downloadCount,
    "formats": formats.toMap(),
    "languages": List<dynamic>.from(languages.map((x) => languageValues.reverse[x])),
    "media_type": mediaTypeValues.reverse[mediaType],
    "subjects": List<dynamic>.from(subjects.map((x) => x)),
    "title": title,
  };
}

class Author {
  Author({
    @required this.birthYear,
    @required this.deathYear,
    @required this.name,
  });

  final int birthYear;
  final int deathYear;
  final String name;

  Author copyWith({
    int birthYear,
    int deathYear,
    String name,
  }) =>
      Author(
        birthYear: birthYear ?? this.birthYear,
        deathYear: deathYear ?? this.deathYear,
        name: name ?? this.name,
      );

  factory Author.fromJson(String str) => Author.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Author.fromMap(Map<String, dynamic> json) => Author(
    birthYear: json["birth_year"] == null ? null : json["birth_year"],
    deathYear: json["death_year"] == null ? null : json["death_year"],
    name: json["name"],
  );

  Map<String, dynamic> toMap() => {
    "birth_year": birthYear == null ? null : birthYear,
    "death_year": deathYear == null ? null : deathYear,
    "name": name,
  };
}

class Formats {
  Formats({
    @required this.applicationXMobipocketEbook,
    @required this.applicationPdf,
    @required this.textPlainCharsetUsAscii,
    @required this.textPlainCharsetUtf8,
    @required this.applicationRdfXml,
    @required this.applicationZip,
    @required this.applicationEpubZip,
    @required this.textHtmlCharsetUtf8,
    @required this.textPlainCharsetIso88591,
    @required this.imageJpeg,
    @required this.textPlain,
    @required this.textHtmlCharsetUsAscii,
    @required this.textHtml,
    @required this.textRtf,
    @required this.textHtmlCharsetIso88591,
    @required this.applicationPrsTex,
  });

  final String applicationXMobipocketEbook;
  final String applicationPdf;
  final String textPlainCharsetUsAscii;
  final String textPlainCharsetUtf8;
  final String applicationRdfXml;
  final String applicationZip;
  final String applicationEpubZip;
  final String textHtmlCharsetUtf8;
  final String textPlainCharsetIso88591;
  final String imageJpeg;
  final String textPlain;
  final String textHtmlCharsetUsAscii;
  final String textHtml;
  final String textRtf;
  final String textHtmlCharsetIso88591;
  final String applicationPrsTex;

  Formats copyWith({
    String applicationXMobipocketEbook,
    String applicationPdf,
    String textPlainCharsetUsAscii,
    String textPlainCharsetUtf8,
    String applicationRdfXml,
    String applicationZip,
    String applicationEpubZip,
    String textHtmlCharsetUtf8,
    String textPlainCharsetIso88591,
    String imageJpeg,
    String textPlain,
    String textHtmlCharsetUsAscii,
    String textHtml,
    String textRtf,
    String textHtmlCharsetIso88591,
    String applicationPrsTex,
  }) =>
      Formats(
        applicationXMobipocketEbook: applicationXMobipocketEbook ?? this.applicationXMobipocketEbook,
        applicationPdf: applicationPdf ?? this.applicationPdf,
        textPlainCharsetUsAscii: textPlainCharsetUsAscii ?? this.textPlainCharsetUsAscii,
        textPlainCharsetUtf8: textPlainCharsetUtf8 ?? this.textPlainCharsetUtf8,
        applicationRdfXml: applicationRdfXml ?? this.applicationRdfXml,
        applicationZip: applicationZip ?? this.applicationZip,
        applicationEpubZip: applicationEpubZip ?? this.applicationEpubZip,
        textHtmlCharsetUtf8: textHtmlCharsetUtf8 ?? this.textHtmlCharsetUtf8,
        textPlainCharsetIso88591: textPlainCharsetIso88591 ?? this.textPlainCharsetIso88591,
        imageJpeg: imageJpeg ?? this.imageJpeg,
        textPlain: textPlain ?? this.textPlain,
        textHtmlCharsetUsAscii: textHtmlCharsetUsAscii ?? this.textHtmlCharsetUsAscii,
        textHtml: textHtml ?? this.textHtml,
        textRtf: textRtf ?? this.textRtf,
        textHtmlCharsetIso88591: textHtmlCharsetIso88591 ?? this.textHtmlCharsetIso88591,
        applicationPrsTex: applicationPrsTex ?? this.applicationPrsTex,
      );

  factory Formats.fromJson(String str) => Formats.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Formats.fromMap(Map<String, dynamic> json) => Formats(
    applicationXMobipocketEbook: json["application/x-mobipocket-ebook"] == null ? null : json["application/x-mobipocket-ebook"],
    applicationPdf: json["application/pdf"] == null ? null : json["application/pdf"],
    textPlainCharsetUsAscii: json["text/plain; charset=us-ascii"] == null ? null : json["text/plain; charset=us-ascii"],
    textPlainCharsetUtf8: json["text/plain; charset=utf-8"] == null ? null : json["text/plain; charset=utf-8"],
    applicationRdfXml: json["application/rdf+xml"],
    applicationZip: json["application/zip"] == null ? null : json["application/zip"],
    applicationEpubZip: json["application/epub+zip"] == null ? null : json["application/epub+zip"],
    textHtmlCharsetUtf8: json["text/html; charset=utf-8"] == null ? null : json["text/html; charset=utf-8"],
    textPlainCharsetIso88591: json["text/plain; charset=iso-8859-1"] == null ? null : json["text/plain; charset=iso-8859-1"],
    imageJpeg: json["image/jpeg"] == null ? null : json["image/jpeg"],
    textPlain: json["text/plain"] == null ? null : json["text/plain"],
    textHtmlCharsetUsAscii: json["text/html; charset=us-ascii"] == null ? null : json["text/html; charset=us-ascii"],
    textHtml: json["text/html"] == null ? null : json["text/html"],
    textRtf: json["text/rtf"] == null ? null : json["text/rtf"],
    textHtmlCharsetIso88591: json["text/html; charset=iso-8859-1"] == null ? null : json["text/html; charset=iso-8859-1"],
    applicationPrsTex: json["application/prs.tex"] == null ? null : json["application/prs.tex"],
  );

  Map<String, dynamic> toMap() => {
    "application/x-mobipocket-ebook": applicationXMobipocketEbook == null ? null : applicationXMobipocketEbook,
    "application/pdf": applicationPdf == null ? null : applicationPdf,
    "text/plain; charset=us-ascii": textPlainCharsetUsAscii == null ? null : textPlainCharsetUsAscii,
    "text/plain; charset=utf-8": textPlainCharsetUtf8 == null ? null : textPlainCharsetUtf8,
    "application/rdf+xml": applicationRdfXml,
    "application/zip": applicationZip == null ? null : applicationZip,
    "application/epub+zip": applicationEpubZip == null ? null : applicationEpubZip,
    "text/html; charset=utf-8": textHtmlCharsetUtf8 == null ? null : textHtmlCharsetUtf8,
    "text/plain; charset=iso-8859-1": textPlainCharsetIso88591 == null ? null : textPlainCharsetIso88591,
    "image/jpeg": imageJpeg == null ? null : imageJpeg,
    "text/plain": textPlain == null ? null : textPlain,
    "text/html; charset=us-ascii": textHtmlCharsetUsAscii == null ? null : textHtmlCharsetUsAscii,
    "text/html": textHtml == null ? null : textHtml,
    "text/rtf": textRtf == null ? null : textRtf,
    "text/html; charset=iso-8859-1": textHtmlCharsetIso88591 == null ? null : textHtmlCharsetIso88591,
    "application/prs.tex": applicationPrsTex == null ? null : applicationPrsTex,
  };
}

enum Language { EN, ES }

final languageValues = EnumValues({
  "en": Language.EN,
  "es": Language.ES
});

enum MediaType { TEXT }

final mediaTypeValues = EnumValues({
  "Text": MediaType.TEXT
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
