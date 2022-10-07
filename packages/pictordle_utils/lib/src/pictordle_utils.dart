extension ReplaceExt<T> on List<T> {
  /// return a new list with the [oldElement] replaced
  /// with the [newElement]
  List<T> replace(T oldElement, T newElement) {
    final index = indexOf(oldElement);
    final result = [...this];
    result.remove(oldElement);
    result.insert(index, newElement);
    return result;
  }
}
