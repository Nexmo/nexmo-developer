import 'whatwg-fetch'

export default () => {
  fetch('https://xb8glk41jfrv.statuspage.io/api/v2/status.json')
  .then((response) => response.json())
  .then((payload) => {
    $('.api-status').addClass(`api-status--${payload.status.indicator}`)
    $('.api-status-status').text(payload.status.description)
  })
}
