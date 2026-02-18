import 'package:meta/meta.dart';

import 'repository_base.dart';

abstract class ListRepositoryBase<T> extends RepositoryBase<List<T>> {
  ListRepositoryBase() : super(initialValue: []);

  @protected
  void replaceItem(T item) {
    final updatedData = [...data];
    final index = updatedData.indexWhere((element) => equals(element, item));

    if (index != -1) {
      updatedData[index] = item;
      emit(updatedData);
    }
  }

  bool equals(T item1, T item2);
}
