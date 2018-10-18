/**
 * Copyright (c) 2001-present, Vonage.
 *	
 * Menu Collapse (requires core, menu)
 */

'use strict';

Volta.menuCollapse = function () {	
	var _class = {
		animate: 'Vlt-sidenav--animate',
		collapsed: 'Vlt-sidenav--collapsed',
		visible: 'Vlt-sidenav_visible'
	}

	var _id = {
		collapse: '#Vlt-sidenav-collapse-trigger'
	}

	var menuCollapseString = "menuCollapse";

	return {
		attachCloseHandler: attachCloseHandler,
		init: initialise
	}

	/**   
	 *	@private
	 *	
	 *	@description Attach listener to trigger for collapsing the menu
	 */
	function attachMenuCollapseHandler() {
		var collapseTrigger = document.querySelector(_id.collapse);

		if(collapseTrigger) {
			collapseTrigger.addEventListener('click', function(e) {
				e.preventDefault();
				e.stopPropagation();
				
				var hasCollapsedClass = Volta._hasClass(Volta.menu._element, _class.collapsed);
				var isMobile = Volta._hasClass(Volta.menu._element, _class.visible);

				Volta.menu._element.classList.add(_class.animate);
				
				if (isMobile) {
					Volta.menu._element.classList.remove(_class.visible);
				} else if (hasCollapsedClass) {
					unCollapseMenu(Volta.menu._element);
				} else {
					collapseMenu(Volta.menu._element);
				}
			});
		}
	}

	/**   
	 *	@public
	 *	
	 *	@description Attach listener to trigger for closing the menu
	 */
	function attachCloseHandler(expandedMenus) {
		if(document.querySelector('.' + _class.collapsed) && expandedMenus) {
			document.querySelector('body').addEventListener('click', closeMenu, { once: true });
		}

		function closeMenu(e) {
			if(!Volta._hasClass(e.target, Volta.menu._class.link) 
					&& !Volta._hasClass(e.target.parentElement, Volta.menu._class.link)) {
				e.preventDefault();
				e.stopPropagation();

				Volta.menu.closeAll();
			} else {
				document.querySelector('body').addEventListener('click', closeMenu, { once: true });
			}
		}
	}

	/**   
	 *	@private
	 *	
	 *	@description Collapse the expanded menu
	 */
	function collapseMenu() {
		Volta.menu.closeAll();
		Volta.menu.selectActiveTab();

		Volta.menu._element.classList.add(_class.collapsed);

		document.querySelectorAll(Volta.menu._class.trigger).forEach(function(menuItem){
	        menuItem.nextElementSibling.style = "top: " + menuItem.positionTop;
		});

		if(localStorage) {
			localStorage.setItem(menuCollapseString, true);
		}

		var sideTabs = Volta.menu._element.querySelector('.' + Volta.menu._class.sideTabs);

		if(sideTabs) {
			sideTabs.querySelectorAll('.' + Volta.menu._class.sideTabsTrigger).forEach(function(trigger){
				trigger.classList.remove(Volta.menu._class.sideTabsTrigger);
				trigger.classList.add(Volta.menu._class.trigger);
				trigger.addEventListener('click', Volta.menu.showCollapsed);
			});

			sideTabs.querySelectorAll('.' + Volta.menu._class.sideTabsLink).forEach(function(link){
				link.classList.remove(Volta.menu._class.sideTabsLink);
				link.classList.add(Volta.menu._class.link);
			});
		}

		Volta.menu.styleActiveTrigger();
	}

	/**   
	 *	@public
	 *	
	 *	@description Initailise the menu collapsing
	 */
	function initialise() {
		if(!Volta.menu) return;

		attachMenuCollapseHandler();

		var menuCollapsedFlag = localStorage ? localStorage.getItem(menuCollapseString) : false;

		if(menuCollapsedFlag) {
			Volta.menu._element.querySelectorAll('.' + Volta.menu._class.triggerActive).forEach(function(trigger) {
				trigger.classList.remove(Volta.menu._class.triggerActive);
			});
			collapseMenu();
		} else {
			Volta.menu.expand();
		}
	}

	/**
	 *	@public
	 *
	 *	@description Expand the collapsed menu
	 */
	function unCollapseMenu() {
		Volta.menu._element.classList.remove(_class.collapsed);

		if(localStorage) {
			localStorage.removeItem(menuCollapseString);
		}

		var sideTabs = Volta.menu._element.querySelector('.' + Volta.menu._class.sideTabs);

		if(sideTabs) {
			sideTabs.querySelectorAll('.' + Volta.menu._class.trigger).forEach(function(trigger){
				trigger.classList.add(Volta.menu._class.sideTabsTrigger);
				trigger.classList.remove(Volta.menu._class.trigger);
				trigger.removeEventListener('click', Volta.menu.showCollapsed);
			});

			sideTabs.querySelectorAll('.' + Volta.menu._class.link).forEach(function(link){
				link.classList.add(Volta.menu._class.sideTabsLink);
				link.classList.remove(Volta.menu._class.link);
			});
		}

		Volta.menu.expand(true);
	}
}();