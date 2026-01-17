import 'dart:ui';

import 'package:finance_repository/finance_repository.dart';

class CategoriesMapper {
  String emojiByCategory(CostCategory category) {
    switch (category) {
      case CostCategory.groceries:
        return '🛒';
      case CostCategory.shopping:
        return '🛍️';
      case CostCategory.transportation:
        return '🚗';
      case CostCategory.other:
        return '📦';
    }
  }

  String labelByCategory(CostCategory category) {
    switch (category) {
      case CostCategory.groceries:
        return 'Mercado';
      case CostCategory.shopping:
        return 'Compras';
      case CostCategory.transportation:
        return 'Transporte';
      case CostCategory.other:
        return 'Outros';
    }
  }
}
