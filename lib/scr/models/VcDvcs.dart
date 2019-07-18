class VcDvcs{
  final String id;
  final String value;
  final Map<String, dynamic> json;
  VcDvcs({id,value}):
    json={},
    this.id=id??'',
    this.value=value??'';

  VcDvcs.fromJson(Map<String, dynamic> json):
    json=json,
    id=json["id"],
    value=json["value"];
}