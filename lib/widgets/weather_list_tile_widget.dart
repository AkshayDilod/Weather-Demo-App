import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:weather_app/constant.dart';

class WeatherListTileWidget extends StatelessWidget {
  final String day;
  final String date;
  final String temp;

  const WeatherListTileWidget({
    Key? key,
    required this.day,
    required this.date,
    required this.temp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 20,
        right: 20,
        left: 20,
      ),
      child: Column(
        children: [
          Container(
            height: 80,
            padding: EdgeInsets.all(15),
            width: size.width * 7,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        day,
                        style: theme.textTheme.subtitle1?.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        date,
                        style: theme.textTheme.bodyText1?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      )
                    ],
                  ),
                ),
                Icon(
                  Icons.cloud,
                  color: Colors.blueGrey[700],
                ),
                const SizedBox(
                  width: 10,
                ),
                Wrap(
                  children: [
                    Text(
                      temp,
                      style: theme.textTheme.subtitle1?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '°C',
                      style: theme.textTheme.caption?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontFeatures: [const FontFeature.superscripts()]),
                    ),
                  ],
                ),
                const Icon(
                  Icons.arrow_right_rounded,
                  size: 30,
                )
              ],
            ),
            decoration: BoxDecoration(
              color: listTileColor,
              borderRadius: BorderRadius.circular(15),
            ),
          )
        ],
      ),
    );
  }
}
