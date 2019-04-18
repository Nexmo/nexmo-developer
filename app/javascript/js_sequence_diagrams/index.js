import SequenceDiagram from 'js-sequence-diagrams'

export default () => {
  $(".js-diagram").each(function() {
    const $this = $(this)
    const diagram = SequenceDiagram.parse($this.text())
    $this.html('').addClass('diagram')
    diagram.drawSVG(this, {
      theme: 'simple'
    })
  })

  $('.diagram rect[stroke-width=2]')
    .attr('rx', 3)
    .attr('stroke-width', 1)
    .attr('stroke', '#93B6C7')
    .css('fill', '#ffffff')

  $('.diagram text')
    .css('font-family', 'Consolas, sans-serif')

  $('.diagram use')
    .css('fill', '93B6C7')

  $(".diagram rect[fill='#ffffff']").remove()

  $('.diagram path[fill=none]')
    .attr('stroke', '#93B6C7')
}
