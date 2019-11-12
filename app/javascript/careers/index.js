export default () => {
  function toggleCareers() {
    const selectedDepartment = document.getElementById('department-filter').value;
    const selectedCareer = document.getElementById('location-filter').value;

    document.getElementById('careers').querySelectorAll('.Nxd-department').forEach(function(department) {
      if (selectedDepartment === '') {
        department.classList.remove('hide');
      } else {
        department.classList.toggle('hide', department.dataset.department !== selectedDepartment);
      }
      department.querySelectorAll('.Nxd-career').forEach(function(career) {
        if (selectedCareer === '') {
          career.classList.remove('hide');
        } else {
          const location = career.getElementsByClassName('Nxd-career__subtitle')[0].innerHTML;
          career.classList.toggle('hide', !location.includes(selectedCareer));
        }
      });

      if (department.querySelectorAll('.Nxd-career:not(.hide)').length === 0) {
        department.classList.add('hide');
      }
    });

    document.getElementById('no-results').classList.toggle(
      'hide',
      document.querySelectorAll('.Nxd-department:not(.hide)').length !== 0
    );
  }

  function updateURL(key, value) {
    let currentUrl = new URL(window.location.href);
    let params = new URLSearchParams(window.location.search);
    if (value) {
      params.set(key, value);
    } else {
      params.delete(key);
    }

    currentUrl.search = params
    window.history.pushState({}, 'Careers', currentUrl);
  }

  function departmentChangeHandler(event) {
    updateURL('department', event.target.value);
    toggleCareers();
  }

  function locationChangeHandler(event) {
    updateURL('location', event.target.value);
    toggleCareers();
  }

  function setFiltersFromURL() {
    let params = new URLSearchParams(window.location.search);
    const departmentFilter = document.getElementById('department-filter');
    const locationFilter = document.getElementById('location-filter');

    departmentFilter.value = params.get('department') || '';
    locationFilter.value = params.get('location') || '';

    toggleCareers();
  }

  window.addEventListener('load', function() {
    if (!document.getElementById('careers')) { return; }

    toggleCareers();
    document.getElementById('department-filter').addEventListener('change', departmentChangeHandler);
    document.getElementById('location-filter').addEventListener('change', locationChangeHandler);
    setFiltersFromURL();
  });

  window.addEventListener('popstate', function(event) {
    if (!document.getElementById('careers')) { return; }
    setFiltersFromURL();
  });
}
