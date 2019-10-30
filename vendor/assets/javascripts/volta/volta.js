/**
 * Copyright (c) 2001-present, Vonage.
 *	
 * Core of volta
 */
'use strict';
var Volta;

Volta = function (){
	return {
		_closest: closest,
		_hasClass: hasClass,
		init: initialise,
		_isMobile: isMobileDevice,
		_getElementSiblings: getElementSiblings,
		_getFunction: getFunctionFromString,
		_removeFromArr: removeFromArr
	}

	/**   
	 *	@private
	 *	
	 *	@description Finds the first ancestor of the given element, matching a specific selector.
	 *	@param {HTMLElement} element Starting element
	 *	@param {string} selector Selector to find (can be .class, #id, div...)
	 *	@param {string} stopSelector Selector to stop searching on (can be .class, #id, div...) 
	 *  @returns {HTMLElement|null} The matched element or null if no element is found
	 */
	function closest(element, selector, stopSelector) {
		var match = null;
		while (element) {
		if (element.matches(selector)) {
	  		match = element;
	  		break
		} else if (stopSelector && element.matches(stopSelector)) {
	  		break
		}
			element = element.parentElement;
		}
		return match;
	}

	/**
	 *	@private
	 *	@description Given the name of a function returns the function itself
	 *	@param {string} callbackFnName The function name e.g. "testFunction" OR "test.function" 
	 *  @returns {Function} 
	 */
	function getFunctionFromString(fnName) {
	    var fn;
		
		if(fnName) {
			var fnNames = fnName.split(".");
			var fn = window;
			for(var i = 0; i < fnNames.length; i++) {
				fn = fn[fnNames[i]];
			}
		}

		return fn;
	}

	/**   
	 *	@private
	 *	@description Get all siblings of an element
	 *	@param {HTMLElement} el 
	 */
	function getElementSiblings(element) {
	    var siblings = [];
	    element = element.parentNode.firstChild;
	    do { 
	    	if(element.nodeType === 1) {
	    		siblings.push(element); 
	    	}
	    } while (element = element.nextSibling);
	    return siblings;
	}

	/**   
	 *	@private
	 *	
	 *	@description Check if the given element has a particular class
	 *	@param {HTMLElement} el Element to evaluate
	 *	@param {string} className Class name to check for
	 *  @returns {boolean} True if the element has the class or false if not
	 */
	function hasClass(element, className) {
		if(!element) {
			return false;
		}
		return (" " + element.className + " ").replace(/[\n\t]/g, " ").indexOf(" " + className+ " ") > -1;
	}

	/**   
	 *	@private
	 *	
	 *	@description Is the current device a mobile
	 *  @returns {boolean} True if mobile false if not
	 */
	function isMobileDevice() {
		var isMobile = /Android|webOS|iPhone|iPad|BlackBerry|Windows Phone|Opera Mini|IEMobile|Mobile/i;

		return isMobile.test(navigator.userAgent);
	}

	/**   
	 *	@public
	 *	
	 *	@description Initailise volta with required components
	 *	@param {Array} components Array of strings, names of the components to initialise
	 */ 
	function initialise(components) {
		polyfilsForIE11();
		
		if(components.indexOf('accordion') !== -1){
			if(Volta.accordion) {
				Volta.accordion.init();
			} else {
				console.warn('Volta: volta.accordion.js component missing')
			}
		}
		if(components.indexOf('callout') !== -1){
			if(Volta.callout) {
				Volta.callout.init();
			} else {
				console.warn('Volta: volta.callout.js component missing')
			}
		}
		if(components.indexOf('badge') !== -1){
			if(Volta.badge) {
				Volta.badge.init();
			} else {
				console.warn('Volta: volta.badge.js component missing')
			}
		}
		if(components.indexOf('dropdown') !== -1){
			if(Volta.dropdown) {
				Volta.dropdown.init();
			} else {
				console.warn('Volta: volta.dropdown.js component missing')
			}
		}
		if(components.indexOf('flash') !== -1){
			if(Volta.flash) {
				Volta.flash.init();
			} else {
				console.warn('Volta: volta.dropdown.js component missing')
			}
		}
		if(components.indexOf('menu') !== -1){
			if(Volta.menu) {
				Volta.menu.init();
			} else {
				console.warn('Volta: volta.menu.js component missing')
			}
		}
		if(components.indexOf('menuCollapse') !== -1){
			if(Volta.menuCollapse) {
				Volta.menuCollapse.init();
			} else {
				console.warn('Volta: volta.menuCollapse.js component missing')
			}
		}
		if(components.indexOf('modal') !== -1){
			if(Volta.modal) {
				Volta.modal.init();
			} else {
				console.warn('Volta: volta.modal.js component missing')
			}
		}
		if(components.indexOf('tab') !== -1){
			if(Volta.tab) {
				Volta.tab.init();
			} else {
				console.warn('Volta: volta.tab.js component missing')
			}
		}
		if(components.indexOf('tooltip') !== -1){
			if(Volta.tooltip) {
				Volta.tooltip.init();
			} else {
				console.warn('Volta: volta.tooltip.js component missing')
			}
		}
	}

	/**   
	 *	@private
	 *	
	 *	@description Remove an element from an array
	 *  @param {Array} arr The array containing the element
	 *  @param {Element} element The element to remove
	 *  @returns {Array} The array minus the element
	 */
	function removeFromArr(arr, element) {
		var index = arr.indexOf(element);
  		arr.splice(index, 1);
  		return arr;
	}

	/**   
	 *	@private
	 *	
	 */ 
	function polyfilsForIE11() {
		if (window.NodeList && !NodeList.prototype.forEach) {
		    NodeList.prototype.forEach = function (callback, thisArg) {
		        thisArg = thisArg || window;
		        for (var i = 0; i < this.length; i++) {
		            callback.call(thisArg, this[i], i, this);
		        }
		    };
		}
		
		if (!Element.prototype.matches) {
		    Element.prototype.matches = 
		        Element.prototype.matchesSelector || 
		        Element.prototype.mozMatchesSelector ||
		        Element.prototype.msMatchesSelector || 
		        Element.prototype.oMatchesSelector || 
		        Element.prototype.webkitMatchesSelector ||
		        function(s) {
		            var matches = (this.document || this.ownerDocument).querySelectorAll(s),
		                i = matches.length;
		            while (--i >= 0 && matches.item(i) !== this) {}
		            return i > -1;            
		        };
		}
	}
}();

/**
 * Copyright (c) 2001-present, Vonage.
 *
 * Accordions (requires core)
 */

'use strict';

