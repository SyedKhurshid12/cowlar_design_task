import 'package:cached_network_image/cached_network_image.dart';
import 'package:cowlar_design_task/bloc/upcoming_movie_bloc/upcoming_movie_bloc.dart';
import 'package:cowlar_design_task/bloc/upcoming_movie_bloc/upcoming_movie_event.dart';
import 'package:cowlar_design_task/bloc/upcoming_movie_bloc/upcoming_movie_state.dart';
import 'package:cowlar_design_task/config/colors.dart';
import 'package:cowlar_design_task/config/const_url.dart';
import 'package:cowlar_design_task/config/helper_function.dart';
import 'package:cowlar_design_task/models/upcoming_movie_model.dart';
import 'package:cowlar_design_task/views/widgets/widget_function.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/search_widget.dart';
import 'movie_detail_screen.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  UpcomingMovieBloc upcomingMovieBloc = UpcomingMovieBloc();
  UpcomingMovieModel? upcomingMovieModel;

  @override
  void initState() {
    // TODO: implement initState
    upcomingMovieBloc.add(GetUpcomingMovieList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: BlocProvider(
            create: (_) => upcomingMovieBloc,
            child: BlocListener<UpcomingMovieBloc, UpcomingMovieState>(
                listener: (context, state) {
              if (state is UpcomingMovieError) {
              } else if (state is UpcomingMovieLoaded) {}
            }, child: BlocBuilder<UpcomingMovieBloc, UpcomingMovieState>(
              builder: (context, state) {
                if (state is UpcomingMovieInitial) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: whiteColor,
                    ),
                  );
                } else if (state is UpcomingMovieLoaded) {
                  upcomingMovieModel = state.upcomingMovieModel;

                  return _buildMovieList(context, state.upcomingMovieModel);
                } else {
                  return Container();
                }
              },
            ))),
      ),
    );
  }

  Widget _buildMovieList(BuildContext context, UpcomingMovieModel model) {
    return SizedBox(
      height: double.infinity,
      // Set the height of your outer container as needed
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addVerticalSpace(
              30,
            ),
            Text(
              "What do you want to watch?",
              style: createCustomTextStyle(
                  fontSize: 18, fontWeight: FontWeight.w500),
            ),
            addVerticalSpace(
              20,
            ),
            CustomSearchBar(
              hintText: "Search",
            ),
            addVerticalSpace(
              15,
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: model.results?.length ?? 0,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  final imageUrl = model.results?[index]?.posterPath ?? "";

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieDetailScreen(
                              imageUrl: "$imageBaseUrl$imageUrl",
                              movieId:
                                  model.results?[index]?.id.toString() ?? "",
                            ),
                          ),
                        );
                      },
                      child: SizedBox(
                        height: 100,
                        width: 200,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 120,
                            width: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                    "$imageBaseUrl$imageUrl"),
                                colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.5),
                                  BlendMode.overlay,
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            addVerticalSpace(20),
            TabBar(
              isScrollable: true,
              indicatorColor: lightPrimary,
              labelColor: primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 6),
              indicatorWeight: 4,

              onTap: (index) {
                if (kDebugMode) {
                  print(index.toString());
                }
              },

              // Allows tabs to scroll horizontally
              tabs: List.generate(4, (index) {
                String title;
                switch (index) {
                  case 0:
                    title = "Now playing";
                    break;
                  case 1:
                    title = "Upcoming";
                    break;
                  case 2:
                    title = "Top rated";
                    break;
                  case 3:
                    title = "Popular";
                    break;
                  default:
                    title = "Unknown";
                }
                return Tab(
                  child: Text(
                    title,
                    style: createCustomTextStyle(
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              }),
            ),
            Expanded(
              child: TabBarView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: List<Widget>.generate(4, (int index) {
                    return SingleChildScrollView(
                      child: GridView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        // Use ClampingScrollPhysics to disable overscroll effect

                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 1.4),
                          mainAxisSpacing: 5.0,
                          crossAxisSpacing: 10.0,
                        ),
                        itemCount: model.results?.length ?? 0,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          final imageUrl =
                              model.results?[index]?.posterPath ?? "";

                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MovieDetailScreen(
                                    imageUrl: "$imageBaseUrl$imageUrl",
                                    movieId:
                                        model.results?[index]?.id.toString() ??
                                            "",
                                  ),
                                ),
                              );
                            },
                            child: SizedBox(
                              height: 100,
                              width: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                          "$imageBaseUrl$imageUrl"),
                                      colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.5),
                                        BlendMode.overlay,
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  })),
            )
          ],
        ),
      ),
    );
  }
}
