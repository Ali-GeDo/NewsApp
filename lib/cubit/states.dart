abstract class NewsStats {}

class NewsInitialState extends NewsStats{}

class NewsButtonNavState extends NewsStats{}

class NewsLoadingGetBusinessState extends NewsStats{}

class NewsGetBusinessSuccessState extends NewsStats{}

class NewsGetBusinessErrorState extends NewsStats{
final String error;

  NewsGetBusinessErrorState(this.error);
}

class NewsLoadingGetSportsState extends NewsStats{}

class NewsGetSportsSuccessState extends NewsStats{}

class NewsGetSportsErrorState extends NewsStats{
  final String error;

  NewsGetSportsErrorState(this.error);
}

class NewsLoadingGetSciencesState extends NewsStats{}

class NewsGetSciencesSuccessState extends NewsStats{}

class NewsGetSciencesErrorState extends NewsStats{
  final String error;

  NewsGetSciencesErrorState(this.error);
}

class NewsLoadingGetSearchState extends NewsStats{}

class NewsGetSearchSuccessState extends NewsStats{}

class NewsGetSearchErrorState extends NewsStats{
  final String error;

  NewsGetSearchErrorState(this.error);
}