Volta.accordion = function () {
	var _class = {
		standard: {
			container: 'Vlt-accordion',
			containerGroup: 'Vlt-accordion--group',
			trigger: 'Vlt-accordion__trigger',
			triggerActive: 'Vlt-accordion__trigger_active',
			content: 'Vlt-accordion__content',
			contentOpen: 'Vlt-accordion__content_open',
			contentOpening: 'Vlt-accordion__content_opening',
			contentClosing: 'Vlt-accordion__content_closing',
		},
		js: {
			content: 'Vlt-js-accordion__content',
			contentOpen: 'Vlt-js-accordion__content_open',
			contentOpening: 'Vlt-js-accordion__content_opening',
			contentClosing: 'Vlt-js-accordion__content_closing',
			trigger: 'Vlt-js-accordion__trigger',
			triggerActive: 'Vlt-js-accordion__trigger_active'
		}
	}

	function Accordion() {}

	Accordion.prototype = {
		init: function(element, suppressClickHandler, triggerElem) {
			if(this.isStandard) {
				this._initStandard(element, suppressClickHandler);
			} else {
				this._initJs(element, suppressClickHandler, triggerElem);
			}
		},
		_initStandard: function(element, suppressClickHandler) {
			var self = this;

			if(!suppressClickHandler) {
				element.querySelectorAll('.' + _class.standard.trigger).forEach(function(trigger) {
					var parent = Volta._closest(trigger, '.' + _class.standard.container, _class.standard.container);

					if(parent && parent == element) {
						trigger.addEventListener('click', function(){
							self.toggle(trigger);
						});
					}
				});
			}
		},
		_initJs: function(element, suppressClickHandler, triggerElem) {
			this._content = element;

			if(triggerElem) {
				this.trigger = triggerElem;
			} else if(this._content.dataset.trigger) {
				var triggerId = this._content.dataset.trigger;
				this.trigger = document.querySelector('#' + triggerId);
			} else {
				console.warn("Volta: js accordion trigger missing");
			}

			var self = this;
			if(!suppressClickHandler && this.trigger) {
				this.trigger.addEventListener('click', function(){
					self.toggle();
				});
			}
		},
		close: function(trigger) {
			var panel = this._content || trigger.nextElementSibling;
			var trigger = this.trigger || trigger;
			var classes = this.trigger ? _class.js : _class.standard;

			trigger.classList.remove(classes.triggerActive);
			panel.classList.add(classes.contentClosing);

			panel.style.height = window.getComputedStyle(panel).height;
			panel.offsetHeight; // force repaint
			panel.style.height = '0px';
			panel.classList.remove(classes.contentOpen);

			var self = this;
			panel.addEventListener('transitionend', function closingTransitionEndEvent(event) {
				if (event.propertyName == 'height' && Volta._hasClass(panel, classes.contentClosing)) {
					panel.classList.remove(classes.contentClosing);
					panel.style.height = '0px';
					panel.removeEventListener('transitionend', closingTransitionEndEvent, false);

					if(self.isGroup && self._isTriggerActive(trigger,  true)){
						self._activeGroupTrigger = undefined;
					}
				}
			}, { passive: true, once: true });
		},
		isOpening: false,
		_activeGroupTrigger: undefined,
		_isTriggerActive: function(trigger, match) {
			return (this.isGroup && this._activeGroupTrigger && (!match || this._activeGroupTrigger === trigger)) || Volta._hasClass(trigger, _class.standard.triggerActive);
		},
		open: function(trigger) {
			if(!this.trigger) {
				if(this._isTriggerActive(trigger, false)) {
				this.close(this._activeGroupTrigger || trigger);
				}
				if(this.isGroup) {
					this._activeGroupTrigger = trigger;
				}
			}

			var trig = this.trigger || trigger;
			var classes = this.trigger ? _class.js : _class.standard;
			var panel = this._content || trig.nextElementSibling;

			this.isOpening = true;

			trig.classList.add(classes.triggerActive);
			panel.classList.add(classes.contentOpening);

			var startHeight = panel.style.height;
			panel.style.height = 'auto';
			var endHeight = window.getComputedStyle(panel).height;
			panel.style.height = startHeight;
			panel.offsetHeight; // force repaint
			panel.style.height = endHeight;

			var self = this;
			panel.addEventListener('transitionend', function openingTransitionEndEvent(event) {
				if (event.propertyName == 'height' && Volta._hasClass(panel, classes.contentOpening)) {
					panel.style.height = 'auto';
					panel.classList.remove(classes.contentOpening);
					panel.classList.add(classes.contentOpen);
					panel.removeEventListener('transitionend', openingTransitionEndEvent, false);
					self.isOpening = false;
				}
			}, { passive: true, once: true });
		},
		toggle: function(trigger) {
			if(this.isOpening) {
				return false;
			}
			if((this.trigger && Volta._hasClass(this._content, _class.js.contentOpen))
				|| (!this.trigger && this._isTriggerActive(trigger, true))) {
				this.close(trigger);
			} else {
				this.open(trigger);
			}
		}
	}

	return {
		create: create,
		init: initialise
	}

	/**
	 *	@public
	 *
	 *	@description Create an individual accordion object
	 *	@param {Element|string} elementOrId Reference to the accordion content element or the id
	 *	@param {Boolean} suppressClickHandler Whether click events should be attached on creation
	 *	@param {Element} trigger Private required for legacy accordions
	 *	@param {Boolean} isGroup Private required for legacy accordions
	 *  @return {Object}
	 */
	function create(elementOrId, suppressClickHandler, trigger, isGroup, isStandard) {
		if(!elementOrId) {
			console.warn("Volta: no parameter supplied to accordion.create()");
		}
		var accordion = Object.create(Accordion.prototype, {});
		var element = getElement(elementOrId);

		Object.defineProperties(accordion, {
			'isStandard': {
				value: isStandard || Volta._hasClass(element, _class.standard.container),
				writable: false
			}
		});

		Object.defineProperties(accordion, {
			'isGroup': {
				value: isGroup,
				writable: false
			}
		});

		accordion.init(element, suppressClickHandler, trigger);

		return accordion;
	}

	/**
	 *	@public
	 *
	 *	@description Initialise all the accordions on the current screen
	 */
	function initialise() {
		//standard
		var standardAccordions = document.querySelectorAll('.' + _class.standard.container);

		if(standardAccordions.length) {
			standardAccordions.forEach(function(accordion){
				create(accordion, false, null, Volta._hasClass(accordion, _class.standard.containerGroup), true);
			});
		}

		//js
		var triggers = document.querySelectorAll('.' + _class.js.trigger + '[data-accordion]');
		if(triggers.length > 0) {
			triggers.forEach(function(trigger) {
				var accordionId = trigger.dataset.accordion;
				if(!accordionId) {
					return;
				}
				create(accordionId, false, trigger);
			});
		}

		//js - legacy
		var jsAccordions = document.querySelectorAll('.' + _class.js.content + '[data-trigger]');
		if(jsAccordions.length > 0) {
			jsAccordions.forEach(function(jsLegacy) {
				create(jsLegacy);
			});
		}
	}

	/**
	 *	@private
	 */
	function getElement(elementOrId) {
	 	var element;

		if(elementOrId.classList) {
			element = elementOrId;
		} else if (elementOrId.substring(0, 1) === "#") {
			element = document.querySelector(elementOrId);
		} else {
			element = document.querySelector('#' + elementOrId);
		}

		return element;
	}
}();

/**
 * Copyright (c) 2001-present, Vonage.
 *	
 * Badges (requires core)
 */

'use strict';

