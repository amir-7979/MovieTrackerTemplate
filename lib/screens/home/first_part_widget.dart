import 'package:app04/utilities/http_helper.dart';
import 'package:app04/screens/helper_widgets/show-part-widget.dart';
import 'package:flutter/material.dart';
import '../../models/multiple_model.dart';
import '../../utilities/consts.dart';
import '../helper_widgets/title_button_widget.dart';
import '../more/more_screen.dart';

class FirstPartWidget extends StatelessWidget {
  const FirstPartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
          future: getFirstPartItems(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return multipleParts(context, snapshot.data);
            } else {
              return SizedBox(
                height: screenHeight,
              );
            }
          }
    );
  }


  Widget multipleParts(BuildContext context, Multiple multiple) {
    var color = Theme.of(context).accentColor;
    return Column(
        children: [
          titleButtonWidget(
              "News",
              () => Navigator.of(context)
                  .pushNamed(MoreScreen.routeName, arguments: "news"),
              color),
          showPartWidget(multiple.news),
          titleButtonWidget(
              "Updates",
              () => Navigator.of(context)
                  .pushNamed(MoreScreen.routeName, arguments: "updates"),
              color),
          showPartWidget(multiple.update),
          titleButtonWidget("In Theater", () {}, color),
          showPartWidget(multiple.inTheaters),
          titleButtonWidget("ComingSoon", () {}, color),
          showPartWidget(multiple.comingSoon),
        ],
    );
  }
}
