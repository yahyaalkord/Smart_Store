

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:smart_store/database/controllers/cart_db_controller.dart';

import '../models/cart.dart';
import '../models/process_responcse.dart';

class CartGetxController extends GetxController {
  RxList<Cart> cartItems = <Cart>[].obs;
  RxBool loading = false.obs;

  static CartGetxController get to => Get.find<CartGetxController>();

  @override
  void onInit() {
    read();
    super.onInit();
  } // List<Product> products = <Product>[];

  final CartDbController _dbController = CartDbController();
  // final ProductsDbController _productDbController = ProductsDbController();

  double total = 0;
  double quantity = 0;

  Future<ProcessResponse> create(Cart cart) async {
    int index =
    cartItems.indexWhere((element) => element.productId == cart.productId);
    if (index == -1) {
      int newRowId = await _dbController.create(cart);
      if (newRowId != 0) {
        total += cart.total;
        quantity += 1;
        cart.id = newRowId;
        cartItems.add(cart);
      }
      return getResponse(newRowId != 0);
    } else {
      // int quantity = await _productDbController.getQuantity(cart.productId);
      int newCount = cartItems[index].count + 1;
      return changeQuantity(index, newCount);
    }
  }

  void read() async {
    loading.value = true;
    cartItems.value = await _dbController.read();
    for (Cart cart in cartItems) {
      total += cart.total;
      quantity += cart.count;
    }
    loading.value = false;
  }

  Future<ProcessResponse> changeQuantity(int index, int count) async {
    bool isDelete = count == 0;
    Cart cart = cartItems[index];
    bool result = isDelete
        ? await _dbController.delete(cart.id)
        : await _dbController.update(cart);

    if (result) {
      if (isDelete) {
        total -= cart.total;
        quantity -= 1;
        cartItems.removeAt(index);
      } else {
        cart.count = count;
        cart.total = cart.price * cart.count;
        total += cart.total;
        quantity += 1;
        cartItems[index] = cart;
      }
    }

    return getResponse(result);
  }

  Future<ProcessResponse> clear() async {
    bool cleared = await _dbController.clear();
    if (cleared) {
      total = 0;
      quantity = 0;
      cartItems.clear();
    }
    return getResponse(cleared);
  }

  ProcessResponse getResponse(bool success) {
    return ProcessResponse(
      message:
      success ? 'Operation completed successfully' : 'Operation failed!',
      success: success,
    );
  }
}