Volta.badge = function () {	
	var _class = {
		badge: 'Vlt-badge',
		dismiss: 'Vlt-badge__dismiss',
		dismissed: 'Vlt-badge--dismissed'
	}

	return {
		dismiss: dismiss,
		init: attachBadgeHandlers
	}

	/**   
	 *	@public
	 *	
	 *	@description Attach a one time listener to dismissable badges
	 */
	function attachBadgeHandlers() {
		document.querySelectorAll('.' + _class.dismiss).forEach(create);
	}

	/**   
	 *	@private
	 *	
	 *	@description Create a badge
	 *	@param {HTMLElement} badge
	 */
	function create(badgeOrDismiss) {
		var badge, badgeDismiss;

		if(Volta._hasClass(badgeOrDismiss, _class.badge)) {
			badge = badgeOrDismiss;
			badgeDismiss = badge.querySelector('.' + _class.dismiss);
		} else if(Volta._hasClass(badgeOrDismiss, _class.dismiss)){
			badgeDismiss = badgeOrDismiss;
			badge = badgeDismiss.parentElement;
		}

		badgeDismiss.addEventListener('click', function(){
			dismiss(badge);
		}, { once : true});
	}

	/**   
	 *	@public
	 *	
	 *	@description Dismiss a badge
	 *	@param {HTMLElement} badge
	 */
	function dismiss(badge) {
		badge.classList.add(_class.dismissed);

		if(badge.dataset.callback) {
			return Volta._getFunction(badgeWrapper.dataset.callback)();
		}
	}
}();
/**
 * Copyright (c) 2001-present, Vonage.
 *	
 * Callouts (requires core)
 */

'use strict';

Volta.callout = function () {	
	var _class = {
		callout: 'Vlt-callout',
		dismiss: 'Vlt-callout__dismiss',
		dismissed: 'Vlt-callout--dismissed'
	}

	return {
		dismiss: dismiss,
		init: attachCalloutHandlers
	}

	/**   
	 *	@public
	 *	
	 *	@description Attach a one time listener to dismissable callouts
	 */
	function attachCalloutHandlers() {
		document.querySelectorAll('.' + _class.dismiss).forEach(create);
	}

	/**   
	 *	@private
	 *	
	 *	@description Create a callout
	 *	@param {HTMLElement} callout
	 */
	function create(calloutOrDismiss) {
		var callout, calloutDismiss;

		if(Volta._hasClass(calloutOrDismiss, _class.callout)) {
			callout = calloutOrDismiss;
			calloutDismiss = callout.querySelector('.' + _class.dismiss);
		} else if(Volta._hasClass(calloutOrDismiss, _class.dismiss)){
			calloutDismiss = calloutOrDismiss;
			callout = calloutDismiss.parentElement;
		}

		calloutDismiss.addEventListener('click', function(){
			dismiss(callout);
		}, { once : true});
	}

	/**   
	 *	@public
	 *	
	 *	@description Dismiss a callout
	 *	@param {HTMLElement} callout
	 */
	function dismiss(callout) {
		callout.classList.add(_class.dismissed);

		if(callout.dataset.callback) {
			return Volta._getFunction(calloutWrapper.dataset.callback)();
		}
	}
}();
/**
 * Copyright (c) 2001-present, Vonage.
 *
 * Dropdowns (requires core)
 */

'use strict';

Volta.dropdown = function () {
	var _class = {
		wrapper: 'Vlt-dropdown',
		block: 'Vlt-dropdown__block',
		btn: 'Vlt-dropdown__btn',
		dismissed: 'Vlt-callout--dismissed',
		expanded: 'Vlt-dropdown--expanded',
		label: 'Vlt-dropdown__label',
		link: 'Vlt-dropdown__link',
		noCloseLink: 'Vlt-dropdown__link--noclose',
		noCloseBlock: 'Vlt-dropdown__block--noclose',
		panel: 'Vlt-dropdown__panel',
		panelContent: 'Vlt-dropdown__panel__content',
		selection: 'Vlt-dropdown__selection',
		switch: 'Vlt-switch',
		switchSlider: 'Vlt-switch__slider'
	}

	function Dropdown() {}

	Dropdown.prototype = {
		init: function(element, supressClickHandler) {
			this.dropdown = element;
			this.selection = this.dropdown.querySelector('.' + _class.selection);
			this.isSelectionVisible = !!this.selection;
			this.btn = this.dropdown.querySelector('.' + _class.btn);
			this._suppress = supressClickHandler;

			if(!this._suppress) {
				this._addEventListener();
			}
		},
		_addEventListener: function(){
			var openHandler = this.open.bind(this);
			this.dropdown.addEventListener('click', openHandler, { once: true })
		},
		close: function(text) {
			if(text) {
				this._setDropdownSelectionText(text);
			}
			this.dropdown.classList.remove(_class.expanded);

			if(!this._suppress){
				this._addEventListener();
			}

		},
		_closeEventHandler: undefined,
		_closeEvent: function(e) {
			var targetIsPanel = Volta._hasClass(e.target, _class.panel);
			var parentIsPanel = Volta._closest(e.target, '.' + _class.panelContent, _class.panel) !== null;
			var parentLink = Volta._closest(e.target, '.' + _class.link, _class.wrapper);
			var parentIsLink = parentLink && parentLink.length === 1;
			var isSwitchSlider = Volta._hasClass(e.target, _class.switchSlider);
			var isParentSwitch = Volta._closest(e.target,'.' + _class.switch, _class.link);
			var isNoClose = Volta._hasClass(e.target, _class.noCloseLink) || Volta._hasClass(e.target, _class.noCloseBlock);
			var isNoCloseParent = Volta._closest(e.target,'.' + _class.noCloseLink, _class.link) || Volta._closest(e.target,'.' + _class.noCloseBlock, _class.noCloseBlock);
			var isInput = e.target instanceof HTMLInputElement;

			if(!targetIsPanel && !parentIsPanel && !parentIsLink && !isNoClose && !isInput && !isNoCloseParent) {
				e.preventDefault();
				e.stopPropagation();
			}

			if(isSwitchSlider || isParentSwitch || isNoClose || isInput || isNoCloseParent) {
				return null;
			}

			var text;
			if(parentIsPanel && Volta._hasClass(e.target, _class.label)) {
				text = e.target.innerHTML;
			} else if (parentIsPanel) {
				var label = e.target.querySelector('.' + _class.label);
				if(label) {
					text = label.innerHTML;
				}
			}

			this.close(text);

			document.querySelector('body').removeEventListener('click', this._closeEventHandler );
		},
		open: function(event) {
			if(event) {
				event.preventDefault();
				event.stopPropagation();
			}

			this.dropdown.classList.add(_class.expanded);

			if(!this._suppress){
				this._closeEventHandler = this._closeEvent.bind(this);
				document.querySelector('body').addEventListener('click', this._closeEventHandler );
			}
		},
		_setDropdownSelectionText: function(text) {
			if(this.isSelectionVisible) {
				this.selection.innerText = text;
			} else {
				this.btn.innerText = text;
				this.btn.value = text;
			}
		},
		_suppress: false
	}

	return {
		create: create,
		init: attachDropdownHandlers
	}

	/**
	 *	@public
	 *
	 *	@description Attach a listeners to dropdowns
	 */
	function attachDropdownHandlers() {
		document.querySelectorAll('.' + _class.wrapper).forEach(attachHandler);

		function attachHandler(dropdown) {
			create(dropdown);
		}
	}

	/**
	 *	@private
	 *
	 *	@description Create a dropdown element
	 *  @param {HTMLElement} element
 	 */
	function create(element){
		var dropdown = Object.create(Dropdown.prototype, {})
		dropdown.init(element);
		return dropdown;
	}
}();
/**
 * Copyright (c) 2001-present, Vonage.
 *	
 * Tabs (requires core)
 */

