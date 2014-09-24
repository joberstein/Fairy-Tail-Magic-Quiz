/* 
Jesse Oberstein
Fairy Tail Magic Quiz
*/

// Allows a text to be clickable by enclosing it in dimensions of a rectangle.
public class Button {
  private String words;
  private int toprx, topry, w, h;
  private int red, green, blue, id;

  Button(String words, int toprx, int topry, int w, int h) {
    this.words = words;
    this.toprx = toprx;
    this.topry = topry;
    this.w = w;
    this.h = h;
    
    // Sets the initial color of the button to black.
    this.red = 0;
    this.green = 0;
    this.blue = 0;
    
    // A toggle value to control hovering effects.
    this.id = 0;
  }
  
  // Is the user hovering over this button?
  public boolean hover() {
    return mouseX >= this.toprx 
      && mouseX <= (this.toprx + this.w) 
      && mouseY >= this.topry
        && mouseY <= (this.topry + this.h);
  }
  
  // Change the color of this button if it's being hovered over.
  public void changeColor() {
    if (this.hover()) {
      this.red = 100;
      this.green = 200;
      this.blue = 50;
    }
    else {
      this.red = 0;
      this.green = 0;
      this.blue = 0;
    }
  }
  
  // Displays this button as an option button (choices for prompts).
  public void displayOptionButton() {
    fill(255);
    rect(this.toprx - 20, this.topry - 20, this.w + 20, this.h + 20);
    this.changeColor();
    fill(this.red, this.green, this.blue);
    textFont(avenir, 20);
    text(this.words, this.toprx, this.topry, this.w, this.h);
    
  }
  
  // Displays this button as a function button (start, home, back).
  public void displayFunctionButton() {
    fill(255);
    rect(this.toprx, this.topry, this.w - (this.w / 12), this.h - 20);
    this.changeColor();
    fill(this.red, this.green, this.blue);
    textFont(avenirb, 30);
    text(this.words, this.toprx + (this.w / 8), this.topry + (this.h / 4), this.w, this.h);
  }
}

