
This app fulfills all the requirements for the HW:

- Displays items. The app starts up with a couple items, but you can add
  more.
- Item property sheet. The app displays a modal view controller that
  shows the properties for a given item. These would be the tags
  associated with the item and its location if it has one. If the item
  doesn't have a location specified, the location defaults to 0,0.
- The property sheet has a button that displays the location in a
  browser window.
    
However, the app has some serious limitations. The biggest issue is that
it doesn't support removal. You can't remove items and you can't remove
tags from items. It is all very immutable. I feel confident that I
could've have implemented these feature; I just ran out of time . . .
:-(

(You can update the location in the property sheet.)

The other issue with the app is that the UI just needs a lot of polish.
It looks okay and it _does_ work (except for remove), but it is pretty
clunky. For example, if you type the name for a new item in the text
box, you have to add the item ("+" button) and then select it in the
table view before you can bring up its properties sheet and add tags or
a location. Stuff like that. This stuff would have been easy to fix, but
again, time was limited.


*** END ***