'use strict';

Volta.flash = function () {	
	var _class = {
		flash: 'Vlt-flash',
		trigger: 'Vlt-flash-trigger',
		visible: 'Vlt-flash_visible'
	}

	var gap = 20,
		openBottomFlashes = [],
		openTopFlashes = [],
		timeouts =[];

	return {
		closeAll: closeAll,
		init: attachFlashHandlers,
		show: show
	}

	/**   
	 *	@public
	 *	
	 *	@description Attach a click listener to each flash's trigger on the screen
	 *  @param {HTMLElement} element 
	 */
	function attachFlashHandlers() {
		var triggers = document.querySelectorAll('.' + _class.trigger);

		if(triggers.length === 0) {
			return;
		}

		triggers.forEach(attachHandler);
		
		function attachHandler(trigger) {
			trigger.addEventListener('click', function() {
				if(trigger.dataset.flash) {
					var flash = document.querySelector('#' + trigger.dataset.flash);
					show(flash);
				} else {
					console.warn("Volta: flash trigger is missing data-flash attribute");
				}				
			});
		}
	}

	/**   
	 *	@public
	 *	
	 *	@description Close all open flashes
	 */
	function closeAll() {		
		if(timeouts.length > 0) {
			timeouts.forEach(function(timeout){
				clearTimeout(timeout);
			});
		}
		if(openBottomFlashes.length > 0) {
			clearQueue(openBottomFlashes);
		}
		if(openTopFlashes.length > 0) {
			clearQueue(openTopFlashes);
		}
		
		timeouts = [];
		openBottomFlashes = [];
		openTopFlashes = [];

		function clearQueue(elementArr) {
			elementArr.forEach(function(element){
				_hide(element);
			});	
			elementArr = [];
		}
	}

	/**   
	 *	@public
	 *	
	 *	@description Show the flash
	 *  @param {HTMLElement} element 
	 */
	function show(elementOrId, time) {
		if(!elementOrId || elementOrId.length == 0) {
			return;
		}
		
		time = time || 5000;

		var element = !elementOrId.classList ? document.querySelector('#' + elementOrId) : elementOrId;
		var position = Volta._hasClass(element, 'Vlt-flash--bottom') ? 'bottom' : 'top';
		var arr = position === 'bottom' ? openBottomFlashes : openTopFlashes;

		if(arr.indexOf(element) !== -1) {
			return;
		}
		
		_setFlashPosition(arr, element, position);

		arr.push(element);
				
		element.classList.add(_class.visible);
		
		var hideTimeout = setTimeout(function(){
			_hide(element, true);
			Volta._removeFromArr(timeouts, hideTimeout);
		}, time);

		timeouts.push(hideTimeout);
	}

	/**   
	 *	@private
	 *	@description Hide the flash
	 *  @param {HTMLElement} element 
	 */
	function _hide(element, shouldRemove) {
		var position = Volta._hasClass(element, 'Vlt-flash--bottom') ? 'bottom' : 'top';
		var arr = position === 'bottom' ? openBottomFlashes : openTopFlashes;
		
		if(shouldRemove) {
			Volta._removeFromArr(arr, element);
		}

		_updateFlashPositions(arr, element, position);

		element.style[position] = '';
		element.classList.remove(_class.visible);
	}

	/**   
	 *	@private
	 *	@description Set the position of the flash
	 *  @param {HTMLElement} element 
	 */
	function _setFlashPosition(arr, element, position) {
		var positionPx = arr.reduce(function(px, flash) {
			return px + flash.clientHeight;				
		}, 0);
		if(positionPx > 0) {
			element.style[position] = (gap * arr.length) + gap + positionPx + 'px';
		}
	}

	/**   
	 *	@private
	 *	@description Update the position of all the visible flashes
	 *  @param {Array} arr
	 *  @param {HTMLElement} element 
	 *  @param {string} position 
	 */
	function _updateFlashPositions(arr, element, position){
		if(arr.length > 0) {
			var elementHeight = element.clientHeight;

			arr.forEach(function(flash) {
				var newPosition;

				if(position === 'bottom') {
					newPosition = Number(flash.style.bottom.substring(0, flash.style.bottom.length - 2));
				} else {
					newPosition = flash.getBoundingClientRect()[position];				
				}
				flash.style[position] = newPosition -elementHeight - gap + "px";		
			});
		}
	}
}();
/**
 * Copyright (c) 2001-present, Vonage.
 *
 * Modals (requires core)
 */

'use strict';

