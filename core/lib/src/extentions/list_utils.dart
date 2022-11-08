typedef Predicate<E> = bool Function(E element);

extension ListExtension<E> on List<E> {
  /// Returns this List if it's not `null` and the empty list otherwise.
  List<E>? orEmpty() {
    return this;
  }

  /// Returns the last element matching the given [predicate], or `null` if no such element was found.
  E? find(Predicate<E> predicate) {
    E? result;
    for (E element in this) {
      if (predicate(element)) {
        result = element;
        break;
      }
    }
    return result;
  }
}
