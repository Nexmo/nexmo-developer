export default () => {
  window.addEventListener('load', function() {
    document.getElementById('department-filter').addEventListener('change', function(event) {
      let selected = event.target.value;
      let departments = document.getElementById('careers').querySelectorAll('.Nxd-department');
      departments.forEach(function(department) {
        if (selected === '') {
          department.classList.remove('hide');
        } else {
          department.classList.toggle('hide', department.dataset.department !== selected);
        }
      });
    });
  });
}