Volta.modal = function () {
	var _class = {
		auto: 'Vlt-modal--auto',
		bodyModalOpen: 'Vlt-body--modal-open',
		cancel: 'Vlt-modal__cancel',
		confirm: 'Vlt-modal__confirm',
		content: 'Vlt-modal__content',
		modal: 'Vlt-modal',
		out: 'Vlt-modal--out',
		panel: 'Vlt-modal__panel',
		trigger: 'Vlt-modal-trigger',
		visible: 'Vlt-modal_visible',
		dismiss: 'Vlt-modal__dismiss',
	}

	var body,
		dismissModalHandler,
		cancelModalHandler,
		confirmModalHandler,
		escHandler,
		clickHandler,
		escAttached;

	function Modal() {}

	Modal.prototype = {
		attachButtons: function() {
			var _this = this;
			_this.dismissBtn = _this.modal.querySelector('.' + _class.dismiss);

		    if(_this.dismissBtn) {
		    	dismissModalHandler = dismissModal.bind(_this);
		    	_this.dismissBtn.addEventListener('click', dismissModalHandler);
		    }

		    _this.cancelBtn = _this.modal.querySelector('.' + _class.cancel);

		    if(_this.cancelBtn) {
	    		cancelModalHandler = cancelModal.bind(_this);
		    	_this.cancelBtn.addEventListener('click', cancelModalHandler);
		    }

		    _this.confirmBtn = _this.modal.querySelector('.' + _class.confirm);

		    if(_this.confirmBtn) {
		    	confirmModalHandler = confirmModal.bind(_this);
		    	_this.confirmBtn.addEventListener('click', confirmModalHandler);
		    }
		},
		html: function(newHtml) {
			this.modal.innerHTML = newHtml;
			return this;
		},
		init: function(elementOrId) {
			if(elementOrId.length) {
				this.modal = document.querySelector('#' + elementOrId);
			} else {
				this.modal = elementOrId;
			}

			this._callback = Volta._getFunction(this.modal.dataset.callback);
		},
		open: function(e) {
		    if(e && e.preventDefault) {
		        e.preventDefault();
		    	e.stopPropagation();
		    }

		    this.modal.classList.remove(_class.out);
		    this.modal.classList.add(_class.visible);
		    this.attachButtons();

		    disableScroll();

		    if(!escAttached && !this.modal.dataset.disableEsc || this.modal.dataset.disableEsc === "false") {
		    	escHandler = closeModalOnEscape.bind(this);
		   		body.addEventListener('keyup', escHandler, { once: true });
		   		escAttached = true;
		    }

		    if(!this.modal.dataset.disableClick || this.modal.dataset.disableClick === "false") {
		    	clickHandler = closeModalOnClick.bind(this);
		   		this.modal.addEventListener('click', clickHandler, { once: true });
		    }
		},
		dismiss: function(e, confirmed) {
			var _this = this;

			if(e && e.preventDefault) {
		    	e.preventDefault();
		    	e.stopPropagation();
			}

			enableScroll();

			if(_this.modal){
				_this.modal.classList.remove(_class.visible);
				_this.modal.classList.add(_class.out);
			}

			if(_this._callback) {
				_this._callback(confirmed);
			}

			removeModal(_this);
		}
	}

	return {
		create: create,
		init: attachModalHandlers
	}

	/**
	 *	@public
	 *
	 *	@description Attach a click listener to each modals trigger on the screen, which will open the modal
	 */
	function attachModalHandlers() {
		if(!body) {
			body = document.querySelector('body');
		}

		var triggers = document.querySelectorAll('.' + _class.trigger);

		if(triggers.length > 0) {
			triggers.forEach(attachTriggerHandler);
		}

		//Not the recommended way to use modals
		var modals = document.querySelectorAll('.' + _class.modal);

		if(modals.length > 0) {
			modals.forEach(attachModalHandler);
		}

		function attachModalHandler(modal) {
			if(Volta._hasClass(modal, _class.auto)) {
				var trigger = document.querySelector('#' + modal.dataset.trigger);
				trigger.addEventListener('click', function() {
					create(modal).open();
				});
			}
		}

		function attachTriggerHandler(trigger) {
			if(trigger.dataset.modal) {
				var modal = document.querySelector('#' + trigger.dataset.modal);

				if(!modal) {
					console.warn('Volta: modal ' + trigger.dataset.modal + ' cannot be found');
				}

				trigger.addEventListener('click', function() {
					create(modal).open();
				});
			}
		}
	}

    /**
	 *	@private
	 *
	 *	@description Close the modal, triggered by cancel button, passes false to callback function
	 *  @param {event} e
	 */
    function cancelModal(e) {
		return this.dismiss(e, false);
	}

	/**
	 *	@private
	 *
	 *	@description Close the modal, triggered by confirm button, passes true to callback function
	 *  @param {event} e
	 */
    function confirmModal(e) {
		return this.dismiss(e, true);
	}

    /**
	 *	@private
	 *
	 *	@description Close the modal, triggered by 'x' button, passes false to callback function
	 *  @param {event} e
	 */
    function dismissModal(e) {
		return this.dismiss(e, false);
    }

    /**	@private
	 *
	 *	@description Close the modal, triggered by 'esc' key, passes false to callback function
	 *  @param {event} e
	 */
    function closeModalOnEscape(e){
    	if(e && e.keyCode === 27) {
    		this.dismiss(e, false);
    	} else {
			body.addEventListener('click', escHandler, { once: true });
    	}
    }


    /**	@private
	 *
	 *	@description Close the modal, triggered by 'body click, passes false to callback function
	 *  @param {event} e
	 */
    function closeModalOnClick(e){
    	if(!Volta._hasClass(e.target, _class.trigger)
			&& !Volta._closest(e.target, '.' + _class.trigger, '.' + _class.trigger)
    		&& !Volta._closest(e.target, '.' + _class.panel, '.' + _class.panel)) {
    		this.dismiss(e, false);
    	} else if(this.modal) {
			this.modal.addEventListener('click', clickHandler, { once: true });
    	}
    }

    /**
	 *	@public
	 *
	 *	@description Create the modal object
	 *  @param {HTMLElement|string} elementOrId Reference to the modal element or the id
	 *. @return {Object} A modal object
	 */
    function create(elementOrId) {
    	if(!body) {
			body = document.querySelector('body');
		}
		var modal = Object.create(Modal.prototype, {})
		modal.init(elementOrId);
		return modal;
    }

    /**
	 * Private functions to disable body scroll when modal is open
     */
    function disableScroll() {
	    body.classList.add(_class.bodyModalOpen);
		body.addEventListener('touchmove', preventScroll);
		body.querySelector('main').addEventListener('touchmove', preventScroll);
		body.querySelector('.' + _class.content).addEventListener('touchmove', allowScroll);
    }

    function enableScroll() {
		body.classList.remove(_class.bodyModalOpen);
		body.removeEventListener('touchmove', preventScroll);
		body.querySelector('main').removeEventListener('touchmove', preventScroll);
		body.querySelector('.' + _class.content).removeEventListener('touchmove', allowScroll);
    }

    function allowScroll(e) {
    	e.stopPropagation();
    }

    function preventScroll(e) {
		e.preventDefault();
    }

  	/**
	 *	@private
	 *
	 *	@description Remove the modal after dismiss, makes sure to delete the modal properties so it can be garbage collected, and removes event listeners
	 *  @param {HTMLElement|string} elementOrId Reference to the modal element or the id
	 */
	function removeModal(modal) {
		delete modal.modal;

		if(modal.dismissBtn) {
			modal.dismissBtn.removeEventListener('click', dismissModalHandler);
		}

		if(modal.cancelBtn) {
			modal.cancelBtn.removeEventListener('click', cancelModalHandler);
		}

		if(modal.confirmBtn) {
			modal.confirmBtn.removeEventListener('click', confirmModalHandler);
		}

		if(clickHandler) {
   			body.removeEventListener('click', clickHandler);
    	}

    	if(escHandler) {
    		body.removeEventListener('keyup', escHandler);
    		escAttached = false;
    	}
	}
}();
/**
 * Copyright (c) 2001-present, Vonage.
 *	
 * Tabs (requires core)
 */

'use strict';

