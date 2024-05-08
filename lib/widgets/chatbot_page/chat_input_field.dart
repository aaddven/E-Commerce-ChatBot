import 'package:flutter/material.dart';

// ChatBot Input Field Widget

class ChatInputField extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onPressed;

  const ChatInputField({
    Key? key,
    required this.controller,
    required this.onPressed,
  }) : super(key: key);

  @override
  _ChatInputFieldState createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.98,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: widget.controller,
              focusNode: _focusNode,
              decoration: const InputDecoration(
                hintText: 'What are you looking for?',
                border: InputBorder.none,
              ),
              onSubmitted: (_) => _handleSubmit(),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send_outlined),
            onPressed: widget.onPressed,
            color: const Color(0xFF7165E3),
          ),
        ],
      ),
    );
  }

  void _handleSubmit() {
    if (widget.controller.text.trim().isNotEmpty) {
      widget.onPressed();
      widget.controller.clear();
      _focusNode.requestFocus();
    }
  }
}
