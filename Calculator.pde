HashMap<String, PFont> fonts;
color darkestGrey;

void setup() {
  size(465, 620);

  // loading custom fonts
  fonts = new HashMap<String, PFont>();
  StringList fontFileNames = new StringList("OpenSans-Regular.ttf", "OpenSans-Bold.ttf", "OpenSans-Light.ttf", "OpenSans-Semibold.ttf");
  StringList fontNames = new StringList("openSans", "openSansBold", "openSansLight", "openSansSemibold");
  String fontFilesRootPath = "fonts/";
  for (int counter = 0; counter < fontNames.size(); counter++) {
    fonts.put(fontNames.get(counter), createFont(fontFilesRootPath + fontFileNames.get(counter), 32, true));
  }

  // all colors
  darkestGrey = #313131;
}

void draw() {
  background(255);
  drawRectangle(0, 563, 465, 57, #CECACE);
  drawText("Clear", 15, 575, 25, fonts.get("openSansSemibold"), darkestGrey);
  drawText("Clear All", 351, 575, 25, fonts.get("openSansSemibold"), darkestGrey);
}

void drawRectangle(float positionX, float positionY, float width, float height, color fill) {
  noStroke();
  fill(fill);
  rect(positionX, positionY, width, height);
}

void drawText(String text, float positionX, float positionY, float fontSize, PFont font, color fill) {
  textFont(font);
  textSize(fontSize);
  textAlign(LEFT, TOP);
  fill(fill);
  text(text, positionX, positionY);
}
