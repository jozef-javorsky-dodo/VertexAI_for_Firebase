import 'dart:convert';

// Order from a restarant for take away
class Order {
  final String userId;
  final DateTime date;
  final String restaurantName;
  final String restaurantType;
  final String orderDetails;
  final double price;
  double tipPercentage;
  double taxRate;

  Order({
    required this.userId,
    required this.date,
    required this.restaurantName,
    required this.restaurantType,
    required this.orderDetails,
    required this.price,
    this.tipPercentage = 0.15,
    this.taxRate = 0.08,
  });

  double get tipAmount => price * tipPercentage;
  double get taxAmount => price * taxRate;
  double get totalAmount => price + tipAmount + taxAmount;

  Order.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        date = DateTime.parse(json['date']),
        restaurantName = json['restaurantName'],
        restaurantType = json['restaurantType'],
        orderDetails = json['orderDetails'],
        price = json['price'].toDouble(),
        tipPercentage = json['tipPercentage'].toDouble(),
        taxRate = json['taxRate'].toDouble();
}

class OrderService {
  static final List<Order> _orders = createOrdersFromJson(ordersData);

  // Get the list of restaurant types visited by a user.
  List<String> getRestaurantTypesVisitedByUser(String userId) {
    return _orders
        .where((order) => order.userId == userId)
        .map((order) => order.restaurantType)
        .toSet()
        .toList();
  }

  // Get orders within a date range.
  // The orders contains information about what items the user ordered,
  // date, restaurant name, restaurant type, and price.
  List<Order> getOrdersFromDateRange(
      String userId, DateTime startDate, DateTime endDate) {
    return _orders
        .where((order) =>
                order.userId == userId &&
                order.date.compareTo(startDate) >=
                    0 && // Order date is on or after startDate
                order.date.compareTo(endDate) <=
                    0 // Order date is on or before endDate
            )
        .toList();
  }

  // Pleace an order
  void placeOrder(Order order) {
    _orders.add(order);
  }

  static List<Order> createOrdersFromJson(String jsonString) {
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((jsonItem) => Order.fromJson(jsonItem)).toList();
  }

