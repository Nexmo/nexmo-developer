window.navigationAnimationInProgress = false;
let animationSpeed = 0.2;

var Volta;

Volta = function (){
    return {
        _closest: closest,
        _hasClass: hasClass,
        _isMobile: isMobileDevice,
        _getElementSiblings: getElementSiblings,
        _getFunction: getFunctionFromString
    }

    /**
     *  @private
     *
     *  @description Finds the first ancestor of the given element, matching a specific selector.
     *  @param {HTMLElement} element Starting element
     *  @param {string} selector Selector to find (can be .class, #id, div...)
     *  @param {string} stopSelector Selector to stop searching on (can be .class, #id, div...)
     *  @returns {HTMLElement|null} The matched element or null if no element is found
     */
    function closest(element, selector, stopSelector) {
        var match = null;
        while (element) {
            if (element.matches(selector)) {
                match = element;
                break
            } else if (stopSelector && element.matches(stopSelector)) {
                break
            }
            element = element.parentElement;
        }
        return match;
    }

    /**
     *  @private
     *  @description Given the name of a function returns the function itself
     *  @param {string} callbackFnName The function name e.g. "testFunction" OR "test.function"
     *  @returns {Function}
     */
    function getFunctionFromString(fnName) {
        var fn;

        if(fnName) {
            var fnNames = fnName.split(".");
            var fn = window;
            for(var i = 0; i < fnNames.length; i++) {
                fn = fn[fnNames[i]];
            }
        }

        return fn;
    }

    /**
     *  @private
     *  @description Get all siblings of an element
     *  @param {HTMLElement} el
     */
    function getElementSiblings(element) {
        var siblings = [];
        element = element.parentNode.firstChild;
        do {
            if(element.nodeType === 1) {
                siblings.push(element);
            }
        } while (element = element.nextSibling);
        return siblings;
    }

    /**
     *  @privates
     *
     *  @description Check if the given element has a particular class
     *  @param {HTMLElement} el Element to evaluate
     *  @param {string} className Class name to check for
     *  @returns {boolean} True if the element has the class or false if not
     */
    function hasClass(element, className) {
        if(!element) {
            return false;
        }
        return (" " + element.className + " ").replace(/[\n\t]/g, " ").indexOf(" " + className+ " ") > -1;
    }

    /**
     *  @private
     *
     *  @description Is the current device a mobile
     *  @returns {boolean} True if mobile false if not
     */
    function isMobileDevice() {
        var isMobile = /Android|webOS|iPhone|iPad|BlackBerry|Windows Phone|Opera Mini|IEMobile|Mobile/i;

        return isMobile.test(navigator.userAgent);
    }

    /**
     *  @private
     *
     */
    function polyfilsForIE11() {
        if (window.NodeList && !NodeList.prototype.forEach) {
            NodeList.prototype.forEach = function (callback, thisArg) {
                thisArg = thisArg || window;
                for (var i = 0; i < this.length; i++) {
                    callback.call(thisArg, this[i], i, this);
                }
            };
        }

        if (!Element.prototype.matches) {
            Element.prototype.matches =
                Element.prototype.matchesSelector ||
                Element.prototype.mozMatchesSelector ||
                Element.prototype.msMatchesSelector ||
                Element.prototype.oMatchesSelector ||
                Element.prototype.webkitMatchesSelector ||
                function(s) {
                    var matches = (this.document || this.ownerDocument).querySelectorAll(s),
                        i = matches.length;
                    while (--i >= 0 && matches.item(i) !== this) {}
                    return i > -1;
                };
        }
    }
}();


