/**
 * Copyright (c) 2018-present, Vonage. All rights reserved.
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