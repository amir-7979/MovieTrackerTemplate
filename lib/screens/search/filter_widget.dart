import 'package:app04/utilities/consts.dart';
import 'package:flutter/material.dart';
import '../../models/search_filter_model.dart';

class FilterWidget extends StatefulWidget {
  final Function submitFilter;
  FilterType filterType;
  FilterWidget(this.submitFilter, this.filterType, {Key? key}) : super(key: key);

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  RangeValues _imdbRangeValues = const RangeValues(0.0, 10);
  RangeValues _malRangeValues = const RangeValues(0.0, 10);
  late RangeValues yearRangeValues = const RangeValues(1980, 2023);
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

  SearchFilter initFilter() {
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
      type,
      '${yearRangeValues.start.toStringAsFixed(0)}-${yearRangeValues.end.toStringAsFixed(0)}',
      '${_imdbRangeValues.start.toStringAsFixed(1)}-${_imdbRangeValues.end.toStringAsFixed(1)}',
      '${_malRangeValues.start.toStringAsFixed(1)}-${_malRangeValues.end.toStringAsFixed(1)}',
    );
    _searchFilter.filterType = widget.filterType;
    return _searchFilter;
  }

  ValueChanged<FilterType?> _handleRadioValueChange() {
    return (value) => setState(() => widget.filterType = value!);
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                'Filter',
                style: TextStyle(fontSize: 20),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                widget.submitFilter(initFilter());
                Navigator.pop(context);
              },
              child: const Icon(Icons.check),
              style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  elevation: 5,
                  primary: Colors.green),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Radio(
                    value: FilterType.film,
                    groupValue: widget.filterType,
                    onChanged: _handleRadioValueChange(),

                  ),
                  Text('film'),
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: FilterType.staff,
                    groupValue: widget.filterType,
                    onChanged: _handleRadioValueChange(),

                  ),
                  Text('staff'),

                ],
              ),
              Row(
                children: [
                  Radio(
                    value: FilterType.character,
                    groupValue: widget.filterType,
                    onChanged: _handleRadioValueChange(),
                  ),
                  Text('character'),
                ],
              ),
            ],),
        ),
        SizedBox(
          height: 300,
          child: (widget.filterType == FilterType.film) ? filmFilter() : (widget.filterType == FilterType.staff) ? staffFilter() : characterFilter(),
        ),
      ],
    );
  }

  Widget filmFilter(){
    return ListView(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 0, 10),
        child: Text('Type', style: Theme.of(context).textTheme.bodyMedium),
      ),
      Row(
        children: [
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
                Text('Movie', style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
          const SizedBox(
            width: 17,
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
                Text('Anime Movie',
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 10),
      Row(
        children: [
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
                Text('Serial', style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
          const SizedBox(
            width: 20,
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
                Text('Anime Serial',
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 10),
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
            child: Text('IMDB Rate :   $imdbRate',
                style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
      RangeSlider(
        values: _imdbRangeValues,
        max: 10,
        divisions: 100,
        activeColor: Colors.blueAccent,
        inactiveColor: Colors.grey,
        labels: RangeLabels(
          _imdbRangeValues.start.toStringAsFixed(1),
          _imdbRangeValues.end.toStringAsFixed(1),
        ),
        onChanged: (RangeValues values) {
          setState(() {
            _imdbRangeValues = values;
            imdbRate =
            '${_imdbRangeValues.start.toStringAsFixed(1)}  -  ${_imdbRangeValues.end.toStringAsFixed(1)}';
          });
        },
      ),
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
            child: Text('Anime Rate :   $malRate',
                style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
      RangeSlider(
        values: _malRangeValues,
        max: 10,
        divisions: 100,
        activeColor: Colors.blueAccent,
        inactiveColor: Colors.grey,
        labels: RangeLabels(
          _malRangeValues.start.toStringAsFixed(1),
          _malRangeValues.end.toStringAsFixed(1),
        ),
        onChanged: (RangeValues values) {
          setState(() {
            _malRangeValues = values;
            malRate =
            '${_malRangeValues.start.toStringAsFixed(1)}  -  ${_malRangeValues.end.toStringAsFixed(1)}';
          });
        },
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              SizedBox(
                width: 20,
                child: Checkbox(
                  value: censored,
                  onChanged: (value) => setState(() => censored = value!),
                  activeColor: active,
                ),
              ),
              const SizedBox(width: 5),
              Text('Censored', style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 20,
                child: Checkbox(
                  value: dubbed,
                  onChanged: (value) => setState(() => dubbed = value!),
                  activeColor: active,
                ),
              ),
              const SizedBox(width: 5),
              Text('Dubbed', style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 20,
                child: Checkbox(
                  value: subTitle,
                  onChanged: (value) => setState(() => subTitle = value!),
                  activeColor: active,
                ),
              ),
              const SizedBox(width: 5),
              Text('Subtitle', style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ],
      ),
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
            child: Text('Year :   $yearRate',
                style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
      RangeSlider(
        min: 1980,
        max: 2022,
        values: yearRangeValues,
        activeColor: Colors.blueAccent,
        inactiveColor: Colors.grey,
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
    ],);
  }

  Widget staffFilter(){
    return SizedBox();
  }

  Widget characterFilter(){
    return SizedBox();
  }

}
