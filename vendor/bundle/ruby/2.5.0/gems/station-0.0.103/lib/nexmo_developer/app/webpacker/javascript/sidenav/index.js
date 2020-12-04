class Menu {
  constructor(domNode, parent) {
    this.domNode = domNode;
    this.parent = parent;
    this.items = [];

    this.firstItem = null;
    this.lastItem = null;

    this.buildItems();
  }

  buildItems() {
    Array.from(this.domNode.children).forEach((child) => {
      if (child.children.length > 0) {
        this.items.push(new SidenavItem(child.querySelector('a.Vlt-sidemenu__trigger, a.Vlt-sidemenu__link, .Vlt-sidemenu__title'), this.parent));
      }
    });
    this.firstItem = this.items[0];
    this.lastItem = this.items[this.items.length - 1];
  }

  setFocusToNextItem(current) {
    let node = null;

    if (current === this.lastItem) {
      node = this.firstItem.domNode;
    }
    else {
      node = this.items[this.items.indexOf(current) + 1].domNode;
    }
    node.tabIndex = 0;
    node.focus();
  }

  setFocusToPreviousItem(item) {
    if (item === this.firstItem) {
      this.lastItem.domNode.focus();
    }
    else {
      this.items[this.items.indexOf(item) - 1].domNode.focus();
    }
  }

  setFocusToFirstItem() {
    this.firstItem.domNode.focus();
  }
}

class SidenavItem {
  constructor(domNode, parent) {
    this.domNode = domNode;
    this.parent = parent;
    this.menu = null;

    this.buildItem();

    this.keyCode = Object.freeze({
      'ENTER': 13,
      'LEFT': 37,
      'UP': 38,
      'RIGHT': 39,
      'DOWN': 40
    });
    this.domNode.addEventListener('keydown', this.handleKeyDown.bind(this));
    this.domNode.addEventListener('click', this.handleClick.bind(this));
  }

  buildItem() {
    if (this.isMenu()) {
      this.menu = new Menu(this.domNode.nextElementSibling, this);
    }
  }

  isMenu() {
    return this.domNode.nextElementSibling && this.domNode.nextElementSibling.tagName === 'UL';
  }

  handleKeyDown(event) {
    let target = event.currentTarget;
    let key = event.key;
    let bubbleUp = false;

    switch (event.keyCode) {
      case this.keyCode.ENTER:
        if (this.menu) {
          this.toggleElement(true);
          bubbleUp = true;
        }
        break;

      case this.keyCode.DOWN:
        this.parent.setFocusToNextItem(this);
        bubbleUp = true;
        break;

      case this.keyCode.LEFT:
        this.parent.toggleElement(true);
        bubbleUp = true;
        break;

      case this.keyCode.RIGHT:
        if (this.menu) {
          this.toggleElement(true);
        }
        bubbleUp = true;
        break;

      case this.keyCode.UP:
        this.parent.setFocusToPreviousItem(this);
        bubbleUp = true;
        break;
    }

    if (bubbleUp) {
      event.stopPropagation();
      event.preventDefault();
    }
  };

  handleClick(event) {
    if (this.menu) {
      event.preventDefault();
      event.stopPropagation();
      this.toggleElement();
    }
  }

  toggleElement(focus) {
    if (this.domNode.classList.contains('Vlt-sidemenu__trigger_active')) {
      this.domNode.setAttribute('aria-expanded', 'false');
      this.domNode.classList.remove('Vlt-sidemenu__trigger_active');
      this.domNode.tabIndex = -1;
      if (focus) { this.domNode.focus(); }
    } else {
      this.domNode.tabIndex = 0;
      this.domNode.setAttribute('aria-expanded', 'true');
      this.domNode.classList.add('Vlt-sidemenu__trigger_active');
      this.domNode.dispatchEvent(new CustomEvent('menuClosed', { bubbles: true }));
      if (focus) { this.menu.setFocusToFirstItem(); }
    }
  }

  setFocusToPreviousLevel() {
    if (this.menu) {
      this.domNode.setAttribute('aria-expanded', 'false');
      this.domNode.classList.remove('Vlt-sidemenu__trigger_active');
      this.domNode.tabIndex = -1;
      this.domNode.focus();
    } else {
      this.parent.setFocusToPreviousItem(this);
    }
  }

  setFocusToNextItem(current) {
    if (this.menu) {
      this.menu.setFocusToNextItem(current);
    }
  }

  setFocusToPreviousItem(current) {
    if (this.menu) {
      this.menu.setFocusToPreviousItem(current);
    }
  }
}

export default class Sidenav {
  constructor(domNode) {
    this.domNode = document.getElementById('sidenav');
    this.mobileTrigger = document.getElementById('Vlt-sidenav-mobile-trigger');
    this.container = document.getElementById('Vlt-sidenav');

    if (this.domNode) {
      this.buildMenu();
      this.setActiveItem();
      this.expandActiveMenu();
      this.setupListeners();
    } else {
      this.mobileTrigger.style.display = 'none';
    }
  }

  setupListeners() {
    this.domNode.addEventListener('menuClosed', this.closeOpenedMenu.bind(this));
    this.mobileTrigger.addEventListener('click', this.mobileHandler.bind(this));
    this.mobileTrigger.addEventListener('touchstart', this.mobileHandler.bind(this));

    document.querySelector('body').addEventListener('click', this.closeMobileMenu.bind(this));
    document.querySelector('body').addEventListener('touchstart', this.closeMobileMenu.bind(this));
  }

  buildMenu() {
    this.menu = new Menu(this.domNode.firstElementChild, this);
  }

  setFocusToNextItem(current) {
    this.menu.setFocusToNextItem(current);
  }

  setFocusToPreviousItem(current) {
    this.menu.setFocusToPreviousItem(current);
  }

  // No-op
  toggleElement() {}

  setActiveItem() {
    let url = document.querySelector('nav.sidenav').dataset.active;
    let activeItemSelector = `.Vlt-sidemenu__link[href="${url}"]`;
    let activeItem = document.querySelector(activeItemSelector);
    if (activeItem) {
      activeItem.classList.add('Vlt-sidemenu__link_active');
    }
  }

  expandActiveMenu() {
    const activeItem = this.domNode.querySelector('.Vlt-sidemenu__link_active');
    if (activeItem) {
      let activeTrigger = activeItem.closest('ul').previousElementSibling;

      while (activeTrigger) {
        activeTrigger.classList.add('Vlt-sidemenu__trigger_active', 'Vlt-sidemenu__trigger_current');
        activeTrigger = activeTrigger.parentNode.closest('ul').previousElementSibling;
      }
    }
  }

  closeOpenedMenu(event) {
    Array.from(this.domNode.querySelectorAll('.Vlt-sidemenu__trigger_active')).forEach((subMenu) => {
      if (subMenu !== event.target && !subMenu.parentNode.contains(event.target)) {
        subMenu.classList.remove('Vlt-sidemenu__trigger_active');
      }
    });
  }

  mobileHandler(event) {
    if (!this.container.classList.contains('Vlt-sidenav_visible')) {
      this.container.classList.add('Vlt-sidenav_visible');
      document.body.classList.add('Vlt-body--mobile-menu-open');
      event.stopPropagation();
    }
  }

  closeMobileMenu(event) {
    if (!this.domNode.contains(event.target)) {
      this.container.classList.remove('Vlt-sidenav_visible');
      document.body.classList.remove('Vlt-body--mobile-menu-open');
    }
  }
}
