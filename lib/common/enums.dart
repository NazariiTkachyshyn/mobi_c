enum SearchType { textField, folder }

extension SearchTypeX on SearchType {
  bool get isTextField => this == SearchType.textField;
  bool get isFolder => this == SearchType.folder;
}
