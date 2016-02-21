# Mailbox

The purpose of this homework is to leverage animations and gestures to implement more sophisticated interactions. We're going to use the techniques from this week to implement the Mailbox interactions.

Time spent: 12 hours

## Features

**Required**

* [x] On dragging the message left:

* [x] Initially, the revealed background color should be gray.
* [x] As the reschedule icon is revealed, it should start semi-transparent and become fully opaque. If released at this point, the message should return to its initial position.
* [x] After 60 pts, the later icon should start moving with the translation and the background should change to yellow.
* [x] Upon release, the message should continue to reveal the yellow background. When the animation it complete, it should show the reschedule options.
* [x] After 260 pts, the icon should change to the list icon and the background color should change to brown.
* [x] Upon release, the message should continue to reveal the brown background. When the animation it complete, it should show the list options.
* [x] User can tap to dismiss the reschedule or list options. After the reschedule or list options are dismissed, you should see the message finish the hide animation.

* [x]  On dragging the message right:

* [x] Initially, the revealed background color should be gray.
* [x] As the archive icon is revealed, it should start semi-transparent and become fully opaque. If released at this point, the message should return to its initial position.
* [x] After 60 pts, the archive icon should start moving with the translation and the background should change to green.
* [x] Upon release, the message should continue to reveal the green background. When the animation it complete, it should hide the message.
* [x] After 260 pts, the icon should change to the delete icon and the background color should change to red.
* [x] Upon release, the message should continue to reveal the red background. When the animation it complete, it should hide the message.


**Optional**

* [x] Panning from the edge should reveal the menu.
* [x] If the menu is being revealed when the user lifts their finger, it should continue revealing.
* [x] If the menu is being hidden when the user lifts their finger, it should continue hiding.
* [x] Tapping on compose should animate to reveal the compose view.
* [x] Tapping the segmented control in the title should swipe views in from the left or right.
* [x] Shake to undo.

**Additional**

* [x] Show actionsheet when canceling out of compose view.
* [x] Segmented controller changes tint with selections. 

## Walkthrough

![mailbox gif](mailbox demo.gif)

GIF created with [LiceCap](http://www.cockos.com/licecap/).



## Notes

Spent too much time with gesture conditionals. Initially had if-statements checking both gesture direction and message location when I really just needed message location. With the compose view, I couldn't figure out an  way to auto-focus on the text field without making screen it's own view and calling the input as a first responder. '
