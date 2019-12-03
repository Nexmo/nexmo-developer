export default () => {

  function showCareer(career, selectedDepartment, selectedCareer) {
    const department = career.getElementsByClassName('department')[0].dataset.department;
    const location = career.getElementsByClassName('location')[0].dataset.location;

    return (department === selectedDepartment || selectedDepartment === '')
      && (location.includes(selectedCareer) || selectedCareer === '');
  }

  function toggleCareers() {
    const selectedDepartment = document.getElementById('department-filter').value;
    const selectedCareer = document.getElementById('location-filter').value;

    Array.from(document.getElementsByClassName('Nxd-career')).forEach(function(career) {
      career.classList.toggle('hide', !showCareer(career, selectedDepartment, selectedCareer));
    });

    document.getElementById('no-results').classList.toggle(
      'hide',
      document.querySelectorAll('.Nxd-career:not(.hide)').length !== 0
    );

    document.querySelectorAll('.Nxd-career:not(.hide)').forEach(function(career, index) {
      career.classList.toggle('striped', index % 2 == 0);
    });
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
