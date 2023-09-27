// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../utils/constants/asset_constant.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    // init
    final size = MediaQuery.sizeOf(context);

    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (_, value, __) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: AssetsConstants.mainColor,
              blurRadius: 1.0, // soften the shadow
              spreadRadius: 1.0, //extend the shadow
            ),
          ],
        ),
        height: size.height * 0.05,
        child: TextField(
          controller: controller,
          style: const TextStyle(
            fontSize: AssetsConstants.defaultFontSize - 12.0,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: AssetsConstants.scaffoldColor,
            contentPadding: const EdgeInsets.symmetric(
              vertical: AssetsConstants.defaultPadding - 15.0,
            ),
            hintText: 'Tìm kiếm sản phẩm',
            hintStyle: const TextStyle(
              fontSize: AssetsConstants.defaultFontSize - 12.0,
              color: AssetsConstants.textBlur,
              fontWeight: FontWeight.w400,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: AssetsConstants.scaffoldColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: AssetsConstants.scaffoldColor,
              ),
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(
                right: AssetsConstants.defaultPadding - 16.0,
              ),
              child: IconButton(
                onPressed: () {},
                icon: const FaIcon(
                  FontAwesomeIcons.search,
                  color: AssetsConstants.cancelIconColor,
                  size: AssetsConstants.defaultFontSize - 10.0,
                ),
              ),
            ),
            suffixIcon: controller.text.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(
                      right: AssetsConstants.defaultPadding - 16.0,
                    ),
                    child: IconButton(
                      onPressed: () {
                        controller.clear();
                      },
                      icon: const Icon(
                        Icons.cancel_rounded,
                        color: AssetsConstants.cancelIconColor,
                        size: AssetsConstants.defaultFontSize - 10.0,
                      ),
                    ),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
