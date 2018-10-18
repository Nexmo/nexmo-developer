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