import 'VcRow.dart';

class VcReport extends VcRow{
  final Map<String, dynamic> json;
  final String textSearch;
  VcReport.fromJson(Map<String, dynamic> json):
    this.json=json,
    this.textSearch=VcRow.catDau(json.toString()),super(json);
}
