/**
 * Copyright (c) 2018-present, Vonage. All rights reserved.
 *
 * Dropdowns (requires core)
 */

'use strict';

Volta.dropdown = function () {
	var _class = {
		wrapper: 'Vlt-dropdown',
		block: 'Vlt-dropdown__block',
		btn: 'Vlt-dropdown__trigger',
		btnLegacy: 'Vlt-dropdown__btn',
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
			this.btn = this.dropdown.querySelector('.' + _class.btn) || this.dropdown.querySelector('.' + _class.btnLegacy);
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