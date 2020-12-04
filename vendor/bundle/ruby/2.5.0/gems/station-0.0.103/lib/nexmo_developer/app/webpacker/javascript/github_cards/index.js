import 'whatwg-fetch'

export default () => {
  $('[data-github]').each((index, element) => {
    let repo = $(element).data('github');

    fetch('https://api.github.com/repos/' + repo)
    .then(function (response) {
      return response.json();
    })
    .then((response) => {
      $(element).find('[data-forks]').text(response.forks);
      $(element).find('[data-stars]').text(response.stargazers_count);
    });
  });
}
