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