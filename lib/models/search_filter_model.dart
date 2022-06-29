enum FilterType{
  film,
  staff,
  character,
}

class SearchFilter{
  FilterType filterType = FilterType.film;
  String types = 'movie-serial-anime_movie-anime_serial';
  String years = '1990-2022';
  String imdbScores = '0-10';
  String malScores = '0-10';

  SearchFilter(this.types, this.years, this.imdbScores, this.malScores);

  String filmToString() => '/$types/low/$years/$imdbScores/$malScores/';
  String staffToString() => '/movie-serial-anime_movie-anime_serial/low/1990-2022/0-10/0-10/';

}