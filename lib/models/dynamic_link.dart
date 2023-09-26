import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:share_plus/share_plus.dart';

class DynamicLinkProvider {
  Future<String> createLink(String id) async {
    final String url = "https://ru.innim.restaurantapp?id=$id";
    final DynamicLinkParameters param = DynamicLinkParameters(
      link: Uri.parse(url),
      uriPrefix: "https://restaurantdetails.page.link",
      androidParameters: AndroidParameters(
        packageName: "ru.innim.restaurantapp",
        minimumVersion: 0,
      ),
    );
    final FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

    try {
      final ShortDynamicLink shortLink = await dynamicLinks.buildShortLink(
        param,
      );
      return shortLink.shortUrl.toString();
    } catch (e) {
      print("Error creating dynamic link: $e");
      return '';
    }
  }

  void initDynamicLink() async {
    final instanceLink = await FirebaseDynamicLinks.instance.getInitialLink();
    if (instanceLink != null) {
      final Uri initLink = instanceLink.link;

      Share.share('${initLink.queryParameters["id"]}');
    }
  }
}
