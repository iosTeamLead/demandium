import 'package:country_code_picker/country_code_picker.dart';
import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final String? title;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final bool? isPassword;
  final bool? isShowBorder;
  final bool? isAutoFocus;
  final Function(String)? onSubmit;
  final bool? isEnabled;
  final int? maxLines;
  final bool? isShowSuffixIcon;
  final TextCapitalization? capitalization;
  final Function(String text)? onChanged;
  final String? countryDialCode;
  final String? suffixIconUrl;
  final Function(CountryCode countryCode)? onCountryChanged;
  final String? Function(String? )? onValidate;
  final bool contentPadding;
  final double? borderRadius;
  final bool isRequired;
  final String? prefixIcon;

  const CustomTextField(
      {super.key, this.hintText = '',
        this.controller,
        this.focusNode,
        this.nextFocus,
        this.isEnabled = true,
        this.inputType = TextInputType.text,
        this.inputAction = TextInputAction.next,
        this.maxLines = 1,
        this.isShowSuffixIcon = false,
        this.onSubmit,
        this.capitalization = TextCapitalization.none,
        this.isPassword = false,
        this.isShowBorder,
        this.isAutoFocus = false,
        this.countryDialCode,
        this.onCountryChanged,
        this.suffixIconUrl,
        this.onChanged,
        this.onValidate,
        this.title,
        this.contentPadding= true,
        this.borderRadius,
        this.isRequired = true,
        this.prefixIcon
      });

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLines,
      controller: widget.controller,
      focusNode: widget.focusNode,
      style: ubuntuRegular.copyWith(fontSize:Dimensions.fontSizeDefault,color: widget.isEnabled==false?Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6):Theme.of(context).textTheme.bodyLarge!.color),
      textInputAction: widget.inputAction,
      keyboardType: widget.inputType,
      cursorColor: Theme.of(context).hintColor,
      textCapitalization: widget.capitalization!,
      enabled: widget.isEnabled,
      autofocus: widget.isAutoFocus!,
      autofillHints: widget.inputType == TextInputType.name ? [AutofillHints.name]
          : widget.inputType == TextInputType.emailAddress ? [AutofillHints.email]
          : widget.inputType == TextInputType.phone ? [AutofillHints.telephoneNumber]
          : widget.inputType == TextInputType.streetAddress ? [AutofillHints.fullStreetAddress]
          : widget.inputType == TextInputType.url ? [AutofillHints.url]
          : widget.inputType == TextInputType.visiblePassword ? [AutofillHints.password] : null,
      obscureText: widget.isPassword! ? _obscureText : false,
      inputFormatters: widget.inputType == TextInputType.phone ? <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp('[0-9+]'))] : null,

      decoration: InputDecoration(

        label: widget.countryDialCode == null && widget.isShowBorder == null ? Row(crossAxisAlignment: CrossAxisAlignment.start,children: [
          Text(widget.title ?? "", style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyLarge?.color),),

          if(widget.isRequired)
            Padding(padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Text("*", style: ubuntuRegular.copyWith(color: Theme.of(context).colorScheme.error),),
            )
        ],) : null,
        labelStyle: widget.countryDialCode == null ? ubuntuMedium.copyWith(fontSize: 20) : null,

        prefixIcon: widget.prefixIcon != null ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,vertical: 5),
          child: Image.asset(widget.prefixIcon!, width: 20,height: 20, color: Theme.of(context).colorScheme.primary.withOpacity(0.4),),
        ) : widget.countryDialCode != null ? Padding( padding:  EdgeInsets.only(left: widget.isShowBorder == true ?  10: 0),
          child: CountryCodePicker(
            onChanged: widget.onCountryChanged,
            initialSelection: widget.countryDialCode,
            favorite: [widget.countryDialCode ?? ""],
            showDropDownButton: true,
            padding: EdgeInsets.zero,
            showFlagMain: true,
            dialogSize: Size(Dimensions.webMaxWidth/2, Get.height*0.6),
            dialogBackgroundColor: Theme.of(context).cardColor,
            barrierColor: Get.isDarkMode?Colors.black.withOpacity(0.4):null,
            textStyle: ubuntuRegular.copyWith(
              fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
          ),
        ): null,
        contentPadding:  EdgeInsets.only(
          top: widget.countryDialCode != null ? Dimensions.paddingSizeDefault : Dimensions.fontSizeSmall, bottom: Dimensions.paddingSizeDefault,
          left:  widget.isShowBorder != null && widget.isShowBorder! ? Dimensions.paddingSizeDefault :  0,
          right: widget.isShowBorder != null && widget.isShowBorder! ? Dimensions.paddingSizeDefault : 0,
        ),
        focusedBorder : widget.isShowBorder != null && widget.isShowBorder!
            ? OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),borderRadius: BorderRadius.circular(widget.borderRadius ?? Dimensions.radiusDefault))
            : UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.primary)),

        enabledBorder : widget.isShowBorder != null && widget.isShowBorder!
            ? OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).hintColor),borderRadius: BorderRadius.circular(widget.borderRadius ?? Dimensions.radiusDefault)) : null,

        hintText: widget.hintText,
        hintStyle: ubuntuRegular.copyWith(
            fontSize: Dimensions.fontSizeDefault,
            color: Theme.of(context).hintColor.withOpacity(Get.isDarkMode ? .5:1)),
        suffixIcon: widget.isPassword! ?
        IconButton(
          icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility, color: Theme.of(context).hintColor.withOpacity(0.3)),
          onPressed: _toggle,
        ) : null,
      ),
      onFieldSubmitted: (text) => widget.nextFocus != null ?
      FocusScope.of(context).requestFocus(widget.nextFocus) :
      widget.onSubmit != null ? widget.onSubmit!(text) : null,
      onChanged: widget.onChanged,
      validator: widget.onValidate != null ? widget.onValidate!: null,

    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}