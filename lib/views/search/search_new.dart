import 'package:cached_network_image/cached_network_image.dart';
import 'package:cowlar_design_task/bloc/upcoming_movie_bloc/upcoming_movie_bloc.dart';
import 'package:cowlar_design_task/bloc/upcoming_movie_bloc/upcoming_movie_event.dart';
import 'package:cowlar_design_task/bloc/upcoming_movie_bloc/upcoming_movie_state.dart';
import 'package:cowlar_design_task/config/colors.dart';
import 'package:cowlar_design_task/config/const_url.dart';
import 'package:cowlar_design_task/config/helper_function.dart';
import 'package:cowlar_design_task/models/upcoming_movie_model.dart';
import 'package:cowlar_design_task/views/widgets/custom_app_bar.dart';
import 'package:cowlar_design_task/views/widgets/search_widget.dart';
import 'package:cowlar_design_task/views/widgets/widget_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../movie_home/movie_detail_screen.dart';

class SearchNew extends StatefulWidget {
  const SearchNew({super.key});

  @override
  State<SearchNew> createState() => _SearchNewState();
}

class _SearchNewState extends State<SearchNew> {
  late UpcomingMovieBloc upcomingMovieBloc;
  TextEditingController searchController = TextEditingController();
  UpcomingMovieModel? upcomingMovieModel;

  @override
  void initState() {
    super.initState();
    upcomingMovieBloc = UpcomingMovieBloc()..add(GetUpcomingMovieList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Search",
        showAction: true,
        isSearch: true,
        showLeadingIcon: false,
      ),
      body: BlocProvider(
        create: (_) => upcomingMovieBloc,
        child: BlocBuilder<UpcomingMovieBloc, UpcomingMovieState>(
          builder: (context, state) {
            if (state is UpcomingMovieInitial) {
              return Center(
                child: CircularProgressIndicator(
                  color: whiteColor,
                ),
              );
            } else if (state is UpcomingMovieLoaded) {
              upcomingMovieModel = state.upcomingMovieModel;
              return _buildSearchScreen(
                  context, upcomingMovieModel, state.searchMovies ?? []);
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget _buildSearchScreen(BuildContext context, UpcomingMovieModel? model,
      List<UpcomingMovieModelResults?> searchList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        addVerticalSpace(20),
        CustomSearchBar(
          hintText: "Search",
          controller: searchController,
          onChanged: (value) => _onSearchTextChanged(value, model),
        ),
        addVerticalSpace(15),
        Expanded(
          child: ListView.builder(
            itemCount: searchList.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              final imageUrl = searchList[index]?.posterPath ?? "";

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailScreen(
                          imageUrl: "$imageBaseUrl$imageUrl",
                          movieId: searchList[index]?.id.toString() ?? "",
                        ),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Container(
                        height: 140,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(
                                "$imageBaseUrl$imageUrl"),
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.5),
                                BlendMode.overlay),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      addHorizontalSpace(20),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                searchList[index]?.title ?? "unknown",
                                style: createCustomTextStyle(fontSize: 18),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              addVerticalSpace(10),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star_border_purple500_outlined,
                                    color: orange,
                                  ),
                                  addHorizontalSpace(5),
                                  Text(
                                    searchList[index]?.popularity.toString() ??
                                        "1",
                                    style: createCustomTextStyle(color: orange),
                                  ),
                                ],
                              ),
                              // Other movie details...
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _onSearchTextChanged(String? value, UpcomingMovieModel? model) {
    final searchText = value?.trim().toLowerCase();
    if (searchText != null && searchText.isNotEmpty) {
      upcomingMovieBloc.add(GetSearchMovie(model!, searchText));
    } else {
      upcomingMovieBloc.add(GetUpcomingMovieList());
    }
  }

  @override
  void dispose() {
    upcomingMovieBloc.close();
    super.dispose();
  }
}
