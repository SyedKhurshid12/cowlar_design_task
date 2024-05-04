import 'package:cached_network_image/cached_network_image.dart';
import 'package:cowlar_design_task/bloc/get_movie_trailer_bloc/get_movie_trailer_bloc.dart';
import 'package:cowlar_design_task/bloc/get_movie_trailer_bloc/get_movie_trailer_event.dart';
import 'package:cowlar_design_task/bloc/get_movie_trailer_bloc/get_movie_trailer_state.dart';
import 'package:cowlar_design_task/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:cowlar_design_task/bloc/movie_detail_bloc/movie_detail_event.dart';
import 'package:cowlar_design_task/bloc/movie_detail_bloc/movie_detail_state.dart';
import 'package:cowlar_design_task/config/colors.dart';
import 'package:cowlar_design_task/config/const_url.dart';
import 'package:cowlar_design_task/config/helper_function.dart';
import 'package:cowlar_design_task/models/movie_detail_model.dart';
import 'package:cowlar_design_task/provider/movie_player_provider.dart';
import 'package:cowlar_design_task/views/widgets/widget_function.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../widgets/custom_app_bar.dart';

class MovieDetailScreen extends StatefulWidget {
  final String imageUrl;
  final String movieId;

  const MovieDetailScreen(
      {super.key, required this.imageUrl, required this.movieId});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  MovieDetailBloc movieDetailBloc = MovieDetailBloc();
  GetMovieTrailerBloc getMovieTrailerBloc = GetMovieTrailerBloc();
  String? trailerId;

  @override
  void initState() {
    // TODO: implement initState
    movieDetailBloc.add(HitMovieDetail(movieId: widget.movieId));
    getMovieTrailerBloc.add(HitGetMovieTrailer(movieId: widget.movieId));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<MovieDetailBloc>(
              create: (BuildContext context) => movieDetailBloc),
          BlocProvider<GetMovieTrailerBloc>(
            create: (BuildContext context) => getMovieTrailerBloc,
          ),
        ],
        child: MultiBlocListener(
            listeners: [
              BlocListener<MovieDetailBloc, MovieDetailState>(
                listener: (context, state) {
                  if (state is MovieDetailError) {
                  } else if (state is MovieDetailLoaded) {}
                },
              ),
              BlocListener<GetMovieTrailerBloc, GetMovieTrailerState>(
                listener: (context, state) {
                  if (state is GetMovieTrailerError) {
                  } else if (state is GetMovieTrailerLoaded) {
                    trailerId =
                        state.movieTrailerModel.results?.last?.key ?? "";
                  }
                },
              ),
            ],
            child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
              builder: (context, state) {
                if (state is MovieDetailInitialState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MovieDetailLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MovieDetailLoaded) {
                  return buildScreen(context, state.movieDetailModel);
                } else {
                  return Container();
                }
              },
            )));
  }

  Widget buildScreen(BuildContext context, MovieDetailModel model) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(title: 'Details',showAction: true,),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.bottomLeft,
                  children: [
                    Container(
                      height: 300, // Adjust as needed
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(widget.imageUrl),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -70,
                      left: 30,
                      child: Container(
                        height: 150,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(widget.imageUrl),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: 15,
                      right: 10,
                      child: Container(

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: primaryColor,
                          ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.star_border_purple500_outlined,color: orange,),
                              addHorizontalSpace(5),
                              Text(model.popularity.toString() ?? "1",style: createCustomTextStyle(color: orange),)
                            ],
                          ),
                        ),
                        ),
                      ),

                  ],
                ),
                const SizedBox(height: 20), // Add some space between image and title
                Padding(
                  padding: const EdgeInsets.only(left: 80.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 250, // Adjust as needed
                    child: Text(
                      model.title ?? "unknown",
                      style: createCustomTextStyle(fontWeight: FontWeight.w500,fontSize: 18),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                addVerticalSpace(40),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.calendar_today,color: lightPrimary,),
                          addHorizontalSpace(5),
                          Text(
                            model.releaseDate.toString().substring(0, 4) ?? "1",
                            style: createCustomTextStyle(color: lightPrimary),
                          ),
                        ],
                      ),
                       VerticalDivider(
                        color: lightPrimary, // Set the color of the vertical divider
                        thickness: 1.0, // Set the thickness of the vertical divider
                      ),
                      Row(
                        children: [
                          Icon(Icons.access_alarms,color: lightPrimary,),
                          addHorizontalSpace(5),
                          Text(
                           " ${model.runtime.toString() + " Minutes" ?? "1"}",
                            style: createCustomTextStyle(color: lightPrimary),
                          ),
                        ],
                      ),

                      VerticalDivider(
                        color: lightPrimary, // Set the color of the vertical divider
                        thickness: 1.0, // Set the thickness of the vertical divider
                      ),
                      Row(
                        children: [
                          Icon(Icons.local_attraction,color: lightPrimary,),
                          addHorizontalSpace(5),
                          Text(
                           model.genres?.first?.name ?? "Action",
                            style: createCustomTextStyle(color: lightPrimary),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
                addVerticalSpace(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TabBar(
                      isScrollable: true,
                      indicatorColor: lightPrimary,
                      labelColor: primaryColor,
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      indicatorWeight: 2,

                      onTap: (index) {
                        if (kDebugMode) {
                          print(index.toString());
                        }
                      },

                      // Allows tabs to scroll horizontally
                      tabs: List.generate(2, (index) {
                        String title;
                        switch (index) {
                          case 0:
                            title = "About Movie";
                            break;
                          case 1:
                            title = "Trailer";
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
                  ],
                ),
                addVerticalSpace(20),

                Expanded(
                  child: TabBarView(
                      physics: const AlwaysScrollableScrollPhysics(),

                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text(model.overview ?? "unknown",style: createCustomTextStyle(),),
                        ),
              GestureDetector(
                onTap: () {
                  Provider.of<MoviePlayerProvider>(context,
                      listen: false)
                      .playMovieTrailer(context, trailerId!);

                },
                child: Container(
                  height: 140,
                  margin: const EdgeInsets.fromLTRB(18, 10, 18, 10),
                  decoration: const BoxDecoration(
                      borderRadius:
                      BorderRadius.all(Radius.circular(12.0))),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.20,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),

                          color: Color(0xfff5f5f5),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Image.network(
                            '$imageBaseUrl${model.posterPath}' ?? "",
                            fit: BoxFit.contain,
                            loadingBuilder: (_, child, progress) =>
                            progress == null ? child : Container(color: Colors.black),
                          ),
                        ),
                      ),

                      Container(
                        alignment: Alignment.center,
                        child:  Center(
                            child:Image.asset(
                              "assets/play.png",
                              height: 55,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
                      ]),
                )

              ],
            ),
          ),
        )
        ,
      ),
    );
  }
}