Volta.tab = function () {	
	var _class = {
		link: 'Vlt-tabs__link',
		linkJs: 'Vlt-js-tabs__link',
		linkActive: 'Vlt-tabs__link_active',
		linkDisabled: 'Vlt-tabs__link_disabled',
		linkJsActive: 'Vlt-js-tabs__link_active',
		panel: 'Vlt-tabs__panel',
		panelActive: 'Vlt-tabs__panel_active',
		panelJsActive: 'Vlt-js-tabs__panel_active',
		tabs: 'Vlt-tabs',
	}

	function Tabs() {}

	Tabs.prototype = {
		init: function(element, isWrapper) {
			var _this = this,
				tabsHeader,
				tabsContent;

			if(isWrapper) {
				tabsHeader = element.children.item(0);
				tabsContent = element.children.item(1);
			} else {
				_this.isJs = true;
				tabsHeader = element;
				tabsContent = element.dataset.tabContent ? 
					document.querySelector('#' + element.dataset.tabContent)
					: null;
			}
			
			var linkClass = _this.isJs ? _class.linkJs : _class.link;
			_this._links = tabsHeader.querySelectorAll('.' + linkClass);
			_this._panels = tabsContent ? tabsContent.children : undefined;

			this._setActiveElements();

			if(_this._panels && _this._panels.length === _this._links.length) {
				_this._links.forEach(function(link){
					var link = link;

					link.addEventListener('click', function() {
						_this.toggle(link);
					});
				});
			} else if (_this._panels && _this._panels.length > 0) {
				console.log('Volta: Tabs, number of links and panels do not match');
			}
		},
		toggle: function(linkElement) {
			var linkActiveClass = this.isJs ? _class.linkJsActive : _class.linkActive;
			var panelActiveClass = this.isJs ? _class.panelJsActive : _class.panelActive;

			if(!Volta._hasClass(linkElement, _class.linkDisabled) && (!this._activeLink || this._activeLink !== linkElement)) {
				if(this._activeLink) {
					this._activeLink.classList.remove(linkActiveClass);
					this._activePanel.classList.remove(panelActiveClass);		
				}

				this._setActiveElements(linkElement);
				
				this._activeLink.classList.add(linkActiveClass);
				this._activePanel.classList.add(panelActiveClass);

				if(Volta.tooltip) {
					Volta.tooltip.init();
				}
			}		
		},
		_setActiveElements: function(linkElement){
			var linkActiveClass = this.isJs ? _class.linkJsActive :_class.linkActive;

			if(!linkElement) {
				this._activeLink = this._links.item(linkActiveClass);
			} else {
				this._activeLink = linkElement;
			}
			
			var tabIndex;
			var currentNode = 0;

			while(!tabIndex && currentNode < this._links.length) {				
				if(this._links.item(currentNode) === this._activeLink) {
					tabIndex = currentNode;
					break;
				}
				currentNode++;
			}

			if(this._panels) {
				this._activePanel = this._panels.item(tabIndex);
			}
		}	
	}

	return {
		create: create,
		init: attachTabHandlers
	}

	/**   
	 *	@public
	 *	
	 *	@description Attach a listener to the tab header
	 */
	function attachTabHandlers() {
		//traditional tabs
		document.querySelectorAll('.' + _class.tabs).forEach(create);

		document.querySelectorAll('[data-tab-content]').forEach(create);
	}

	/**   
	 *	@public
	 *	
	 *	@description Create a tabs component
	 *  @param {HTMLElement} element 
	 */
	function create(element) {
		var tabs = Object.create(Tabs.prototype, {})

		if(Volta._hasClass(element, _class.tabs)) {
			tabs.init(element, true);
		} else {
			tabs.init(element);
		}
		
		return tabs;
	}
}();
/**
 * Copyright (c) 2001-present, Vonage.
 *	
 * Tooltips (requires popper.js, tooltip.js)
 */
'use strict';

Volta.tooltip = function () {
	var _class = {
		bottom: 'Vlt-tooltip--bottom',
		left: 'Vlt-tooltip--left',
		tooltip: 'Vlt-tooltip',
		top: 'Vlt-tooltip--top',
		right: 'Vlt-tooltip--right'
	}

	var currentTooltip = undefined,
		currentTooltipContent = undefined;

	return {
		create: create,
		init: attachTooltipHandlers
	}

	/**   
	 *	@public
	 *	
	 *	@description Create a Tooltip instance for every Vlt-tooltip
	 */
	function attachTooltipHandlers() {
		document.querySelectorAll('.' + _class.tooltip).forEach(create);				
	}

	/**   
	 *	@public
	 *	
	 *	@description Create a Tooltip instance
	 *	@param {HTMLElement} tooltip
	 *  @return {object} a Tooltip element
	 */
	 function create(tooltip) {
		var placement;

		if (Volta._hasClass(tooltip, _class.bottom)) {
			placement = 'bottom';
		} else if (Volta._hasClass(tooltip, _class.top)) {
			placement = 'top';
		} else if (Volta._hasClass(tooltip, _class.left)) {
			placement = 'left';
		} else if (Volta._hasClass(tooltip, _class.right)) {
			placement = 'right';
		}

		var template = 
			'<div class="Vlt-tooltip--js" role="tooltip">' +
				'<div class="tooltip-arrow Vlt-tooltip__arrow"></div>' + 
				'<div class="tooltip-inner Vlt-tooltip__content"></div>' + 
			'</div>';

		var title = tooltip.title;
		//remove the title so deafult title does not show
		tooltip.title = "";

		return new Tooltip(tooltip, {
			html: true,
			template: template, 
			title: title,
			placement: placement
		});
	}
}();
/**
 * Copyright (c) 2001-present, Vonage.
 *	
 * Menu Collapse (requires core, menu)
 */

'use strict';

Volta.menuCollapse = function () {	
	var _class = {
		animate: 'Vlt-sidenav--animate',
		collapsed: 'Vlt-sidenav--collapsed',
		visible: 'Vlt-sidenav_visible'
	}

	var _id = {
		collapse: '#Vlt-sidenav-collapse-trigger'
	}

	var menuCollapseString = "menuCollapse";

	return {
		attachCloseHandler: attachCloseHandler,
		init: initialise
	}

	/**   
	 *	@private
	 *	
	 *	@description Attach listener to trigger for collapsing the menu
	 */
	function attachMenuCollapseHandler() {
		var collapseTrigger = document.querySelector(_id.collapse);

		if(collapseTrigger) {
			collapseTrigger.addEventListener('click', function(e) {
				e.preventDefault();
				e.stopPropagation();
				
				var hasCollapsedClass = Volta._hasClass(Volta.menu._element, _class.collapsed);
				var isMobile = Volta._hasClass(Volta.menu._element, _class.visible);

				Volta.menu._element.classList.add(_class.animate);
				
				if (isMobile) {
					Volta.menu._element.classList.remove(_class.visible);
				} else if (hasCollapsedClass) {
					unCollapseMenu(Volta.menu._element);
				} else {
					collapseMenu(Volta.menu._element);
				}
			});
		}
	}

	/**   
	 *	@public
	 *	
	 *	@description Attach listener to trigger for closing the menu
	 */
	function attachCloseHandler(expandedMenus) {
		if(document.querySelector('.' + _class.collapsed) && expandedMenus) {
			document.querySelector('body').addEventListener('click', closeMenu, { once: true });
		}

		function closeMenu(e) {
			if(!Volta._hasClass(e.target, Volta.menu._class.link) 
					&& !Volta._hasClass(e.target.parentElement, Volta.menu._class.link)) {
				e.preventDefault();
				e.stopPropagation();

				Volta.menu.closeAll();
			} else {
				document.querySelector('body').addEventListener('click', closeMenu, { once: true });
			}
		}
	}

	/**   
	 *	@private
	 *	
	 *	@description Collapse the expanded menu
	 */
	function collapseMenu() {
		Volta.menu.closeAll();
		Volta.menu.selectActiveTab();

		Volta.menu._element.classList.add(_class.collapsed);

		document.querySelectorAll(Volta.menu._class.trigger).forEach(function(menuItem){
	        menuItem.nextElementSibling.style = "top: " + menuItem.positionTop;
		});

		if(localStorage) {
			localStorage.setItem(menuCollapseString, true);
		}

		var sideTabs = Volta.menu._element.querySelector('.' + Volta.menu._class.sideTabs);

		if(sideTabs) {
			sideTabs.querySelectorAll('.' + Volta.menu._class.sideTabsTrigger).forEach(function(trigger){
				trigger.classList.remove(Volta.menu._class.sideTabsTrigger);
				trigger.classList.add(Volta.menu._class.trigger);
				trigger.addEventListener('click', Volta.menu.showCollapsed);
			});

			sideTabs.querySelectorAll('.' + Volta.menu._class.sideTabsLink).forEach(function(link){
				link.classList.remove(Volta.menu._class.sideTabsLink);
				link.classList.add(Volta.menu._class.link);
			});
		}

		Volta.menu.styleActiveTrigger();
	}

	/**   
	 *	@public
	 *	
	 *	@description Initailise the menu collapsing
	 */
	function initialise() {
		if(!Volta.menu) return;

		attachMenuCollapseHandler();

		var menuCollapsedFlag = localStorage ? localStorage.getItem(menuCollapseString) : false;

		if(menuCollapsedFlag) {
			Volta.menu._element.querySelectorAll('.' + Volta.menu._class.triggerActive).forEach(function(trigger) {
				trigger.classList.remove(Volta.menu._class.triggerActive);
			});
			collapseMenu();
		} else {
			Volta.menu.expand();
		}
	}

	/**
	 *	@public
	 *
	 *	@description Expand the collapsed menu
	 */
	function unCollapseMenu() {
		Volta.menu._element.classList.remove(_class.collapsed);

		if(localStorage) {
			localStorage.removeItem(menuCollapseString);
		}

		var sideTabs = Volta.menu._element.querySelector('.' + Volta.menu._class.sideTabs);

		if(sideTabs) {
			sideTabs.querySelectorAll('.' + Volta.menu._class.trigger).forEach(function(trigger){
				trigger.classList.add(Volta.menu._class.sideTabsTrigger);
				trigger.classList.remove(Volta.menu._class.trigger);
				trigger.removeEventListener('click', Volta.menu.showCollapsed);
			});

			sideTabs.querySelectorAll('.' + Volta.menu._class.link).forEach(function(link){
				link.classList.add(Volta.menu._class.sideTabsLink);
				link.classList.remove(Volta.menu._class.link);
			});
		}

		Volta.menu.expand(true);
	}
}();
/**
 * Copyright (c) 2001-present, Vonage.
 *
 * Menu (requires core)
 */

