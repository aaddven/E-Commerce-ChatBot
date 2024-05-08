import 'package:ecommerce_chatbot/widgets/chatbot_page/chatbot_reply.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  testWidgets('ChatBotReply widget displays correct content', (WidgetTester tester) async {

    final String sentence = 'Here are some recommendations:';
    final List<Map<String, String>> images = [
      {'image': 'assets/images/database/m_c_tshirt_1.png', 'link': 'https://www.myntra.com/tshirts/stormborn/stormborn-graphic-printed-drop-shoulder-sleeves-pure-cotton-oversized-t-shirt/25072178/buy'},
      {'image': 'assets/images/database/m_c_tshirt_2.png', 'link': 'https://www.flipkart.com/maniac-typography-colorblock-men-round-neck-purple-white-t-shirt/p/itm59b8ac0d78297?pid=TSHGNC3WG7YCYGDB&lid=LSTTSHGNC3WG7YCYGDB4IHMOR&marketplace=FLIPKART&store=clo%2Fash%2Fank%2Fedy&srno=b_1_8&otracker=browse&fm=organic&iid=62aa0db7-3951-4407-a4ee-415228290764.TSHGNC3WG7YCYGDB.SEARCH&ppt=browse&ppn=browse&ssid=3g91dla0k00000001714742598353'},
    ];

    // Build the ChatBotReply widget with test data
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ChatBotReply(
            sentence: sentence,
            images: images,
          ),
        ),
      ),
    );

    // Verify that the ChatBotReply widget renders the sentence
    expect(find.text(sentence), findsOneWidget);

    // Verify that the ChatBotReply widget renders the correct number of image containers
    expect(find.byType(GestureDetector), findsNWidgets(images.length));

    // Verify that the image containers have the correct images and links
    for (final imageData in images) {
      final assetPath = imageData['image']!;

      expect(find.byWidgetPredicate((widget) {
        if (widget is GestureDetector) {
          final decoratedContainer = (widget.child as Container);
          if (decoratedContainer.decoration is BoxDecoration) {
            final decoration = decoratedContainer.decoration as BoxDecoration;
            if (decoration.image != null && decoration.image is DecorationImage) {
              final imageProvider = (decoration.image as DecorationImage).image;
              if (imageProvider is AssetImage && imageProvider.assetName == assetPath) {
                return true;
              }
            }
          }
        }
        return false;
      }), findsOneWidget);

      // Tap on the image to simulate link launching behavior (you can mock the launchUrl function)
      await tester.tap(find.byWidgetPredicate((widget) {
        if (widget is GestureDetector) {
          final decoratedContainer = (widget.child as Container);
          if (decoratedContainer.decoration is BoxDecoration) {
            final decoration = decoratedContainer.decoration as BoxDecoration;
            if (decoration.image != null && decoration.image is DecorationImage) {
              final imageProvider = (decoration.image as DecorationImage).image;
              if (imageProvider is AssetImage && imageProvider.assetName == assetPath) {
                return true;
              }
            }
          }
        }
        return false;
      }));

    }
  });
}
