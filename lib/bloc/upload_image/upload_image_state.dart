import 'package:equatable/equatable.dart';

abstract class UploadImageState extends Equatable {}

class UploadImageInitialState extends UploadImageState {
  @override
  List<Object> get props => <Object>[];
}

class UploadImageLoadingState extends UploadImageState {
  @override
  List<Object> get props => <Object>[];
}

class UploadImageSuccessState extends UploadImageState {
  UploadImageSuccessState({required this.imageUrl});
  final String imageUrl;
  @override
  List<Object> get props => <Object>[];
}

class UploadImageFailedState extends UploadImageState {
  UploadImageFailedState({required this.error});
  final String error;
  @override
  List<Object> get props => <Object>[];
}