'use strict';

Volta.menu = function () {
	var _class = {
		mobile: 'Vlt-sidenav__mobile',
		mobileOpen: 'Vlt-body--mobile-menu-open',
		mobileTrigger: 'Vlt-sidenav__mobile-trigger',
		link: 'Vlt-sidemenu__link',
		linkActive: 'Vlt-sidemenu__link_active',
		sideMenu: 'Vlt-sidemenu',
		sideTabs: 'Vlt-sidetabs',
		sideTabsLinkActive: 'Vlt-js-tabs__link_active',
		sideTabsPanel: 'Vlt-js-tabs__panel',
		sideTabsPanelActive: 'Vlt-js-tabs__panel_active',
		sideTabsLink: 'Vlt-sidetabs__link',
		sideTabsTrigger: 'Vlt-sidetabs__trigger',
		trigger: 'Vlt-sidemenu__trigger',
		triggerActive: 'Vlt-sidemenu__trigger_active',
		triggerCurrent: 'Vlt-sidemenu__trigger_current',
		triggerEnabled: '.Vlt-tabs__link:not(.Vlt-tabs__link_disabled)',
		visible: 'Vlt-sidenav_visible'
	}

	var _id = {
		menu: '#Vlt-sidenav',
		mobileTrigger: '#Vlt-sidenav-mobile-trigger'
	}

	var expandedMenus = [],
		mobileMenuTriggeredTwice;

	return {
		_class: _class,
		_element: undefined,

		closeAll: removeAllMenuItemsFromSelectedArr,
		init: initialise,
		expand: expandActiveMenu,
		showCollapsed: expandMenu,
		_triggerHandler: attachTriggerHandlers,
		selectActiveTab: selectActiveTab,
		styleActiveTrigger: styleActiveTrigger
	}

	/**
	 *	@private
	 *
	 *	@description Adds the parents of the active menu to the exoanded menus array
	 *	@param {HTMLElement} element The active menu
	 */
	function addExpandedParentMenuToArr(element){
		var nestedMenuUl = Volta._closest(element, 'ul', '.' + _class.sideMenu);
		var nestedMenuTrigger = nestedMenuUl.previousElementSibling;

		if(nestedMenuTrigger && Volta._hasClass(nestedMenuTrigger, _class.trigger)) {
			if(!Volta._hasClass(nestedMenuTrigger, _class.triggerActive)) {
				nestedMenuTrigger.classList.add(_class.triggerActive);
			}

			expandedMenus.push(nestedMenuTrigger);
			addExpandedParentMenuToArr(nestedMenuTrigger);
		}
	}

	/**
	 *	@private
	 *
	 *	@description Attach the listener for the mobile menu trigger
	 */
	function attachMobileTriggerHandler() {
		var mobileMenuTrigger = document.querySelector(_id.mobileTrigger);

		if(mobileMenuTrigger) {
			mobileMenuTrigger.addEventListener('click', function(e){
				if(mobileMenuTriggeredTwice) {
					mobileMenuTriggeredTwice = false;
					e.stopPropagation();
					return;
				}
				if(!Volta._hasClass(Volta.menu._element, _class.visible)) {
					Volta.menu._element.classList.add(_class.visible);
					document.body.classList.add(_class.mobileOpen);

					//stop propagation otherwise will immediately call handler
					e.stopPropagation();
					addMobileMenuCollapseListeners();
				}
			});
		}
	}

	/**
	 *	@private
	 *
	 *	@description Attach the listeners for closing the expanded mobile menu
	 */
	function addMobileMenuCollapseListeners() {
		document.querySelector('body').addEventListener('click', closeMenu, { once: true });
		document.querySelector('body').addEventListener('touchstart', closeMenu, { once: true });
	}

	/**
	 *	@public
	 *
	 *	@description Attach the listeners to the trigger elements of the menu
	 */
	function attachTriggerHandlers() {
		attachMobileTriggerHandler();
		Volta.menu._element.querySelectorAll('.' + _class.trigger).forEach(attachHandler);

		function attachHandler(triggerElem) {
			triggerElem.addEventListener('click', expandMenu);
		}
	}

	/**
     *  @private
     *
     *  @description Checks if the passed in menu is nested
     *  @param {HTMLElement} menuItem
     *  @return {boolean} If the menu item is nested returns true, otherwise false
     */
    function checkMenuItemIsNested(menuItem) {
      return isNestedDescendant(menuItem);
    }

    /**
     *  @private
     *
     *  @description Recursive function to check if the passed in menu is nested
     *  @param {HTMLElement} menuItem
     *  @param {Boolean} isAncestor
     *  @return {boolean} If the menu item is nested returns true, otherwise false
     */
    function isNestedDescendant(menuItem, isAncestor) {
      var isNested = false;
      var ancestor = isAncestor ? menuItem.parentElement : menuItem.parentElement.parentElement;
      var ancestorSibling = ancestor.previousElementSibling;

      if(ancestorSibling) {
        isNested = Volta._hasClass(ancestorSibling, _class.trigger);
      }

      if(ancestorSibling && !isNested) {
        return isNestedDescendant(ancestor, true);
      }

      return isNested;
    }

	/**
	 *	@private
	 *
	 *	@description Attach the listeners to the trigger elements of the menu
	 * 	@param {HTMLElement} menuItem
	 *	@return {boolean} If the menu item is nested returns true, otherwise false
	 */
	function closeMenu(e) {
		if(!Volta._hasClass(e.target, _class.sideMenu) && !Volta._closest(e.target, '.' + _class.sideMenu) &&
			!Volta._hasClass(e.target, _class.sideTabs) && !Volta._closest(e.target, '.' + _class.sideTabs)) {
			Volta.menu._element.classList.remove(_class.visible);

			document.body.classList.remove(_class.mobileOpen);

			var isMobileMenu = Volta._closest(e.target, '.' + _class.mobile);
			if(Volta._hasClass(e.target, _class.mobileTrigger) || isMobileMenu) {
				mobileMenuTriggeredTwice = true;
			}
		} else {
			addMobileMenuCollapseListeners();
		}
	}

	/**
	 *	@private
	 *
	 *	@description Expand the nested menu
	 * 	@param {event} e
	 */
	function expandMenu(e) {
		e.preventDefault();
		e.stopPropagation();

		var _this = this;

		var isNestedMenu = checkMenuItemIsNested(_this);

		if (expandedMenus.indexOf(_this) >= 0 && isNestedMenu) {
			removeMenuFromSelectedArr(_this);
		} else if(expandedMenus.indexOf(_this) >= 0) {
			removeAllMenuItemsFromSelectedArr();
		} else {
			if(!isNestedMenu) {
				removeAllMenuItemsFromSelectedArr();
			} else {
        	    removeSiblingFromSelectedArr(_this);
      		}
			expandedMenus.push(_this);
			_this.classList.add(_class.triggerActive);
		}

		if(Volta.menuCollapse) {
			Volta.menuCollapse.attachCloseHandler(expandedMenus);
		}
	}

	/**
	 *	@public
	 *
	 *	@description Expand the active menu - typically used on page load
	 * 	@param {boolean} isUserForced Whether the action has been trigger by the user
	 */
	function expandActiveMenu(isUserForced) {
		var activeMenuItem = Volta.menu._element.querySelector('.' + _class.linkActive);

		selectActiveTab(activeMenuItem);

		if(activeMenuItem) {
			var activeTriggerUl = Volta._closest(activeMenuItem, 'ul', '.' + _class.sideMenu);
			var activeTrigger = activeTriggerUl ? activeTriggerUl.previousElementSibling : null;
			if(activeTrigger) {
				var isNestedMenu = checkMenuItemIsNested(activeTrigger);
				if(isNestedMenu) {
					addExpandedParentMenuToArr(activeTrigger);
				}

				if(!Volta._hasClass(activeTrigger, _class.triggerActive)) {
					activeTrigger.classList.add(_class.triggerActive);
				}

				expandedMenus.push(activeTrigger);
			}
			styleActiveTrigger(activeMenuItem);
		}
	}

	/**
	 *	@public
	 *
	 *	@description Initialise the menu
	 * 	@param {boolean} menuCollapse Whether the collapse module has been included
	 */
	function initialise(menuCollapse) {
		expandedMenus = [];
		Volta.menu._element = document.querySelector(_id.menu);

		if(Volta.menu._element) {
			if(!Volta.menuCollapse) {
				expandActiveMenu();
			} else if(menuCollapse) {
				Volta.menuCollapse.init();
			}

			attachTriggerHandlers();
		}
	}

	/**
	 *	@public
	 *
	 *	@description Clear the selected menus array, and close all of the nested menus
	 */
	function removeAllMenuItemsFromSelectedArr(){
		expandedMenus.forEach(function(menuItem){
			menuItem.classList.remove(_class.triggerActive);
		});
		expandedMenus = [];
	}

	/**
	 *	@private
	 *
	 *	@description Remove a specific menu item from the selected array and close
	 */
	function removeMenuFromSelectedArr(menuItem) {
		var menuIndex = expandedMenus.indexOf(menuItem);
		menuItem.classList.remove(_class.triggerActive);
		expandedMenus.splice(menuIndex, 1);
	}

	/**
     *  @private
     *
     *  @description Remove sibling menu item from the selected array and close
     */
    function removeSiblingFromSelectedArr(menuItem) {
      var ancestors = menuItem.parentElement.parentElement.children;
      var openSibling;
      var count = ancestors.length - 1;

      while(openSibling === undefined && count >= 0) {
        var siblingIndex = expandedMenus.indexOf(ancestors[count].children[0]);
        if(siblingIndex >= 0) {
          openSibling = expandedMenus[siblingIndex];
        }
        count--;
      }

      if(openSibling) {
        removeMenuFromSelectedArr(openSibling);
      }
    }

	/**
	 *	@public
	 *
	 *	@description Select the active side tab
	 *	@param {activeMenuItem} Element(optional) The active menu item
	 */
	function selectActiveTab(activeMenuItem) {
		activeMenuItem = activeMenuItem || Volta.menu._element.querySelector('.' + _class.linkActive);
		var navTabs = document.querySelector(_id.menu + ' .' + _class.sideTabs);

		if(!navTabs || !activeMenuItem) {
			return null;
		}

		var sideMenus = Volta.menu._element.querySelectorAll('.' + _class.sideMenu);
		var menuTab = Volta._closest(activeMenuItem, '.' + _class.sideTabsPanel, '.' + _class.sideMenu);

		var tabIndex;
		var currentNode = 0;

		while(!tabIndex && currentNode < sideMenus.length) {
			if(sideMenus.item(currentNode) === menuTab) {
				tabIndex = currentNode;
				break;
			}
			currentNode++;
		}
		var sideTabs = Volta.menu._element.querySelectorAll('.' + _class.sideTabsLink);
		sideTabs[tabIndex].click();
	}

	/**
	 *	@public
	 *
	 *	@description Adds a class to the top level active trigger
	 *	@param {activeMenuItem} Element(optional) The active menu item
	 */
	function styleActiveTrigger(activeMenuItem) {
		activeMenuItem = activeMenuItem || Volta.menu._element.querySelector('.' + _class.linkActive);

		if(activeMenuItem) {
			var topLevelTrigger = getTopLevelTrigger(activeMenuItem);

			if(topLevelTrigger) {
				topLevelTrigger.classList.add(_class.triggerCurrent);
			}
		}

		function getTopLevelTrigger(activeMenuItem) {
			var element = activeMenuItem;
			var trigger = null;

			while (element) {
				if(element.matches('ul') && Volta._hasClass(element, _class.sideMenu)) {
					break;
				}

				if (element.matches('ul')) {
			  		trigger = element;
				}

				element = element.parentElement;
			}

			return trigger ? trigger.previousElementSibling : null;
		}
	}
}();