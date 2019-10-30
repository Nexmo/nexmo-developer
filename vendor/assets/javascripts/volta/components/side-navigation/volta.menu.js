/**
 * Copyright (c) 2018-present, Vonage. All rights reserved.
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