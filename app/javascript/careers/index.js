export default class Careers {

  constructor() {
    this.departments = [];
    this.locations = [];
    this.setupListeners();
  }

  showCareer(career) {
    const department = career.getElementsByClassName('department')[0].dataset.department;
    const location = career.getElementsByClassName('location')[0].dataset.location;

    return (this.departments.includes(department) || this.departments.length === 0)
      && (this.locations.some(l => location.includes(l) || l.includes(location)) || this.locations.length === 0);
  }

  toggleCareers() {
    Array.from(document.getElementsByClassName('Nxd-career')).forEach(function(career) {
      career.classList.toggle('hide', !this.showCareer(career));
    }, this);

    document.getElementById('no-results').classList.toggle(
      'hide',
      document.querySelectorAll('.Nxd-career:not(.hide)').length !== 0
    );

    document.querySelectorAll('.Nxd-career:not(.hide)').forEach(function(career, index) {
      career.classList.toggle('striped', index % 2 == 0);
    });
  }

  updateURL() {
    let currentUrl = new URL(window.location.href);
    let query = {};
    if (this.departments.length > 0) {
      Object.assign(query, { departments: this.departments });
    }
    if (this.locations.length > 0) {
      Object.assign(query, { locations: this.locations.map((l) => l.split(',')[0]) });
    }

    let params = new URLSearchParams(query);

    currentUrl.search = params
    window.history.pushState({}, 'Careers', currentUrl);
  }

  dropdownValue(length, item) {
    let value;
    switch(length) {
      case 0:
        value = `${item}s`;
        break;
      case 1:
        value = `1 ${item} selected`;
        break;
      default:
        value = `${length} ${item}s selected`;
    }
    return value;
  }

  updateDepartmentsDropdown() {
    let value = this.dropdownValue(this.departments.length, 'Department');
    document.querySelector('#department-filter button').innerText = value;
  }

  updateLocationsDropdown() {
    let value = this.dropdownValue(this.locations.length, 'Location');
    document.querySelector('#location-filter button').innerText = value;
  }

  departmentChangeHandler(event) {
    if (event.target.checked) {
      this.departments.push(event.target.value);
    } else {
      this.departments.splice(this.departments.indexOf(event.target.value), 1);
    }
    this.updateURL();
    this.updateDepartmentsDropdown();
    this.toggleCareers();
  }

  locationChangeHandler(event) {
    if (event.target.checked) {
      this.locations.push(event.target.value);
    } else {
      this.locations.splice(this.locations.indexOf(event.target.value), 1);
    }
    this.updateURL();
    this.updateLocationsDropdown();
    this.toggleCareers();
  }

  setFiltersFromURL() {
    let params = new URLSearchParams(window.location.search);
    this.departments = [];
    this.locations = [];

    params.get('departments') && params.get('departments').split(',').forEach(function(department) {
      this.departments.push(department);
      document.getElementById(department).checked = true;
    }, this);

    params.get('locations') && params.get('locations').split(',').forEach(function(location) {
      let checkbox = document.querySelector(`[id^=${location}]`);
      if (checkbox) {
        this.locations.push(location);
        checkbox.checked = true;
      }
    }, this);

    this.updateDepartmentsDropdown();
    this.updateLocationsDropdown();
    this.toggleCareers();
  }

  setupListeners() {
    const self = this;
    window.addEventListener('load', function() {
      if (!document.getElementById('careers')) { return; }

      self.toggleCareers();
      document.getElementById('department-filter').addEventListener('change', self.departmentChangeHandler.bind(self));
      document.getElementById('location-filter').addEventListener('change', self.locationChangeHandler.bind(self));
      self.setFiltersFromURL();
    });

    window.addEventListener('popstate', function(event) {
      if (!document.getElementById('careers')) { return; }
      self.setFiltersFromURL();
    });
  }
}
