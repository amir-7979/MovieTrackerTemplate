class SearchFilter{
  String types = 'movie-serial-anime_movie-anime_serial';
  String years = '1990-2022';
  String imdbScores = '0-10';
  String malScores = '0-10';
  SearchFilter(this.types, this.years, this.imdbScores, this.malScores);


  @override
  String toString() => '/$types/low/$years/$imdbScores/$malScores/';
}