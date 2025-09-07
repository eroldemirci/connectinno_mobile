enum EndPoints {notes}

extension EndPointsExtension on EndPoints {
  String getString({String? additionalData}) {
    late String path;
    switch (this) {
      case EndPoints.notes:
        path = 'notes/${additionalData ?? ''}';
        break;
    }
    return path;
  }
}
