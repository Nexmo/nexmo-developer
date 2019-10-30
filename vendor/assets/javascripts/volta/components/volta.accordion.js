/**
 * Copyright (c) 2018-present, Vonage. All rights reserved.
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
