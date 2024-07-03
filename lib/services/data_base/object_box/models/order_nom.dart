import 'package:mobi_c/repository/config_repo/config_repo.dart';
import 'package:mobi_c/services/data_base/object_box/models/nom.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class OrderNom {
  @Id()
  int id;
  int orderId;
  String ref;
  String description;
  String article;
  String imageKey;
  String unitKey;
  int qty;
  double price;
  int ratio;
  String unitName;

  OrderNom(
      {this.id = 0,
      required this.orderId,
      required this.ref,
      required this.description,
      required this.article,
      required this.imageKey,
      required this.unitKey,
      required this.qty,
      required this.price,
      required this.ratio,
      required this.unitName});

  factory OrderNom.fromNom(Nom nom) => OrderNom(
      ref: nom.ref,
      article: nom.article,
      description: nom.description,
      imageKey: nom.imageKey,
      unitKey: nom.unitKey,
      orderId: 0,
      qty: 0,
      price: 0,
      ratio: 1,
      unitName: '');

  Map<String, dynamic> toJson(int number, String storageKey, double discount) =>
      {
        'LineNumber': number,
        'Номенклатура_Key': ref,
        'Склад_Key': Config.storageKey,
        'КоличествоУпаковок': qty,
        "ЕдиницаИзмерения_Key": unitKey,
        'Количество': qty,
        'Цена': price,
        "Коэффициент": 1,
        'СтавкаНДС': 'НДС20',
        "ПроцентАвтоматическихСкидок": discount,
        "УсловиеАвтоматическойСкидки": "ПоКоличествуТовара",
        "ЗначениеУсловияАвтоматическойСкидки": "0",
        "ЗначениеУсловияАвтоматическойСкидки_Type": "Edm.Double",
        'ТипЦен_Key': Config.priceType,
        'ВариантОбеспечения': 'Отгрузить',
      };
}
