import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';
import 'package:weather_app/constant.dart';
import 'package:weather_app/service/api_service.dart';
import 'package:weather_app/view/details_view.dart';
import 'package:weather_app/viewModel/home_view_model.dart';
import 'package:weather_app/widgets/weather_list_tile_widget.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  TextEditingController text = TextEditingController();
  final imgUrl =
      'https://images.unsplash.com/photo-1513002749550-c59d786b8e6c?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final watch = context.watch<HomeViewModel>();
    final read = context.read<HomeViewModel>();
    return Scaffold(
      floatingActionButton: watch.searchBtn
          ? FloatingActionButton(
              child: const Icon(Icons.search),
              onPressed: () {
                read.updateSearchBtn(false);
                ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
                    content: TextField(
                      controller: text,
                      decoration: const InputDecoration(
                        hintText: 'Enter City name',
                      ),
                    ),
                    actions: [
                      TextButton(
                          child: const Text(
                            'Search',
                          ),
                          onPressed: () {
                            read.updateSearchBtn(true);
                            ScaffoldMessenger.of(context)
                                .hideCurrentMaterialBanner();
                            read.fetchWeather(text.text);
                          }),
                    ]));
              })
          : null,
      body: Stack(
        children: [
          TopViewSection(theme: theme, imgUrl: imgUrl),
          ListViewSection(size: size)
        ],
      ),
      // bottomSheet:
    );
  }
}

class ListViewSection extends StatelessWidget {
  const ListViewSection({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<HomeViewModel>();
    final read = context.read<HomeViewModel>();

    return Positioned(
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.only(
          top: 30,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (watch.loading)
              const Center(
                child: CircularProgressIndicator(),
              ),
            if (watch.nextDays.isNotEmpty)
              Expanded(
                child: ListView.builder(
                    itemCount: watch.nextDays.length,
                    itemBuilder: (context, index) {
                      var list = watch.nextDays[index];
                      return WeatherListTileWidget(
                        day: read.dayFormat(DateTime.parse(list.dtTxt!)),
                        date: read.dateFormat(DateTime.parse(list.dtTxt!)),
                        temp: read.fahrenheitToCelsius(
                            double.parse(list.main!.temp!)),
                      );
                    }),
              ),
          ],
        ),
        height: size.height * .6,
        width: size.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
      ),
    );
  }
}

class TopViewSection extends StatelessWidget {
  const TopViewSection({
    Key? key,
    required this.theme,
    required this.imgUrl,
  }) : super(key: key);

  final ThemeData theme;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<HomeViewModel>();
    return Container(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text(
                  watch.todayDate,
                  style: theme.textTheme.headline6?.copyWith(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  watch.city,
                  style: theme.textTheme.subtitle1?.copyWith(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    cloud,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Wrap(
                    children: [
                      Text(
                        watch.temp.toString(),
                        style: theme.textTheme.headline4
                            ?.copyWith(color: Colors.white),
                      ),
                      Text(
                        '°C',
                        style: theme.textTheme.subtitle1?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFeatures: const [FontFeature.superscripts()],
                        ),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                watch.des,
                style: theme.textTheme.headline6?.copyWith(
                    color: Colors.white, fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 20,
              ),
              OutlinedButton.icon(
                icon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'See Details',
                    style: theme.textTheme.subtitle1
                        ?.copyWith(color: Colors.white),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => DetailsView()));
                },
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  side: const BorderSide(
                    width: 2.0,
                    color: Colors.white,
                  ),
                ),
                label: const Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            bg,
          ),
        )));
  }
}
