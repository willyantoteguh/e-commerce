import 'package:core/local/database/database_module.dart';

abstract class ProductLocalDataSource {
  const ProductLocalDataSource();

  Future<bool> saveProduct(ProductDetailTableCompanion data);

  Future<bool> deleteProduct(String productUrl);

  Future<ProductDetailTableData> getFavoriteProductByUrl(String productUrl);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final AppDatabase database;

  const ProductLocalDataSourceImpl({required this.database});

  @override
  Future<bool> saveProduct(ProductDetailTableCompanion data) async {
    try {
      await database.productDao.saveProduct(data);
      return true;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<bool> deleteProduct(String productUrl) async {
    try {
      await database.productDao.deleteProduct(productUrl);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProductDetailTableData> getFavoriteProductByUrl(String productUrl) async {
    try {
      return await database.productDao.getFavoriteProductByUrl(productUrl);
    } catch (e) {
      rethrow;
    }
  }
}
