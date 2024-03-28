import 'package:announcement_of_services/components/text_widget.dart';
import 'package:announcement_of_services/utils/constant/font_size.dart';
import 'package:flutter/widgets.dart';

class WaitScreen extends StatelessWidget {
  const WaitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextWidget(
        title: 'رجاءًا أنتظر لحين موافقة الادمن على خدماتك',
        size: FontSize.subtitle(context),
      ),
    );
  }
}
