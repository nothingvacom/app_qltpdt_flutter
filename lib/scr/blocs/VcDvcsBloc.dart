import 'package:app_qltpdt_flutter/scr/resources/VcDvcs/VcDvcsRepository.dart';
import 'package:app_qltpdt_flutter/scr/resources/VcDvcs/VcDvcsResponse.dart';
import 'package:rxdart/rxdart.dart';

class VcDvcsBloc{
  final VcDvcsRepository _repository=VcDvcsRepository();
  final BehaviorSubject<VcDvcsResponse> _subject = BehaviorSubject<VcDvcsResponse>();

  getAllDvcs(String baseUrl) async {
    VcDvcsResponse response = await _repository.getAllDvcs(baseUrl);
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<VcDvcsResponse> get subject => _subject;
}

//final vcDvcsBloc = VcDvcsBloc();
