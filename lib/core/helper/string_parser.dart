class StringParser {

  static String parseString(String mainString, String parseBy) {
    if(mainString.contains("&&") && mainString.contains("=")){
      String urlString = mainString;
      List<String> parts = urlString.split("&&");
      List<String> tokenPart = [];

      for (var element in parts) {
        if(element.contains(parseBy)){
          tokenPart = element.split("=");
        }
      }
      if(tokenPart.isNotEmpty){
        return tokenPart.last;
      }else{
        return "";
      }
    }else{
      return "";
    }
  }
}