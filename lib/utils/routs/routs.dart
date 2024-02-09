import 'package:contact_app/screen/adddata/adddata_screen.dart';
import 'package:flutter/cupertino.dart';

import '../../screen/detail/detail_screen.dart';
import '../../screen/home/home_screen.dart';

Map<String,WidgetBuilder>app_routes=
{
    "/":(context) => HomeScreen(),
   "detail":(context) => DetailScreen(),
   "add":(context) => AdddataScreen(),
};