# fampay_assignment
https://github.com/user-attachments/assets/c69224bc-eba3-4ea1-9303-096b0d74aeb0

Fampay Assignment for making developing a standalone container, that displays a list of Contextual Cards

1) Getx is used Statemanagement 
2) MVC architecture is used
3) All the cards i.e HCs are considered as widgets and placed in widget folder
4) For the api response models has been created
5) for the logic of 
    '- `text` - text to parse
    
    
    e.g. `"Hello {}, you look lonely! Why don't you do {}!"` 
    
    the two `{}`s each represent an entity and would be substituted with attributed text, constructed from `entities`.'

    we split the formatted_title's text and find for {} and replace the entities's text
6) RefreshIndicator is used for pull down refresh, which will call refresh method in controller
7) For Remind later action in HC3, we use id, hide it by replacing HC3 by SizedBox
8) http package is used for api calling
9) HC1 there are 3 cases 
    - if only one item is there
    - if multiple items are there with is_scrollable false
    - if multiple items are there with is_scrollable true, all these cases are handled in the code
10) At various places in the response the color, font_size etc are not specified, hence i took it by myself
11) The HC9 has fixed height and dynamic width
12) The HC5 has full width with dynamic height
13) for the long_press animation on HC3, i have use stack and animated container, in the stack firstly i placed the action container and then placed HC3 on the top of it using Animated_container, when we long_press on it, the width of HC3 will be reduced and hence ActionWidget will be visible
14) for parsing the hex color i have created a method hexToColor() in core folder. It accepts the string hex value and convert it into #RRGGBB format
