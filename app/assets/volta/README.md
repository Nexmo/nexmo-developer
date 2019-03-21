# Volta - Vonage Design System

## Quick start

- Add at least the `CSS`, `JS`, `symbol` and `fonts` folders to your project
- Call `volta.css` (or volta.min.css) and `volta.js` (or volta.min.js) in all your files 
- Refer to the [documentation](http://vonage-ds.herokuapp.com) (user: vonage, password: vonage) to write your markup correctly so that the styles will be applied

```html
<link rel="stylesheet" href="path-to-volta/css/volta.css"/>

<script type="text/javascript" src="path-to-volta/js/volta.js"></script>
<!-- The next two files are needed just for tooltips - read more below -->
<script type="text/javascript" src="path-to-volta/js/popper.min.js"></script>
<script type="text/javascript" src="path-to-volta/js/tooltip.min.js"></script>

<!-- Initialise the JavaScript - ONLY WHAT YOU NEED -->
<script type="text/javascript">
	Volta.init(['accordion', 'modal', 'tooltip', 'callout', 'dropdown', 'tab', 'menu', 'menuCollapse']);
</script>
```

## Advanced start (aka What's included)

The Volta package provides you with options. 


### CSS
About the CSS, you can choose between a compiled and minified version, and you can choose to use the addons (we have an addon for PrismJS at the moment, for which you'll find more details on the [docs](http://vonage-ds.herokuapp.com/codesnippets-prism.html))

```md
├── css/
│   ├── volta.css
│   ├── volta.min.css
│   ├── addons/
│   │   ├── volta-prism.css
```


### SASS
We also provide you with the original code snippets in SASS. This could be of interest to you if:
- You only need to use a few components and you want to pick and choose what you import
- You wish to use our variables and utility classes in the custom CSS you might have to write

**Remember that if you are compiling SASS you should always use an autoprefixer**

```md
├── sass/
│   ├── volta.sass
│   ├── lib/
│   │   ├── grid.sass
│   │   ├── icons.sass
│   │   ├── mediaqueries.sass 	// contains our breakpoints and useful classes for responsive behaviour
│   │   ├── reset.sass 			
│   │   ├── type.sass 			// contains all our typography rules
│   │   ├── variables.sass 		// contains all our color and spacing variables
│   ├── components/
│   │   ├── *Individual files for each component*
```


### JavaScript

The same applies to JavaScript. Only a handful of components need it to work, so it's up to you if you want to be quick and import our compiled or minified version, or if you want to pick and choose the specific components.

Whichever you choose, **JavaScript needs to be initialised**, it's not enough to just include it

#### Example

Let's say you want just the modals. You need to include `volta.code.js` and the modal file, then initialise the modal:

```html

<script type="text/javascript" src="path-to-volta/js/volta.core.js"></script>
<script type="text/javascript" src="path-to-volta/js/components/volta.modal.js"></script>

<script type="text/javascript">
	Volta.init(['modal'])
</script>
```

**Tooltips require a bit extra love**, you'll have to include also `popper.min.js` and `tooltip.min.js` who make sure the tooltips will always be on sceen and in the right position responsively.

```html
<script type="text/javascript" src="path-to-volta/js/popper.min.js"></script>
<script type="text/javascript" src="path-to-volta/js/tooltip.min.js"></script>
```

#### Addons

In this folder you'll also find addons. At the moment these are Table Sorter (which requires jQuery to work and you'll have to import that separately) and Prism (which we support in our styling for code highlighting). These are optional 

```md
├── js/
│   ├── volta.js
│   ├── volta.min.js
│   ├── volta.core.js
│   ├── popper.min.js
│   ├── tooltip.min.js
│   ├── components/
│   │   ├── volta.accordion.js
│   │   ├── volta.callout.js
│   │   ├── volta.dropdown.js
│   │   ├── volta.modal.js
│   │   ├── volta.tab.js
│   │   ├── volta.tooltip.js
│   │   ├── side-navigation/
│   │   │   ├── volta.menu.js
│   │   │   ├── volta.menu.collapse.js
│   ├── addons/
│   │   ├── jquery.tablesorter.js
│   │   ├── prism.js
```

## Contributing

More components are always in development, but if you want to contribute you're very welcome and we have a github repo for that purpose. Just ping [Benny](benny.zuffolini@vonage.com) if you wish to be added to it.

## Creators

[Benny Zuffolini](benny.zuffolini@vonage.com) (CSS & UX)
[Ken Sakurai](ken.sakurai@vonage.com) (Design)
[Karen Manktelow](karen.manktelow@vonage.com) (JS)