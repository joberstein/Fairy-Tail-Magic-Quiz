/* 
Jesse Oberstein
Fairy Tail Magic Quiz
*/

// The root XML
XML story;
// A list of XML prompts
XML[] promptsXML;
// A single Entry, created from the next or previous prompt.
Entry entry;
// A list of option buttons.
Button[] options;
// The button clicked to go back a prompt.
Button back;
// The button clicked to go back to the home page.
Button home;
// The button clicked to show the first prompt.
Button start;
// Includes a description of the program's purpose.
String welcome;
// A variety of avenir fonts.
PFont avenir, avenirb;
// The current page.
int current;
// An image shown to be paired with an ending.
PImage magicuser;
// The background image to be displayed on each screen, save for an ending screen.
PImage background;

// Sets up the program by loading root XML, an entry, fonts, the background, 
// buttons, and setting the home page.
void setup() {
  size(700, 850);
  story = loadXML("FairyTailMagicText.xml");
  entry = new Entry(story);
  welcome = story.getChild("description").getContent();
  start = new Button("Start", 295, 750, 120, 90);
  home = new Button("Home", 570, 10, 120, 90);
  back = new Button("Back", 30, 760, 120, 90);
  avenir = loadFont("Avenir-Book-30.vlw");
  avenirb = loadFont("AvenirNext-Bold-30.vlw");
  current = -1;
  background = loadImage("fairytailguild.jpg");
  homePage();
}

// The home page of the program.  Contains a start button for the user to initiate
// the prompts.
void homePage() {
  background(255);
  image(background, 0, 0, 700, 850);
  fill(255);
  rect(40, 50, 610, 180);
  fill(0);
  textFont(avenir, 30);
  text(welcome, 50, 60, 600, 600);
  start.displayFunctionButton();
}

// Shows the home page until the start button is clicked.  Then, shows all the prompts.
// Only displays a back button after the first prompt has been completed.  If the user
// has reached an ending, a fitting image and appropriate text is displayed.
void draw() {
  if (current < 0) {
    homePage();
  }
  else if (current >= 0) {
    background(255);
    image(background, 0, 0, 700, 850);
    entry.displayPrompt();
    entry.displayOptions();
    home.displayFunctionButton();
    for (int i = 0; i < options.length; i++) {
      options[i].displayOptionButton();
    }
  }
  if (current > 0) { 
    back.displayFunctionButton();
  }
  if (entry.hasEnding()) {
    background(#FACFCF);
    home.displayFunctionButton();
    back.displayFunctionButton();
    entry.displayEnding();
  }
}

// Once the mouse is clicked and a button is hovered over, either start the
// program, go backward a screen, go to the next prompt, or go to the home
// screen.  If nothing is being hovered over but the mouse is clicked, nothing
// happens.
void mouseClicked() {
  if (current >= 0) {
    for (int i = 0; i < options.length; i++) {
      if (options[i].hover()) {
        current++;
        entry.nextPrompt();
      }
    }
  }
  if (start.hover()) {
    current = 0;
    entry = new Entry(story);
  }
  else if (home.hover()) {
    current = -1;
    entry = new Entry(story);
  }
  else if (back.hover() && current > 0) {
    current--;
    entry.prevPrompt();
  }
}