  static const String ordersData = '''
  [
    {
      "userId": "user123",
      "date": "2024-05-01T12:35:18.000",
      "restaurantName": "Curry Palace",
      "restaurantType": "Indian",
      "orderDetails": "1 x Butter Chicken, 1 x Garlic Naan, 1 x Mango Lassi, 1 x Vegetable Samosa",
      "price": 25.50,
      "tipPercentage": 0.18,
      "taxRate": 0.085
    },
    {
      "userId": "user123",
      "date": "2024-05-02T19:15:42.000",
      "restaurantName": "Pizza Planet",
      "restaurantType": "Italian",
      "orderDetails": "1 x Pepperoni Pizza (Large), 1 x Caesar Salad, 2 x Garlic Knots",
      "price": 22.99,
      "tipPercentage": 0.15,
      "taxRate": 0.078
    },
    {
      "userId": "user123",
      "date": "2024-05-04T14:08:11.000",
      "restaurantName": "Thai Delight",
      "restaurantType": "Thai",
      "orderDetails": "1 x Pad Thai, 1 x Tom Yum Soup, 1 x Green Curry, 1 x Jasmine Rice",
      "price": 30.75,
      "tipPercentage": 0.20,
      "taxRate": 0.09
    },
    {
      "userId": "user123",
      "date": "2024-05-06T20:45:36.000",
      "restaurantName": "Burger Barn",
      "restaurantType": "American",
      "orderDetails": "1 x Double Cheeseburger, 1 x Fries, 1 x Onion Rings, 1 x Chocolate Shake",
      "price": 18.99,
      "tipPercentage": 0.12,
      "taxRate": 0.08
    },
    {
      "userId": "user123",
      "date": "2024-05-07T11:22:59.000",
      "restaurantName": "Pho Real",
      "restaurantType": "Vietnamese",
      "orderDetails": "1 x Pho Tai, 1 x Summer Rolls (2 pcs), 1 x Grilled Pork Banh Mi",
      "price": 20.50,
      "tipPercentage": 0.18,
      "taxRate": 0.082
    },
    {
      "userId": "user123",
      "date": "2024-05-09T18:10:23.000",
      "restaurantName": "Taco Town",
      "restaurantType": "Mexican",
      "orderDetails": "2 x Chicken Tacos, 1 x Beef Taco, 1 x Guacamole & Chips, 1 x Churros",
      "price": 16.80,
      "tipPercentage": 0.15,
      "taxRate": 0.075
    },
    {
      "userId": "user123",
      "date": "2024-05-11T13:58:07.000",
      "restaurantName": "The Daily Grind",
      "restaurantType": "Cafe",
      "orderDetails": "1 x Latte, 1 x Croissant, 1 x Blueberry Muffin, 1 x Iced Tea",
      "price": 12.95,
      "tipPercentage": 0.10,
      "taxRate": 0.06
    },
    {
      "userId": "user123",
      "date": "2024-05-13T21:35:18.000",
      "restaurantName": "Greek Eats",
      "restaurantType": "Greek",
      "orderDetails": "1 x Gyro Plate, 1 x Greek Salad, 1 x Spanakopita, 1 x Baklava",
      "price": 26.95,
      "tipPercentage": 0.22,
      "taxRate": 0.09
    },
    {
      "userId": "user123",
      "date": "2024-05-15T16:05:34.000",
      "restaurantName": "Sushi Heaven",
      "restaurantType": "Japanese",
      "orderDetails": "1 x Spicy Tuna Roll, 1 x Dragon Roll, 1 x Salmon Nigiri (2 pcs), 1 x Miso Soup",
      "price": 27.50,
      "tipPercentage": 0.18,
      "taxRate": 0.085
    },
    {
      "userId": "user123",
      "date": "2024-05-16T12:22:47.000",
      "restaurantName": "Wing Stop",
      "restaurantType": "American",
      "orderDetails": "15 x Buffalo Wings, 1 x Fries, 1 x Onion Rings, 1 x Ranch Dressing",
      "price": 20.75,
      "tipPercentage": 0.15,
      "taxRate": 0.078
    },
    {
      "userId": "user123",
      "date": "2024-05-18T19:45:02.000",
      "restaurantName": "Pasta Perfection",
      "restaurantType": "Italian",
      "orderDetails": "1 x Fettuccine Alfredo, 1 x Lasagna, 1 x Garlic Bread, 1 x Tiramisu",
      "price": 31.50,
      "tipPercentage": 0.20,
      "taxRate": 0.09
    },
    {
      "userId": "user123",
      "date": "2024-05-20T15:58:39.000",
      "restaurantName": "Korean BBQ",
      "restaurantType": "Korean",
      "orderDetails": "1 x Bulgogi, 1 x Galbi, 1 x Kimchi, 1 x Japchae, 1 x Bibimbap",
      "price": 42.00,
      "tipPercentage": 0.22,
      "taxRate": 0.092
    },
    {
      "userId": "user123",
      "date": "2024-05-22T11:30:15.000",
      "restaurantName": "The Salad Bar",
      "restaurantType": "Healthy",
      "orderDetails": "1 x Cobb Salad, 1 x Greek Salad, 1 x Fruit Cup",
      "price": 15.50,
      "tipPercentage": 0.12,
      "taxRate": 0.07
    },
    {
      "userId": "user123",
      "date": "2024-05-23T22:15:56.000",
      "restaurantName": "Dim Sum House",
      "restaurantType": "Chinese",
      "orderDetails": "4 x Shrimp Dumplings, 3 x Pork Buns, 2 x Egg Rolls, 2 x Har Gow",
      "price": 23.25,
      "tipPercentage": 0.18,
      "taxRate": 0.085
    },
    {
        "userId": "user123",
        "date": "2024-05-25T17:45:28.000",
        "restaurantName": "The Rib Shack",
        "restaurantType": "BBQ",
        "orderDetails": "1 x Pulled Pork Sandwich, 1 x Mac & Cheese, 1 x Coleslaw, 1 x Sweet Tea",
        "price": 17.50,
        "tipPercentage": 0.15,
        "taxRate": 0.078
      },
      {
        "userId": "user123",
        "date": "2024-05-27T13:18:09.000",
        "restaurantName": "The Seafood Market",
        "restaurantType": "Seafood",
        "orderDetails": "1 x Lobster Roll, 1 x Clam Chowder, 1 x Fried Calamari, 1 x Lemonade",
        "price": 28.75,
        "tipPercentage": 0.20,
        "taxRate": 0.09
      },
      {
        "userId": "user123",
        "date": "2024-05-29T20:05:43.000",
        "restaurantName": "The Breakfast Nook",
        "restaurantType": "Breakfast",
        "orderDetails": "1 x Pancakes, 2 x Eggs, 1 x Sausage, 1 x Coffee, 1 x Orange Juice",
        "price": 14.99,
        "tipPercentage": 0.12,
        "taxRate": 0.08
      },
      {
        "userId": "user123",
        "date": "2024-05-31T10:32:21.000",
        "restaurantName": "The French Bistro",
        "restaurantType": "French",
        "orderDetails": "1 x Croque Monsieur, 1 x Onion Soup, 1 x French Fries, 1 x Crème Brûlée",
        "price": 25.50,
        "tipPercentage": 0.18,
        "taxRate": 0.082
      },
      {
        "userId": "user123",
        "date": "2024-06-02T16:55:17.000",
        "restaurantName": "The Steakhouse",
        "restaurantType": "Steakhouse",
        "orderDetails": "1 x New York Strip Steak, 1 x Baked Potato, 1 x Caesar Salad, 1 x Red Wine",
        "price": 45.00,
        "tipPercentage": 0.22,
        "taxRate": 0.09
      },
      {
        "userId": "user123",
        "date": "2024-06-04T12:48:52.000",
        "restaurantName": "The Sandwich Shop",
        "restaurantType": "Sandwich",
        "orderDetails": "1 x Turkey Club, 1 x Potato Chips, 1 x Pickle, 1 x Iced Tea",
        "price": 10.50,
        "tipPercentage": 0.10,
        "taxRate": 0.06
      },
      {
        "userId": "user123",
        "date": "2024-06-06T19:22:36.000",
        "restaurantName": "The Sushi Bar",
        "restaurantType": "Japanese",
        "orderDetails": "1 x California Roll, 1 x Rainbow Roll, 1 x Edamame, 1 x Green Tea",
        "price": 21.75,
        "tipPercentage": 0.18,
        "taxRate": 0.085
      },
      {
        "userId": "user123",
        "date": "2024-06-08T15:15:11.000",
        "restaurantName": "The Pizza Place",
        "restaurantType": "Italian",
        "orderDetails": "1 x Margherita Pizza, 1 x Garlic Knots, 1 x Coke, 1 x Tiramisu",
        "price": 18.99,
        "tipPercentage": 0.15,
        "taxRate": 0.078
      },
      {
        "userId": "user123",
        "date": "2024-06-10T21:58:47.000",
        "restaurantName": "The Burrito Bowl",
        "restaurantType": "Mexican",
        "orderDetails": "1 x Chicken Burrito Bowl, 1 x Guacamole & Chips, 1 x Horchata",
        "price": 14.50,
        "tipPercentage": 0.12,
        "taxRate": 0.08
      },
      {
        "userId": "user123",
        "date": "2024-06-12T11:42:23.000",
        "restaurantName": "The Ramen Shop",
        "restaurantType": "Japanese",
        "orderDetails": "1 x Shoyu Ramen, 1 x Gyoza, 1 x Iced Tea",
        "price": 16.25,
        "tipPercentage": 0.18,
        "taxRate": 0.082
      },
      {
        "userId": "user123",
        "date": "2024-06-14T17:35:59.000",
        "restaurantName": "The Chicken Shack",
        "restaurantType": "American",
        "orderDetails": "1 x Fried Chicken Sandwich, 1 x Fries, 1 x Coleslaw, 1 x Lemonade",
        "price": 12.75,
        "tipPercentage": 0.15,
        "taxRate": 0.078
      },
      {
        "userId": "user123",
        "date": "2024-06-16T13:28:34.000",
        "restaurantName": "The Soup Kitchen",
        "restaurantType": "Soup",
        "orderDetails": "1 x Tomato Soup, 1 x Grilled Cheese Sandwich, 1 x Salad",
        "price": 11.50,
        "tipPercentage": 0.10,
        "taxRate": 0.06
      },
      {
        "userId": "user123",
        "date": "2024-06-18T20:12:10.000",
        "restaurantName": "The Middle Eastern Cafe",
        "restaurantType": "Middle Eastern",
        "orderDetails": "1 x Falafel Plate, 1 x Hummus, 1 x Pita Bread, 1 x Mint Tea",
        "price": 19.99,
        "tipPercentage": 0.18,
        "taxRate": 0.085
      },
      {
        "userId": "user123",
        "date": "2024-06-20T16:05:46.000",
        "restaurantName": "The Vegan Bistro",
        "restaurantType": "Vegan",
        "orderDetails": "1 x Vegan Burger, 1 x Fries, 1 x Salad, 1 x Lemonade",
        "price": 15.25,
        "tipPercentage": 0.15,
        "taxRate": 0.078
      },
      {
        "userId": "user123",
        "date": "2024-06-22T12:58:22.000",
        "restaurantName": "The Indian Curry House",
        "restaurantType": "Indian",
        "orderDetails": "1 x Chicken Tikka Masala, 1 x Naan Bread, 1 x Rice, 1 x Mango Lassi",
        "price": 22.50,
        "tipPercentage": 0.20,
        "taxRate": 0.09
      },
      {
        "userId": "user123",
        "date": "2024-06-24T19:42:08.000",
        "restaurantName": "The Chinese Takeout",
        "restaurantType": "Chinese",
        "orderDetails": "1 x Kung Pao Chicken, 1 x Fried Rice, 1 x Egg Roll, 1 x Soda",
        "price": 16.75,
        "tipPercentage": 0.12,
        "taxRate": 0.08
      },
      {
        "userId": "user123",
        "date": "2024-06-26T10:25:33.000",
        "restaurantName": "The Italian Deli",
        "restaurantType": "Italian",
        "orderDetails": "1 x Italian Sub, 1 x Potato Chips, 1 x Pickle, 1 x Iced Tea",
        "price": 11.99,
        "tipPercentage": 0.10,
        "taxRate": 0.06
      }
]
  ''';
}
