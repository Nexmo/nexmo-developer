/* @preserve
 *
 * Copyright (c) 2018-present, Vonage. All rights reserved.
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
		if(components.indexOf('table') !== -1){
			if(Volta.table) {
				Volta.table.init();
			} else {
				console.warn('Volta: volta.table.js component missing')
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
