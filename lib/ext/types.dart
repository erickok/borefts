// Cast to desired type, being lenient to incorrect json specs
T cst<T>(dynamic x, {T fallback}) {
  try {
    if (T == bool) {
      if (x is bool) {
        return x as T;
      } else if (x is String && x == "true") {
        return true as T;
      } else {
        return false as T;
      }
    } else if (T == double) {
      if (x is int) {
        return x.toDouble() as T;
      } else {
        return x as T;
      }
    } else if (T == String) {
      return x.toString() as T;
    } else if (T == int) {
      if (x is String && x == "") {
        return null;
      } else {
        return x as T;
      }
    } else {
      return x as T;
    }
  } on CastError catch (e) {
    print('CastError casting $x to $T: ' + e.toString());
    return fallback;
  }
}
