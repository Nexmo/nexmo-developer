/**
 * Copyright (c) 2018-present, Vonage. All rights reserved.
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

		if (body.querySelector('.Vlt-main')) {
			body.querySelector('.Vlt-main').addEventListener('touchmove', preventScroll);
		} else {
			body.addEventListener('touchmove', preventScroll);
		}

		body.querySelector('.' + _class.content).addEventListener('touchmove', allowScroll);
    }

    function enableScroll() {
		body.classList.remove(_class.bodyModalOpen);
		body.removeEventListener('touchmove', preventScroll);

		if (body.querySelector('.Vlt-main')) {
			body.querySelector('.Vlt-main').removeEventListener('touchmove', preventScroll);
		} else {
			body.removeEventListener('touchmove', preventScroll);
		}
		
		var modalContent = body.querySelector('.' + _class.content);
		if(modalContent) modalContent.removeEventListener('touchmove', allowScroll);
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