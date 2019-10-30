/**
 * Copyright (c) 2018-present, Vonage. All rights reserved.
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

	function Tabs() { }

	Tabs.prototype = {
		_keys: {
			left: 37,
			right: 39
		},

		init: function (element, isWrapper) {
			var _this = this,
				tabsHeader,
				tabsContent;

			if (isWrapper) {
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

			this._deactivateElements();
			this._setActiveElements();

			if (_this._panels && _this._panels.length === _this._links.length) {
				_this._links.forEach(function (link, index) {
					var link = link;

					link.index = index;
					link.addEventListener('keyup', _this._keyUpEventListener.bind(_this));
					var handler = function() {
						_this.toggle(link);
					};

					// Use link.dispatchEvent(new Event('toggle')); if you want to change
					// tabs without triggering all other .click() handlers
					link.addEventListener('toggle', handler);
					link.addEventListener('click', handler);
				});
			} else if (_this._panels && _this._panels.length > 0) {
				console.log('Volta: Tabs, number of links and panels do not match');
			}
		},
		toggle: function (linkElement) {
			var linkActiveClass = this.isJs ? _class.linkJsActive : _class.linkActive;
			var panelActiveClass = this.isJs ? _class.panelJsActive : _class.panelActive;

			if (!Volta._hasClass(linkElement, _class.linkDisabled) && (!this._activeLink || this._activeLink !== linkElement)) {
				if (this._activeLink) {
					this._activeLink.classList.remove(linkActiveClass);
					this._activePanel.classList.remove(panelActiveClass);
				}

				this._deactivateElements();
				this._setActiveElements(linkElement);

				this._activeLink.classList.add(linkActiveClass);
				this._activePanel.classList.add(panelActiveClass);

				if (Volta.tooltip) {
					Volta.tooltip.init();
				}
			}
		},
		_deactivateElements: function () {
			this._links.forEach(function (link) {
				link.setAttribute('tabIndex', '-1');
				link.setAttribute('aria-selected', 'false');
			});
			Array.from(this._panels).forEach(function (panel) {
				panel.setAttribute('hidden', 'hidden');
			});
		},
		_setActiveElements: function (linkElement) {
			var linkActiveClass = this.isJs ? _class.linkJsActive : _class.linkActive;

			if (!linkElement) {
				this._activeLink = this._links.item(linkActiveClass);
			} else {
				this._activeLink = linkElement;
			}

			var tabIndex;
			var currentNode = 0;

			while (!tabIndex && currentNode < this._links.length) {
				if (this._links.item(currentNode) === this._activeLink) {
					tabIndex = currentNode;
					break;
				}
				currentNode++;
			}

			if (this._panels) {
				this._activePanel = this._panels.item(tabIndex);
			}

			this._activeLink.setAttribute('tabindex', '0');
			this._activeLink.setAttribute('aria-selected', 'true');
			this._activeLink.focus();
			if (this._activePanel) {
				this._activePanel.removeAttribute('hidden');
			}
		},
		_keyUpEventListener: function (event) {
			var key = event.keyCode;

			switch (key) {
				case this._keys.left:
				case this._keys.right:
					this._switchTab(event);
					break;
			}
		},
		_switchTab: function (event) {
			var nextTab;

			if (this._keys.left === event.keyCode) {
				nextTab = this._findNextTab(-1);
			} else if (this._keys.right === event.keyCode) {
				nextTab = this._findNextTab(1);
			}
			this.toggle(nextTab);
		},
		_findNextTab: function (direction) {
			var tab, nextTab;
			var currentIndex = this._activeLink.index;
			for (var i = currentIndex + direction; !nextTab && (this._calculateIndex(i) !== currentIndex); i += direction) {
				tab = this._links.item(this._calculateIndex(i));
				if (!Volta._hasClass(tab, _class.linkDisabled)) {
					nextTab = tab;
				}
			}
			return nextTab;
		},
		_calculateIndex: function (i) {
			var length = this._links.length;
			return ((i % length) + length) % length;
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

		if (Volta._hasClass(element, _class.tabs)) {
			tabs.init(element, true);
		} else {
			tabs.init(element);
		}

		return tabs;
	}
}();
