import 'package:mobi_c/services/data_bases/object_box/models/models.dart';

class CounterpartyTree {
  final String refKey;
  final String description;
  final String mainCounterpartyKey;
  final String partnerKey;
  final String fullDescription;
  final String searchField;
  final String parentKey;
  final bool isFolder;
  final List<String> path;

  List<CounterpartyTree> children;

  CounterpartyTree({
    required this.refKey,
    required this.description,
    required this.mainCounterpartyKey,
    required this.partnerKey,
    required this.fullDescription,
    required this.searchField,
    required this.parentKey,
    required this.children,
    required this.isFolder,
    this.path = const [],
  });

  void addChild(CounterpartyTree child) {
    children.add(child);
  }

  factory CounterpartyTree.fromCounterparty(Counterparty counterparty) =>
      CounterpartyTree(
          refKey: counterparty.refKey,
          description: counterparty.description,
          mainCounterpartyKey: counterparty.mainCounterpartyKey,
          partnerKey: counterparty.partnerKey,
          fullDescription: counterparty.fullDescription,
          searchField: (counterparty.description + counterparty.fullDescription)
              .toLowerCase(),
          parentKey: counterparty.parentKey,
          isFolder: counterparty.isFolder,
          children: [],
          path: []);

  CounterpartyTree copyWith({
    String? refKey,
    String? description,
    String? mainCounterpartyKey,
    String? partnerKey,
    String? fullDescription,
    String? searchField,
    String? parentKey,
    bool? isFolder,
    List<String>? path,
    List<CounterpartyTree>? children,
  }) =>
      CounterpartyTree(
        refKey: refKey ?? this.refKey,
        description: description ?? this.description,
        mainCounterpartyKey: mainCounterpartyKey ?? this.mainCounterpartyKey,
        partnerKey: partnerKey ?? this.partnerKey,
        fullDescription: fullDescription ?? this.fullDescription,
        searchField: searchField ?? this.searchField,
        parentKey: parentKey ?? this.parentKey,
        isFolder: isFolder ?? this.isFolder,
        path: path ?? this.path,
        children: children ?? this.children,
      );
}
