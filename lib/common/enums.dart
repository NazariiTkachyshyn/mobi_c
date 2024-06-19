enum SearchType { textField, folder }

extension SearchTypeX on SearchType {
  bool get isTextField => this == SearchType.textField;
  bool get isFolder => this == SearchType.folder;
}

enum ViewType {
  listWithoutImages,
  listWithIcons,
  thumbnails,
}

extension ViewTypeX on ViewType {
  bool get isListWithoutImages => this == ViewType.listWithoutImages;
  bool get isListWithIcons => this == ViewType.listWithIcons;
  bool get isThumbnails => this == ViewType.thumbnails;
}
