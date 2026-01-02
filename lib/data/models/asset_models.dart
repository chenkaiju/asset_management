enum AssetType { cash, stock, fund, other }

abstract class Asset {
  final String id;
  final String name;
  final double amount;
  final AssetType type;
  final String institutionId; // Bank or Brokerage ID

  Asset({
    required this.id,
    required this.name,
    required this.amount,
    required this.type,
    required this.institutionId,
  });
}

class CashAsset extends Asset {
  final String currency;

  CashAsset({
    required super.id,
    required super.name,
    required super.amount,
    required super.institutionId,
    this.currency = 'TWD',
  }) : super(type: AssetType.cash);
}

class StockAsset extends Asset {
  final String symbol;
  final double shares;
  final double currentPrice;

  StockAsset({
    required super.id,
    required super.name,
    required this.symbol,
    required this.shares,
    required this.currentPrice,
    required super.institutionId,
  }) : super(amount: shares * currentPrice, type: AssetType.stock);
}

class Institution {
  final String id;
  final String name;
  final AssetType supportedType;

  Institution({
    required this.id,
    required this.name,
    required this.supportedType,
  });
}
