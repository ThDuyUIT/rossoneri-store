import 'package:intl/intl.dart';

final String Function() dateCustomFormat = (){
  final DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm:ss');
  return formatter.format(DateTime.now());
};
