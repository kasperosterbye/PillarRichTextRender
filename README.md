# PillarRichTextRender
Rendering the Pillar markup inside the Pharo image

This is work in (early) progress, but I think it is far enough for a "technology preview".

At the moment it will load the whole of Pillar, but I hope to fix that soon.

Load it using Metacello:

```Smalltalk
Metacello new
   baseline: 'PillarRichTextRender';
   repository: 'github://kasperosterbye/PillarRichTextRender';
   load.
```

Once loaded, the class `PRRichTextComposer` has some examples on the class side.
