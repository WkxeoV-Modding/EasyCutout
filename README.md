# EasyCutout
A simple script that allows someone to place a cutout of themselves.

Simply put the script, model and texture into your avatar folder.

From there I suggest simply customizing the texture to see.

In game you will find new option on your action wheel called **Enemy**

Left Click to place a cutout. It will be placed in the center of a block placed and named by the number it was placed (if multiple).

Right Click to remove a cutout. It will remove based off the oldest unless you scroll and change which slot you will change.
However, copies are saved in a table. So if you make 3 clones {clone1, clone2, clone3} and delete clone2 it will become
{clone1, clone3} and so to delete clone3 you have to delete slot 2. On top of that if you place another clone, that clone will
have three. So it becomes {clone1, clone3, clone3}

Currently, it is limited to 3 but to those who want more simply increase it in the script.
The variable to change is totalAllowed
