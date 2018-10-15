import React from 'react'
import chunk from 'lodash/chunk'
import difference from 'lodash/difference'

// GSM standard table
const safeCharacters = [
  '@', '0', '¡', 'P', '¿',
  'p', '£', '_', '!', '1',
  'A', 'Q', 'a', 'q', '$',
  '"', '2', 'B', 'R', 'b',
  'r', '¥', '?', '#', '3',
  'C', 'S', 'c', 's', 'è',
  '?', '4', 'D', 'T', 'd',
  't', 'é', '?', '%', '5',
  'E', 'U', 'e', 'u', 'ù',
  '6', 'F', 'V', 'f', 'v',
  'ì', '?', "'", '7', 'G',
  'W', 'g', 'w', 'ò', '(',
  '8', 'H', 'X', 'h', 'x',
  'Ç', ')', '9', 'I', 'Y',
  'i', 'y', '*', ':', 'J',
  'Z', 'j', 'z', 'Ø', '+',
  ';', 'K', 'Ä', 'k', 'ä',
  'Æ', ',', '<', 'L', 'l',
  'ö', 'æ', '-', '=', 'M',
  'Ñ', 'm', 'ñ', 'Å', 'ß',
  '.', '>', 'N', 'Ü', 'n',
  'ü', 'å', 'É', '/', 'O',
  '§', 'o', 'à', ' '
]

// These require two bytes per character: ESC followed by the character
const extGSMChars = [
  '|', '^', '€', '{', '}', '[', ']', '~', '\\'
]

class Concatenation extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      body: 'It was the best of times, it was the worst of times, it was the age of wisdom, it was the age of foolishness, it was the epoch of belief, it was the epoch of incredulity, it was the season of Light, it was the season of Darkness, it was the spring of hope, it was the winter of despair, we had everything before us, we had nothing before us, we were all going direct to Heaven, we were all going direct the other way in short, the period was so far like the present period, that some of its noisiest authorities insisted on its being received, for good or for evil, in the superlative degree of comparison only.'
    }
  }

  splitStringByCodePoint() {
    return [...this.state.body]
  }

  split() {
    const stringArray = this.splitStringByCodePoint()

    const shouldEncodeAs16Bit = this.shouldEncodeAs16Bit()

    const capacity = shouldEncodeAs16Bit ? 70 : 160
    const capacityWithMeta = shouldEncodeAs16Bit ? 66 : 153

    var a = [stringArray.slice(0, capacity).join('')]

    if (stringArray.length > capacity) {
      a = [stringArray.slice(0, capacityWithMeta).join('')]
      const remainder = stringArray.slice(capacityWithMeta)
      const arrays = chunk(remainder, capacityWithMeta).map((a) => a.join(''))
      a = a.concat(arrays)
    }

    return a
  }

  shouldEncodeAs16Bit() {
    var remainder = difference(this.splitStringByCodePoint(), [...safeCharacters, ...extGSMChars])
    return remainder.length !== 0
  }

  renderUdf(split) {
    if (split.length > 1) {
      return (
        <span>
          <span className="label">User Defined Header</span>
          <span dangerouslySetInnerHTML={{ __html: '&nbsp;' }}></span>
        </span>
      )
    }
  }

  renderSplit(split) {
    return split.map((group, index) => {
      return (
        <tr key={index}>
          <td style={{ verticalAlign: 'middle' }}><b>Part {index + 1}</b></td>
          <td style={{ width: '75%' }}>
            <code
              style={{ whiteSpace: 'normal', wordBreak: 'break-all' }}
            >
              { this.renderUdf(split) }
              {group}
            </code>
          </td>
        </tr>
      )
    })
  }

  renderUtfIcon(bool) {
    if (bool) {
      return (
        <i className="icon icon--large icon-check-circle color--success"/>
      )
    } else {
      return (
        <i className="icon icon--large icon-times-circle color--error"/>
      )
    }
  }

  pluralize(singular, count) {
    if (count === 1) { return singular }
    return `${singular}s`
  }

  render() {
    const split = this.split()
    const characterCount = this.splitStringByCodePoint(this.state.body).length

    return (
      <div className="box">
        <h2>Try it out</h2>

        <h3>Message</h3>

        <textarea
          className="input"
          onChange={ (event) => this.setState({ body: event.target.value })}
          value={ this.state.body }
          style={{ width: '100%', height: '150px', resize: 'vertical' }}
        ></textarea>

        <br/><br/>

        <h3>Data</h3>

        <table>
          <tbody>
            <tr>
              <td><b>Unicode is Required?</b></td>
              <td style={{ width: '75%' }}>{ this.renderUtfIcon(this.shouldEncodeAs16Bit()) }</td>
            </tr>
            <tr>
              <td><b>Length</b></td>
              <td style={{ width: '75%' }}>{ characterCount } { this.pluralize('character', characterCount) } sent in {split.length} message { this.pluralize('part', split.length) }</td>
            </tr>
          </tbody>
        </table>

        <h3>Parts</h3>

        <table>
          <tbody>
            { this.renderSplit(split) }
          </tbody>
        </table>
      </div>
    )
  }
}

export default Concatenation
