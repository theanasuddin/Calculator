HashMap<String, PFont> fonts; //<>//
color darkestGrey;
color lightGrey;
color white;
color red;
color colorOfDot;

int DELAY_IN_SECONDS = 1;

int clickTimeOnDot, endTimeForDot, clickTimeOnPlusMinus, endTimeForPlusMinus;

PImage plusOrMinusDarkestGrey;
PImage plusOrMinusRed;
PImage plusOrMinus;

void setup() {
  size(465, 620);
  clickTimeOnDot = Integer.MIN_VALUE;
  endTimeForDot = Integer.MIN_VALUE;

  clickTimeOnPlusMinus = Integer.MIN_VALUE;
  endTimeForPlusMinus = Integer.MIN_VALUE;

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
  lightGrey = #E6E7E6;
  white = #FFFFFF;
  red = #FF4D19;
  colorOfDot = darkestGrey;

  // loading symbols
  plusOrMinusDarkestGrey = loadImage("symbols/plus_or_minus_darkest_grey.png");
  plusOrMinusRed = loadImage("symbols/plus_or_minus_red.png");
  plusOrMinus = plusOrMinusDarkestGrey;
}

void draw() {
  background(255);
  drawRectangle(0, 563, 465, 57, #CECACE);
  drawText("Clear", 15, 575, 25, fonts.get("openSansSemibold"), darkestGrey);
  drawText("Clear All", 351, 575, 25, fonts.get("openSansSemibold"), darkestGrey);
  drawRectangle(0, 313, 465, 250, lightGrey);

  // point
  noStroke();
  drawCircle(33, 465, 70, 70, white);
  setColorOfDot();
  drawCircle(65, 497, 7, 7, colorOfDot);

  // plus or minus
  drawCircle(362, 465, 70, 70, white);
  setColorOfPlusMinus();
  image(plusOrMinus, 376.4, 465.6);

  // common operator area
  stroke(white);
  strokeWeight(39);
  drawCircle(138 + (39 / 2), 345 + (39 / 2), 151, 151, lightGrey);

  if (isInsideCircle(33 + 35, 465 + 35, 35)) {
    cursor(HAND);
  } else if (isInsideCircle(362 + 35, 465 + 35, 35)) {
    cursor(HAND);
  }
  // in normal cases, cursor is always of type 'ARROW'
  else {
    cursor(ARROW);
  }
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

void drawCircle(float coordinateX, float coordinateY, float width, float height, color fill) {
  ellipseMode(CORNER);
  fill(fill);
  ellipse(coordinateX, coordinateY, width, height);
}

private boolean isInsideCircle (float coordinateX, float coordinateY, int radius) {
  float distance = sqrt(pow((mouseX - coordinateX), 2) + pow((mouseY - coordinateY), 2));
  return distance <= radius ? true : false;
}

void mousePressed() {
  // when pressed on dot
  if (isInsideCircle(33 + 35, 465 + 35, 35)) {
    clickTimeOnDot = second();
    endTimeForDot = getEndTime(clickTimeOnDot);
  }

  // when pressed on plus or minus
  if (isInsideCircle(362 + 35, 465 + 35, 35)) {
    clickTimeOnPlusMinus = second();
    endTimeForPlusMinus = getEndTime(clickTimeOnPlusMinus);
  }
}

private void setColorOfDot() {
  if (clickTimeOnDot >= 0) {
    if (second() != endTimeForDot) {
      colorOfDot = red;
    } else {
      colorOfDot = darkestGrey;
      clickTimeOnDot = Integer.MIN_VALUE;
    }
  }
}

private void setColorOfPlusMinus() {
  if (clickTimeOnPlusMinus >= 0) {
    if (second() != endTimeForPlusMinus) {
      plusOrMinus = plusOrMinusRed;
    } else {
      plusOrMinus = plusOrMinusDarkestGrey;
      clickTimeOnPlusMinus = Integer.MIN_VALUE;
    }
  }
}

private int getEndTime(int clickTimeOnDot) {
  int endTime = clickTimeOnDot + DELAY_IN_SECONDS;
  if (endTime > 59) {
    int remainder = endTime % 59;
    endTime = remainder - 1;
  }

  return endTime;
}
