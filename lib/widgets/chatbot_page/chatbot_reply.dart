import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// ChatBot Reply Widget

class ChatBotReply extends StatelessWidget {
  final String sentence;
  final List<Map<String, String>> images;

  ChatBotReply({
    Key? key,
    required this.sentence,
    this.images = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sentence,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF110B56).withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 12.0),
          if (images.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: images
                  .map((imageData) => _buildImageWidget(context, imageData))
                  .toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildImageWidget(BuildContext context, Map<String, String> imageData) {
    final String? imageName = imageData['image'];
    final String? link = imageData['link'];

 
    const isWeb = identical(0, 0.0);
    final assetPath = isWeb ? imageName?.replaceFirst('assets/', '') : imageName;

    return GestureDetector(
      onTap: () async {
        if (link != null) {
          await _launchInBrowser(Uri.parse(link));
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.2,
        height: MediaQuery.of(context).size.height * 0.25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.transparent,
          image: DecorationImage(
            image: AssetImage(assetPath!),
            fit: BoxFit.contain,
          ),
        ),
        margin: const EdgeInsets.only(bottom: 8.0),
      ),
    );
  }

  // Function to launch url on image click
  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }



}
