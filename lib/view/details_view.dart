import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weather_app/constant.dart';
import 'package:weather_app/view/home_view.dart';
import 'package:weather_app/viewModel/home_view_model.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<HomeViewModel>();
    final read = context.read<HomeViewModel>();
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    var sizedBox = SizedBox(
      height: 10,
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: listTileColor,
        appBar: AppBar(
          title: Text('Details'),
        ),
        body: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const DataLabelWidget(
                label: 'Location',
              ),
              DetailDataWidget(
                dataKey: 'City',
                value: watch.weatherData.city!.name!,
              ),
              DetailDataWidget(
                dataKey: 'Country',
                value: watch.weatherData.city!.country!,
              ),
              DetailDataWidget(
                dataKey: 'Population',
                value: watch.weatherData.city!.population!.toString(),
              ),
              DetailDataWidget(
                dataKey: 'Sunrise',
                value: read.timeFormat(
                    DateTime.parse(watch.weatherData.city!.sunrise.toString())),
              ),
              DetailDataWidget(
                dataKey: 'Sunset',
                value: read.timeFormat(
                    DateTime.parse(watch.weatherData.city!.sunset.toString())),
              ),
              const DataLabelWidget(
                label: 'Weather',
              ),
              sizedBox,
              DetailDataWidget(
                dataKey: 'Main',
                value: watch.nextDays[0].weather![0].main!,
              ),
              DetailDataWidget(
                dataKey: 'Description',
                value: watch.nextDays[0].weather![0].description!,
              ),
              DetailDataWidget(
                dataKey: 'Description',
                value: watch.nextDays[0].weather![0].description!,
              ),
              const DataLabelWidget(
                label: 'Main Details',
              ),
              sizedBox,
              DetailDataWidget(
                dataKey: 'Temp',
                value: read.fahrenheitToCelsius(double.parse(watch.nextDays[0].main!.temp!)) +
                    '°C',
              ),
              DetailDataWidget(
                dataKey: 'Temp min',
                value: watch.nextDays[0].main!.tempMin!,
              ),
              DetailDataWidget(
                dataKey: 'Temp max',
                value: watch.nextDays[0].main!.tempMax! ,
              ),
              DetailDataWidget(
                dataKey: 'Pressure',
                value: watch.nextDays[0].main!.pressure!,
              ),

               DetailDataWidget(
                dataKey: 'Sea level',
                value: watch.nextDays[0].main!.seaLevel!,
              ),
               DetailDataWidget(
                dataKey: 'Ground level',
                value: watch.nextDays[0].main!.grndLevel!,
              ),
              DetailDataWidget(
                dataKey: 'Humidity',
                value: watch.nextDays[0].main!.humidity!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DataLabelWidget extends StatelessWidget {
  const DataLabelWidget({
    Key? key,
    required this.label,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 30,
      color: Colors.grey,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: theme.textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}

class DetailDataWidget extends StatelessWidget {
  final String dataKey;
  final String value;

  const DetailDataWidget({Key? key, required this.dataKey, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              dataKey + "  :",
              textAlign: TextAlign.right,
              style: theme.textTheme.subtitle1?.copyWith(color: Colors.grey),
            ),
          ),
          const SizedBox(
            width: 100,
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.left,
              style: theme.textTheme.subtitle1,
            ),
          ),
        ],
      ),
    );
  }
}
