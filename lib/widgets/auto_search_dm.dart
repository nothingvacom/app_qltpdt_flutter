import 'package:app_qltpdt_flutter/scr/models/VcDm.dart';
import 'package:app_qltpdt_flutter/scr/resources/VcDm/VcDmRepository.dart';
import 'package:app_qltpdt_flutter/utils/vc_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'build_loading_widget.dart';

class AutoSearchDm extends TypeAheadFormField<VcDm>{
  final BuildContext context;
  final TextEditingController controller;
  final LstDm type;
  final Map<String,dynamic> paramRef;
  final SuggestionSelectionCallback<VcDm> onSuggestionSelected;
  final String labelText;
  final bool displayOnlyId;
  final bool displayOnlyValue;
  AutoSearchDm({Key key,@required this.context,@required this.controller,this.type,this.paramRef,this.onSuggestionSelected,
    this.labelText,this.displayOnlyId:false,this.displayOnlyValue:false}):
    super(
      loadingBuilder:(BuildContext context){
        return BuildLoadingWidget();
      },
      noItemsFoundBuilder:(BuildContext context){
        return SizedBox(height: 0.0,width: 0.0);
      },
      textFieldConfiguration: TextFieldConfiguration(
          controller: controller,
          decoration: new InputDecoration(labelText: labelText,
              labelStyle: VcConst.getStyleCaption(context),
              contentPadding: EdgeInsets.all(8.0),
              border: UnderlineInputBorder(),
              focusedBorder:UnderlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).textSelectionHandleColor),
              )
          )
      ),
      suggestionsCallback: (_textSearch) async {
        // Map<String,dynamic> _paramRef=paramRef;
        // _paramRef["filter_value"]=_textSearch;
        return (type!=null)?await VcDmRepository().getAllDm(_textSearch, type).then((onValue)=>onValue.results)
          :await VcDmRepository().getRefId(paramRef).then((onValue)=>onValue.results);
      },
      itemBuilder: (BuildContext context, suggestion) {
        return ListTile(
          title: Text("${displayOnlyValue?"":"${suggestion.ma}-"}${displayOnlyId?"":"${suggestion.ten}"}"),
        );
      },
      transitionBuilder: (context, suggestionsBox, controller) {
        return suggestionsBox;
      },
      onSuggestionSelected: (suggestion) {
        if (controller!=null) controller.text=(displayOnlyValue)?suggestion.ten:suggestion.ma;
        onSuggestionSelected(suggestion);
      },
    );
}
