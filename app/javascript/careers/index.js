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
  }

  window.addEventListener('load', function() {
    if (!document.getElementById('careers')) { return; }

    toggleCareers();
    document.getElementById('department-filter').addEventListener('change', toggleCareers);
    document.getElementById('location-filter').addEventListener('change', toggleCareers);
  });
}