Volta.menu = function () {
    var _class = {
        footer: 'Vlt-sidetabs',
        footerLink: 'Vlt-sidetabs__link',
        footerTrigger: 'Vlt-sidetabs__trigger',
        mobile: 'Vlt-sidenav__mobile',
        mobileOpen: 'Vlt-body--mobile-menu-open',
        mobileTrigger: 'Vlt-sidenav__mobile-trigger',
        link: 'Vlt-sidemenu__link',
        linkActive: 'Vlt-sidemenu__link_active',
        sideMenu: 'Vlt-sidemenu',
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

    var menu;

    var expandedMenus = [],
        mobileMenuTriggeredTwice;

    return {
        _class: _class,
        _element: undefined,

        closeAll: removeAllMenuItemsFromSelectedArr,
        init: initialise,
        expand: expandActiveMenu,
        _triggerHandler: attachTriggerHandlers
    }

    /**
     *  @private
     *
     *  @description Adds the parents of the active menu to the exoanded menus array
     *  @param {HTMLElement} element The active menu
     */
    function addExpandedParentMenuToArr(element){
        var nestedMenuUl = Volta._closest(element, 'ul', '.' + _class.sideMenu);
        var nestedMenuTrigger = nestedMenuUl.previousElementSibling;

        if(nestedMenuTrigger) {
            if(!Volta._hasClass(nestedMenuTrigger, _class.triggerActive)) {
                nestedMenuTrigger.classList.add(_class.triggerActive);
            }

            expandedMenus.push(nestedMenuTrigger);
            addExpandedParentMenuToArr(nestedMenuTrigger);
        }
    }

    /**
     *  @private
     *
     *  @description Attach the listener for the mobile menu trigger
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
                if(!Volta._hasClass(menu, _class.visible)) {
                    menu.classList.add(_class.visible);
                    document.body.classList.add(_class.mobileOpen);

                    //stop propagation otherwise will immediately call handler
                    e.stopPropagation();
                    addMobileMenuCollapseListeners();
                }
            });
        }
    }

    /**
     *  @private
     *
     *  @description Attach the listeners for closing the expanded mobile menu
     */
    function addMobileMenuCollapseListeners() {
        document.querySelector('body').addEventListener('click', closeMenu, { once: true });
        document.querySelector('body').addEventListener('touchstart', closeMenu, { once: true });
    }

    /**
     *  @public
     *
     *  @description Attach the listeners to the trigger elements of the menu
     */
    function attachTriggerHandlers() {
        attachMobileTriggerHandler();
        menu.querySelectorAll('.' + _class.trigger).forEach(attachHandler);

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
     *  @private
     *
     *  @description Attach the listeners to the trigger elements of the menu
     *  @param {HTMLElement} menuItem
     *  @return {boolean} If the menu item is nested returns true, otherwise false
     */
    function closeMenu(e) {
        var isSideMenuChild = Volta._closest(e.target, '.' + _class.sideMenu);
        if(!Volta._hasClass(e.target, _class.sideMenu) && !isSideMenuChild) {
            menu.classList.remove(_class.visible);

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
     *  @private
     *
     *  @description Expand the nested menu
     *  @param {event} e
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
     *  @public
     *
     *  @description Expand the active menu - typically used on page load
     *  @param {boolean} isUserForced Whether the action has been trigger by the user
     */
    function expandActiveMenu(isUserForced) {
        var activeMenuItem = menu.querySelector('.' + _class.linkActive);

        if(activeMenuItem) {
            var activeTriggerUl = Volta._closest(activeMenuItem, 'ul', '.' + _class.sideMenu);
            var activeTrigger = activeTriggerUl.previousElementSibling;

            if(activeTrigger) {
                if(!Volta._hasClass(activeTrigger, _class.triggerActive)) {
                    activeTrigger.classList.add(_class.triggerActive, _class.triggerCurrent);
                }

                var isNestedMenu = checkMenuItemIsNested(activeTrigger);
                if(isNestedMenu) {
                    addExpandedParentMenuToArr(activeTrigger);
                }

                expandedMenus.push(activeTrigger);
            }
        }
    }

    /**
     *  @public
     *
     *  @description Initialise the menu
     *  @param {boolean} menuCollapse Whether the collapse module has been included
     */
    function initialise(menuCollapse) {
        expandedMenus = [];
        menu = document.querySelector(_id.menu);
        Volta.menu._element = menu;

        if(menu) {
            if(!Volta.menuCollapse) {
                expandActiveMenu();
            } else if(menuCollapse) {
                Volta.menuCollapse.init();
            }

            attachTriggerHandlers();
        }
    }

    /**
     *  @public
     *
     *  @description Clear the selected menus array, and close all of the nested menus
     */
    function removeAllMenuItemsFromSelectedArr(){
        expandedMenus.forEach(function(menuItem){
            menuItem.classList.remove(_class.triggerActive);
        });
        expandedMenus = [];
    }

    /**
     *  @private
     *
     *  @description Remove a specific menu item from the selected array and close
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
}();

function toggleMobileNavBtn() {
    if($('#Vlt-sidenav').length === 0) {
        $('#Vlt-sidenav-mobile-trigger').hide();
    }
}

function setActiveNavItem() {
  const activeItem = $('nav.sidenav').data('active');
  $(`.Vlt-sidemenu__link[href="${activeItem}"]`).addClass('Vlt-sidemenu__link_active')
}

export default () => {
    setActiveNavItem();
    Volta.menu.init();
    toggleMobileNavBtn();
}
