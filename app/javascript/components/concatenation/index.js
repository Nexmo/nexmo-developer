import React from 'react'
import CharacterCounter from './character_counter'

class Concatenation extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      body: 'It was the best of times, it was the worst of times, it was the age of wisdom, it was the age of foolishness, it was the epoch of belief, it was the epoch of incredulity, it was the season of Light, it was the season of Darkness, it was the spring of hope, it was the winter of despair, we had everything before us, we had nothing before us, we were all going direct to Heaven, we were all going direct the other way in short, the period was so far like the present period, that some of its noisiest authorities insisted on its being received, for good or for evil, in the superlative degree of comparison only.'
    }
  }

  renderUserDefinedHeader(messages) {
    if (messages.length > 1) {
      return (
        <span>
          <span className="Vlt-badge Vlt-badge--blue">User Defined Header</span>
          <span dangerouslySetInnerHTML={{ __html: '&nbsp;' }}></span>
        </span>
      )
    }
  }

  renderMessages(messages) {
    return messages.map((group, index, arr) => {
      return (
        <div className="Vlt-grid" key={index}>
          <div className="Vlt-col Vlt-col--1of3"><b>Part {index + 1}</b></div>
          <div className="Vlt-col Vlt-col--2of3">
            <code
                style={{ whiteSpace: 'normal', wordBreak: 'break-all' }}
              >
                { this.renderUserDefinedHeader(messages) }
                {group}
            </code>
          </div>
          { index !== arr.length - 1 && <hr className="hr--shorter" /> }
        </div>
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
    const smsInfo = new CharacterCounter(this.state.body).getInfo();

    return (
      <div>
        <h2>Try it out</h2>

        <h4>Message</h4>
        <div className="Vlt-textarea">
          <textarea
            onChange={ (event) => this.setState({ body: event.target.value })}
            value={ this.state.body }
            style={{ width: '100%', height: '150px', resize: 'vertical' }}
          ></textarea>
        </div>

        <div className="Vlt-margin--top2" />

        <h4>Data</h4>
        <div className="Vlt-box Vlt-box--white Vlt-box--lesspadding">
          <div className="Vlt-grid">
            <div className="Vlt-col Vlt-col--1of3">
              <b>Unicode is Required?</b>
            </div>
            <div className="Vlt-col Vlt-col--2of3">
              { this.renderUtfIcon(smsInfo.unicodeRequired) }
            </div>
            <hr className="hr--shorter"/>
            <div className="Vlt-col Vlt-col--1of3">
              <b>Length</b>
            </div>
            <div className="Vlt-col Vlt-col--2of3">
              { smsInfo.charactersCount } { this.pluralize('character', smsInfo.charactersCount) } sent in {smsInfo.messages.length} message { this.pluralize('part', smsInfo.messages.length) }
            </div>
          </div>
        </div>

        <h4>Parts</h4>
        <div className="Vlt-box Vlt-box--white Vlt-box--lesspadding">
          { this.renderMessages(smsInfo.messages) }
        </div>
      </div>
    )
  }
}

export default Concatenation
