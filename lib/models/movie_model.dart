class Movie {
  final bool? adult;
  final String? backdropPath;
  final BelongsToCollection? belongsToCollection;
  final int? budget;
  final List<Genre>? genres;
  final String? homepage;
  final int? id;
  final String? imdbId;
  final List<String>? originCountry;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final List<ProductionCompany>? productionCompanies;
  final List<ProductionCountry>? productionCountries;
  final String? releaseDate;
  final int? revenue;
  final int? runtime;
  final List<SpokenLanguage>? spokenLanguages;
  final String? status;
  final String? tagline;
  final String? title;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;

  Movie({
    this.adult,
    this.backdropPath,
    this.belongsToCollection,
    this.budget,
    this.genres,
    this.homepage,
    this.id,
    this.imdbId,
    this.originCountry,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory Movie.fromMap(Map<String, dynamic> map) {
    print('Movie fromMap: $map'); // Debug print to log the entire map
    return Movie(
      adult: map['adult'] as bool?,
      backdropPath: map['backdrop_path'] as String?,
      belongsToCollection: map['belongs_to_collection'] != null
          ? BelongsToCollection.fromMap(map['belongs_to_collection'])
          : null,
      budget: map['budget'] as int?,
      genres: map['genres'] != null
          ? List<Genre>.from(map['genres'].map((x) {
              print('Genre map: $x'); // Debug print for each genre
              return Genre.fromMap(x);
            }))
          : null,
      homepage: map['homepage'] as String?,
      id: map['id'] as int?,
      imdbId: map['imdb_id'] as String?,
      originCountry: map['origin_country'] != null
          ? List<String>.from(map['origin_country'])
          : null,
      originalLanguage: map['original_language'] as String?,
      originalTitle: map['original_title'] as String?,
      overview: map['overview'] as String?,
      popularity: (map['popularity'] as num?)?.toDouble(),
      posterPath: map['poster_path'] as String?,
      productionCompanies: map['production_companies'] != null
          ? List<ProductionCompany>.from(map['production_companies'].map((x) {
              print(
                  'Production Company map: $x'); // Debug print for each production company
              return ProductionCompany.fromMap(x);
            }))
          : null,
      productionCountries: map['production_countries'] != null
          ? List<ProductionCountry>.from(map['production_countries'].map((x) {
              print(
                  'Production Country map: $x'); // Debug print for each production country
              return ProductionCountry.fromMap(x);
            }))
          : null,
      releaseDate: map['release_date'] as String?,
      revenue: map['revenue'] as int?,
      runtime: map['runtime'] as int?,
      spokenLanguages: map['spoken_languages'] != null
          ? List<SpokenLanguage>.from(map['spoken_languages'].map((x) {
              print(
                  'Spoken Language map: $x'); // Debug print for each spoken language
              return SpokenLanguage.fromMap(x);
            }))
          : null,
      status: map['status'] as String?,
      tagline: map['tagline'] as String?,
      title: map['title'] as String?,
      video: map['video'] as bool?,
      voteAverage: (map['vote_average'] as num?)?.toDouble(),
      voteCount: map['vote_count'] as int?,
    );
  }
}

class BelongsToCollection {
  final int? id;
  final String? name;
  final String? posterPath;
  final String? backdropPath;

  BelongsToCollection({
    this.id,
    this.name,
    this.posterPath,
    this.backdropPath,
  });

  factory BelongsToCollection.fromMap(Map<String, dynamic> map) {
    return BelongsToCollection(
      id: map['id'] as int?,
      name: map['name'] as String?,
      posterPath: map['poster_path'] as String?,
      backdropPath: map['backdrop_path'] as String?,
    );
  }
}

class Genre {
  final int? id;
  final String? name;

  Genre({
    this.id,
    this.name,
  });

  factory Genre.fromMap(Map<String, dynamic> map) {
    return Genre(
      id: map['id'] as int?,
      name: map['name'] as String?,
    );
  }
}

class ProductionCompany {
  final int? id;
  final String? name;
  final String? originCountry;
  final String? logoPath;

  ProductionCompany({
    this.id,
    this.name,
    this.originCountry,
    this.logoPath,
  });

  factory ProductionCompany.fromMap(Map<String, dynamic> map) {
    return ProductionCompany(
      id: map['id'] as int?,
      name: map['name'] as String?,
      originCountry: map['origin_country'] as String?,
      logoPath: map['logo_path'] as String?,
    );
  }
}

class ProductionCountry {
  final String? iso31661;
  final String? name;

  ProductionCountry({
    this.iso31661,
    this.name,
  });

  factory ProductionCountry.fromMap(Map<String, dynamic> map) {
    return ProductionCountry(
      iso31661: map['iso_3166_1'] as String?,
      name: map['name'] as String?,
    );
  }
}

class SpokenLanguage {
  final String? englishName;
  final String? iso6391;
  final String? name;

  SpokenLanguage({
    this.englishName,
    this.iso6391,
    this.name,
  });

  factory SpokenLanguage.fromMap(Map<String, dynamic> map) {
    return SpokenLanguage(
      englishName: map['english_name'] as String?,
      iso6391: map['iso_639_1'] as String?,
      name: map['name'] as String?,
    );
  }
}
