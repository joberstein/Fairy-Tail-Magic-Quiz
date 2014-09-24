/* 
Jesse Oberstein
Fairy Tail Magic Quiz
*/

// Interprets the XML passed into it and creates dynamic navigation.
public class Entry {
  private XML story;
  private XML[] optsxml;
  private XML[] decsxml;
  private String prompt;
  private String[] decs;

  Entry(XML story) {
    this.story = story;
    this.prompt = this.story.getChild("prompt").getContent();
    this.optsxml = this.story.getChildren("opt");
    this.decsxml = this.story.getChildren("opt");
    this.decs = new String[this.decsxml.length];
    this.createDecisions();
    this.createEnding();
  }
  
  // Creates the decisions for this entry.
  public void createDecisions() {
    for (int i = 0; i < this.decsxml.length; i++) {
      this.decsxml[i] = this.decsxml[i].getChild("decision");
      this.decs[i] = this.decsxml[i].getContent();
    }
  }

  // Does this entry have an ending?
  public boolean hasEnding() {
    return this.story.getChild("prompt").getString("end").equals("y");
  }
  
  // Extracts the ending in the form of a string from this entry.
  // If there is no ending yet, returns an empty string.
  public String createEnding() {
    if (this.hasEnding()) {
      String img = this.story.getChild("prompt").getString("img");
      magicuser = loadImage(img);
      return this.story.getChild("ending").getContent();
    }
    else {
      return "";
    }
  }

  // Displays the prompt in this entry.
  public void displayPrompt() {
    fill(255);
    rect(10, 110, 650, 60);
    fill(#CE0007);
    textFont(avenirb, 20);
    text(this.prompt, 30, 130, 650, 80);
  }

  // Displays the options for the prompt in this entry.
  public void displayOptions() {
    textFont(avenir, 16);
    options = new Button[this.decs.length];
    for (int i = 0; i < this.decs.length; i++) {
      options[i] = new Button(this.decs[i], 50, 210 + i * 80, 380, 30);
    }
  }
  
  // Displays the ending for this entry.
  public void displayEnding() {
    fill(0, 0, 150);
    textFont(avenirb, 26);
    text("YOU'VE DISCOVERED YOUR MAGIC POWER!", 50, 140, 580, 500);
    textFont(avenir, 22);
    text(this.createEnding(), 70, 200, 560, 500);
    image(magicuser, 60, 350, 580, 370);
  }
  
  // Changes this entry to the next prompt.
  public void nextPrompt() {
    for (int i = 0; i < this.optsxml.length; i++) {
      if (options[i].hover()) {
        entry = new Entry(this.optsxml[i]);
      }
    }
  }
  
  // Changes this entry to the previous prompt.
  public void prevPrompt() {
    entry = new Entry(this.story.getParent());
  }
}

