import 'package:app04/utilities/consts.dart';
import 'package:flutter/material.dart';

import '../../models/search_filter_model.dart';

class FilterWidget extends StatefulWidget {
  final Function submitFilter;

  const FilterWidget(this.submitFilter, {Key? key}) : super(key: key);

  @override
  State<FilterWidget> createState() => _FilterWidgetState();

}

class _FilterWidgetState extends State<FilterWidget> {
  RangeValues _imdbRangeValues = const RangeValues(0.0, 10);
  RangeValues _malRangeValues = const RangeValues(0.0, 10);
  late RangeValues yearRangeValues = RangeValues(1980, 2023);
  bool censored = false;
  bool dubbed = false;
  bool subTitle = false;
  String imdbRate = '0  -  10';
  String malRate = '0  -  10';
  String yearRate = '1980  -  2022';
  List<bool> types = List.generate(4, (index) => true);
  late SearchFilter _searchFilter;

  @override
  void initState() {
    yearRangeValues = RangeValues(1980, DateTime.now().year.toDouble());
    super.initState();
  }

  void initFilter() {
    String type = '';
    List<String> list = [];
    if (types[0]) list.add('movie');
    if (types[1]) list.add('serial');
    if (types[2]) list.add('anime_movie');
    if (types[3]) list.add('anime_serial');
    for (var i in list) {
      type += '$i-';
    }

    type = type.replaceRange(type.length - 1, null, '');
    _searchFilter = SearchFilter(
        types: type,
        imdbScores:
        '${_imdbRangeValues.start.toStringAsFixed(1)}-${_imdbRangeValues.end.toStringAsFixed(1)}',
        malScores: '${_malRangeValues.start.toStringAsFixed(1)}-${_malRangeValues.end.toStringAsFixed(1)}',
        years: '${yearRangeValues.start.toStringAsFixed(0)}-${yearRangeValues.end.toStringAsFixed(0)}');
  }

  @override
  Widget build(BuildContext context) {

    return Stack(children: [
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 0, 7),
              child: Text('Type :', style: Theme.of(context).textTheme.bodyMedium),
            ),
            SizedBox(
              height: 25,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    value: types[0],
                    onChanged: (value) => setState(() => types[0] = value!),
                    activeColor: active,
                  ),
                   Text(
                    'Movie', style: Theme.of(context).textTheme.bodyMedium
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    value: types[1],
                    onChanged: (value) => setState(() => types[1] = value!),
                    activeColor: active,
                  ),
                  Text(
                    'Serial', style: Theme.of(context).textTheme.bodyMedium
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    value: types[2],
                    onChanged: (value) => setState(() => types[2] = value!),
                    activeColor: active,
                  ),
                   Text(
                    'Anime Movie', style: Theme.of(context).textTheme.bodyMedium
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    value: types[3],
                    onChanged: (value) => setState(() => types[3] = value!),
                    activeColor: active,
                  ),
                   Text(
                    'Anime Serial', style: Theme.of(context).textTheme.bodyMedium
                  ),
                ],
              ),
            ),
            Row(
              children: [
                 Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: Text('IMDB Rate :   $imdbRate', style: Theme.of(context).textTheme.bodyMedium),
                ),
              ],
            ),
            RangeSlider(
              values: _imdbRangeValues,
              max: 10,
              divisions: 100,
              labels: RangeLabels(
                _imdbRangeValues.start.toStringAsFixed(1),
                _imdbRangeValues.end.toStringAsFixed(1),
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  _imdbRangeValues = values;
                  imdbRate =
                  '${_imdbRangeValues.start.toStringAsFixed(
                      1)}  -  ${_imdbRangeValues.end.toStringAsFixed(1)}';
                });
              },
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: Text('Anime Rate :   $malRate', style: Theme.of(context).textTheme.bodyMedium),
                ),
              ],
            ),
            RangeSlider(
              values: _malRangeValues,
              max: 10,
              divisions: 100,
              labels: RangeLabels(
                _malRangeValues.start.toStringAsFixed(1),
                _malRangeValues.end.toStringAsFixed(1),
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  _malRangeValues = values;
                  malRate =
                  '${_malRangeValues.start.toStringAsFixed(
                      1)}  -  ${_malRangeValues.end.toStringAsFixed(1)}';
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(children: [
                  SizedBox(
                    width: 20,
                    child: Checkbox(
                      value: censored,
                      onChanged: (value) => setState(() => censored = value!),
                      activeColor: active,
                    ),
                  ),
                  Text('Censored', style: Theme.of(context).textTheme.bodyMedium),
                ],),
                Row(children: [
                  SizedBox(
                    width: 20,
                    child: Checkbox(
                      value: dubbed,
                      onChanged: (value) => setState(() => dubbed = value!),
                      activeColor: active,
                    ),
                  ),
                  Text('Dubbed', style: Theme.of(context).textTheme.bodyMedium),
                ],),
               Row(children: [
                 SizedBox(
                   width: 20,
                   child: Checkbox(
                     value: subTitle,
                     onChanged: (value) => setState(() => subTitle = value!),
                     activeColor: active,
                   ),
                 ),
                 Text('Subtitle', style: Theme.of(context).textTheme.bodyMedium),
               ],),

              ],
            ),
            Row(
              children: [

              ],
            ),

            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: Text('Year :   $yearRate', style: Theme.of(context).textTheme.bodyMedium),
                ),
              ],
            ),
            RangeSlider(
              min: 1980,
              max: 2022,
              values: yearRangeValues,
              labels: RangeLabels(
                yearRangeValues.start.toString(),
                yearRangeValues.end.toString(),
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  yearRangeValues = values;
                  yearRate =
                  '${yearRangeValues.start.toStringAsFixed(0)}  -  ${yearRangeValues.end.toStringAsFixed(0)}';
                });
              },
            ),
          ],
        ),
      ),
      Positioned(
        right: -0.1,
        top: -0.1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: InkWell(
            onTap: () {
              initFilter();
              widget.submitFilter(_searchFilter);
              Navigator.of(context).pop();
            },
            child: Container(
              color: Colors.red,
              child: const Icon(Icons.close, color: Colors.white, size: 20),
            ),
          ),
        ),
      ),
    ]);
  }
}
