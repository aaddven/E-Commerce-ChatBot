import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/chatbot_page/chatbot_provider.dart';
import '../providers/chatbot_page/clothing_provider.dart';
import '../widgets/chatbot_page/chat_input_field.dart';
import '../widgets/chatbot_page/chatbot_reply.dart';

// CHATBOT SCREEN

class ChatBotPage extends StatefulWidget {
  @override
  _ChatBotPageState createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();


  @override
  Widget build(BuildContext context) {
    final clothingProvider = Provider.of<ClothingProvider>(context);
    final chatbotProvider = Provider.of<ChatbotProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF7165E3).withOpacity(0.5) ,
        elevation: 1.5,
        shadowColor: const Color(0xFF7165E3).withOpacity(0.15),
        title: const Text('E-Commerce ChatBot',
          style: TextStyle(
            fontFamily: "Roboto",
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.w500,
          ),),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF7165E3).withOpacity(0.1),
                  Color(0xFF7165E3).withOpacity(0.2), // Medium shade
                  Color(0xFF7165E3).withOpacity(0.3), // Darker shade
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownButton<String>(
                        value: clothingProvider.selectedGender,
                        onChanged: (newValue) {
                          clothingProvider.updateSelectedGender(newValue!);
                        },
                        items: ['Male', 'Female']
                            .map((gender) => DropdownMenuItem<String>(
                          value: gender,
                          child: Text(
                            gender,
                            style: const TextStyle(
                              color:  Color(0xFF7165E3),
                              fontWeight: FontWeight.w700
                            ),
                          ),
                        ))
                            .toList(),
                      ),
                      DropdownButton<String>(
                        value: clothingProvider.selectedStyle,
                        onChanged: (newValue) {
                          clothingProvider.updateSelectedStyle(newValue!);
                        },
                        items: ['Casual', 'Party', 'Formal']
                            .map((style) => DropdownMenuItem<String>(
                          value: style,
                          child: Text(
                            style,
                            style: const TextStyle(
                              color:  Color(0xFF7165E3),
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: chatbotProvider.allChatbotReplies.length,
                          itemBuilder: (context, index) {
                            final replies = chatbotProvider.allChatbotReplies[index];


                            final imageMaps = replies.map((clothingItem) {
                              return {
                                'image': clothingItem.image,
                                'link': clothingItem.link,
                              };
                            }).toList();

                            String sentence = imageMaps.isNotEmpty ? "Here are some recommendations :" : "Unable to find Clothing Item";

                            return ChatBotReply(
                              sentence: sentence,
                              images: imageMaps,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ChatInputField(
                controller: _messageController,
                onPressed: () {
                  String message = _messageController.text.trim();
                  if (message.isNotEmpty) {
                    chatbotProvider.processUserMessage(message);
                    _messageController.clear();
                    _scrollToBottom();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to scroll to the bottom of the ListView
  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

}



