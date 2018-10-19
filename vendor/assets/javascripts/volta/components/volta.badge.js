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