import 'package:meta/meta.dart';

import 'repository_base.dart';

abstract class ListRepositoryBase<T> extends RepositoryBase<List<T>> {
  ListRepositoryBase() : super(initialValue: []);

  /// If [item] exists in the list, it will be updated
  /// otherwise it will be added to the end of the list.
  @protected
  T emitItem(T item) {
    final updatedData = [...data];
    final index = updatedData.indexWhere((element) => equals(element, item));

    if (index != -1) {
      updatedData[index] = item;
    } else {
      updatedData.add(item);
    }

    emit(updatedData);

    return item;
  }

  bool equals(T item1, T item2);
}
