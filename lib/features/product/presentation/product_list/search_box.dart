// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../utils/constants/asset_constant.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({
    super.key,
    required this.controller,
    required this.onCallBack,
  });

  final TextEditingController controller;
  final Function(String val) onCallBack;

  @override
  Widget build(BuildContext context) {
    // init
    final size = MediaQuery.sizeOf(context);

    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (_, value, __) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            AssetsConstants.defaultBorder + 10.0,
          ),
          boxShadow: const [
            BoxShadow(
              color: AssetsConstants.mainColor,
              blurRadius: 2,
              offset: Offset(0.2, 0.2), // Shadow position
            ),
          ],
        ),
        height: size.height * 0.05,
        child: TextField(
          onChanged: (val) => onCallBack(val),
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
              borderRadius: BorderRadius.circular(
                AssetsConstants.defaultBorder + 10.0,
              ),
              borderSide: const BorderSide(
                color: AssetsConstants.scaffoldColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AssetsConstants.defaultBorder + 10.0,
              ),
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
                        onCallBack('');
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
