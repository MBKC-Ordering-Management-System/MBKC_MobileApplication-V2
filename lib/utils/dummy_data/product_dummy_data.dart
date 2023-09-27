import 'package:faker/faker.dart';
import '../../models/product_model.dart';

class ProductDummyData {
  static final productsGenerate = List.generate(
    50,
    (index) => ProductModel(
      image: 'assets/images/product_${index + 1}.png',
      productId: index,
      code: faker.guid.random.toString().toUpperCase(),
      name: faker.food.cuisine(),
      description: faker.address.streetAddress(),
      sellingPrice: faker.randomGenerator.integer(120000, min: 10000),
      discountPrice: faker.randomGenerator.integer(20000, min: 5000),
      size: index % 2 == 0 ? 'S' : 'M',
      shopeeCode: faker.guid.random.toString().toUpperCase(),
      grabCode: faker.guid.random.toString().toUpperCase(),
      beaminCode: faker.guid.random.toString().toUpperCase(),
      category: faker.food.dish(),
      childs: List.generate(
        index % 2 == 0 ? 4 : 6,
        (index) => ProductModel(
          image: '',
          productId: index + 1,
          code: faker.guid.random.toString().toUpperCase(),
          name: faker.food.cuisine(),
          description: faker.address.citySuffix(),
          sellingPrice: faker.randomGenerator.integer(120000, min: 10000),
          discountPrice: faker.randomGenerator.integer(20000, min: 5000),
          size: index % 2 == 0 ? 'S' : 'M',
          shopeeCode: faker.guid.random.toString().toUpperCase(),
          grabCode: faker.guid.random.toString().toUpperCase(),
          beaminCode: faker.guid.random.toString().toUpperCase(),
          category: faker.food.dish(),
          childs: [],
        ),
      ),
    ),
  );
}
