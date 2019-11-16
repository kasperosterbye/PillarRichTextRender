# PillarRichTextRender
Rendering the Pillar markup inside the Pharo image

This is work in (early) progress, but I think it is far enough for a "technology preview".

### Goal of the project
The goal of the project is to be able to do better in-image documentation. To do this, I am working on several fronts:

1. Rendering more pillar, expecially I would like to get a solution for tables.
2. Rendering github markdown in addition to pillar markdown. This will allow me to pull markdown from git and display it in-image.
3. Giving the "help-system" some love.
4. In-image tools for writing markdown - a markdown editor
4. A design for keeping the mark-down texts seamlessly outside of the image

Reg. 1., I can only figure out how to transform a morphic table into an image, and then add that image to the text (not included atm as I find it so ugly a solution). Any other ideas are greatly appreciated.

Reg. 2. I am nearly done on this one, at least for the easy aspects (headers, lists, emphasis, code-blocks).

Reg 3 and 4. Only loose ideas atm.

### Trying it out

Load it using Metacello:

```Smalltalk
Metacello new
   baseline: 'PillarRichTextExporter';
   repository: 'github://kasperosterbye/PillarRichTextRender';
   load.
```

Once loaded, the class `PRRichTextComposer` has some examples on the class side.

### Pillar in class and package comments

*Warning: this load will redefine a corner of the Calypso browser*

```Smalltalk
Metacello new
	baseline: 'PillarImageTools';
	repository: 'github://kasperosterbye/PillarRichTextRender';
	load	
```

Once loaded the class comments and package comments will be rendered in pillar. Most comments are not in pillar. It tries to guess if the comment is pillar or plain text (by looking for a few key markdowns). 

At the moment you cannot edit the rendered text directly, but pressing `meta-r` (also known as `command-r`) will toggle between rendered and source mode. In source mode you can edit the source. Accepting the changes reverts back to rendered mode.
