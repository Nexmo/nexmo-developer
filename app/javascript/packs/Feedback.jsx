import 'whatwg-fetch'
import React from 'react'

class Feedback extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      code_language: this.props.code_language || window.initialLanguage,
      code_language_selected_whilst_on_page: this.props.code_language_selected_whilst_on_page || false,
      code_language_set_by_url: this.props.code_language_set_by_url,
      email: '',
      comment: '',
    }

    if (this.props.feedback_author) {
      this.state.email = this.props.feedback_author.email
    }
  }

  componentDidMount() {
    $(document).on('codeLanguageChange', this.handleCodeLanguageChange.bind(this))
    window.invisibleCaptchaCallback = this.invisibleCaptchaCallback.bind(this)
  }

  invisibleCaptchaCallback(recaptcha_token) {
    this.setState({
      recaptcha_token
    }, this.createOrUpdate)

  }

  handleCodeLanguageChange(event, data) {
    this.setState({
      code_language: data.language,
      code_language_selected_whilst_on_page: true,
      code_language_set_by_url: false,
    })
  }

  parameters() {
    return {
      'g-recaptcha-response': this.state.recaptcha_token,
      feedback_feedback: {
        id: this.state.id,

        sentiment: this.state.sentiment,
        comment: this.state.comment,
        email: this.state.email,
        code_language: this.state.code_language,
        code_language_selected_whilst_on_page: this.state.code_language_selected_whilst_on_page,
        code_language_set_by_url: this.state.code_language_set_by_url,

        source: this.props.source,
      }
    }
  }

  renderFeedbackImproveThisPage() {
    if (!this.props.github_url) { return }

    var githubIcon = '<use xlink:href="/symbol/volta-icons.svg#Vlt-icon-github" />'

    return (
      <span id="feedback__improve">
        <svg className="Vlt-icon Vlt-black" dangerouslySetInnerHTML={{__html: githubIcon }} />
        <a href={ this.props.github_url } target="_blank"> Improve this page</a>
      </span>
    )
  }

  setSentiment(sentiment) {
    this.setState({
      sentiment,
      showExtendedFields: sentiment == 'negative',
      uploadingFeedbackSentiment: true,
      error: undefined,
    }, this.createOrUpdate)
  }

  createOrUpdate() {
    if (this.props.recaptcha.enabled && !this.props.recaptcha.skip && this.state.recaptcha_token == undefined) {
      const element = $('<div></div>').appendTo('#recaptcha-container')[0]

      const id = grecaptcha.render(element, {
        sitekey: this.props.recaptcha.sitekey,
        callback: this.invisibleCaptchaCallback.bind(this),
        size: 'invisible',
        badge: 'inline',
      })

      return grecaptcha.execute(id)
    }

    var request = new Request('/feedback/feedbacks', {
      method: 'POST',
      credentials: 'same-origin',
      body: JSON.stringify(this.parameters()),
      headers: {
        'Content-Type': 'application/json'
      }
    })

    fetch(request)
    .then((response) => {
      if (response.ok) { return response.json() }
      return Promise.reject({ message: 'Bad response from server', response })
    })
    .then((payload) => {
      this.setState({
        feedbackComplete: this.state.uploadingFeedbackFull,
        uploadingFeedbackSentiment: false,
        uploadingFeedbackFull: false,
        id: payload.id,
      })
    })
    .catch((error) => {
      console.log(error)

      this.setState({
        uploadingFeedbackSentiment: false,
        uploadingFeedbackFull: false,
      })

      if (error.response) {
        error.response.json()
          .then((payload) => {
            this.setState({ error: payload.error })
          })
          .catch(() => {
            this.setState({ error: "Something went wrong! Try again later" })
          })
      } else {
        this.setState({ error: "Something went wrong! Try again later" })
      }

    })
  }

  sendFeedback() {
    this.setState({
      uploadingFeedbackFull: true
    })

    this.createOrUpdate()
  }

  renderInlineMessage() {
    if (this.state.sentiment === undefined) { return }
    if (this.state.showExtendedFields) { return }

    return (
      <div>
        <hr/>
        <p>Great! <a onClick={ () => this.setState({ showExtendedFields: true }) }>Give us some feedback</a></p>
      </div>
    )
  }

  renderEmailField() {
    if (this.props.current_user) { return }

    return (
      <div className="Vlt-form__element Vlt-form__element--elastic">
      <p><strong>Can we let you know when we've solved your issue?</strong></p>
        <label className="Vlt-label">My email: <small className="Vlt-grey-darker">(optional)</small></label>        
        <div className="Vlt-input">
          <input type="email" size="20" value={ this.state.email } onChange={ (event) => this.setState({ email: event.target.value }) }/>
        </div>
      </div>
    )
  }

  renderUserDetails() {
    if (!this.props.current_user) { return }

    return (
      <p><br/>Logged in as { this.props.current_user.email }. <a href={ this.props.current_user.signout_path }>Sign out</a></p>
    )
  }

  sendFeedbackButtonDisabled() {
    if (this.state.uploadingFeedbackFull) { return true }
    if (this.state.comment === '') { return true }
    return false
  }

  renderExtendedFields() {
    if (!this.state.showExtendedFields) { return }
    if (!this.state.id) { return }
    if (this.state.feedbackComplete) { return }

    return (
      <div>
        <hr/>
        <p>We see that this page didn’t meet your expectations. We’re really sorry!<br/></p>
        <div className="Vlt-form__element">
          <p><strong>We’d like a chance to fix that. Please would you give us some more information?</strong></p>
          <label className="Vlt-label">What didn’t work for me: <small className="Vlt-grey-darker">(required)</small></label>
          <div className="Vlt-textarea">
            <textarea onChange={ (event) => this.setState({ comment: event.target.value }) }></textarea>
          </div>
        </div>

        { this.renderEmailField() }

        <input type="submit" className="Vlt-btn Vlt-btn--primary Vlt-btn--app" value="Send Feedback" onClick={ () => { this.sendFeedback() } } disabled={ this.sendFeedbackButtonDisabled() }/>
        <p>Your data will be treated in accordance with our <a href="https://www.nexmo.com/privacy-policy">Privacy Policy</a>, which sets out the rights you have in respect of your data.</p>
      </div>
    )
  }

  renderError() {
    if (!this.state.error) { return }

    return (
      <p className="form__error">{ this.state.error }</p>
    )
  }

  renderSentiments() {
    var unhappyIcon = '<use xlink:href="/symbol/volta-icons.svg#Vlt-icon-unhappy"/>';
    var happyIcon = '<use xlink:href="/symbol/volta-icons.svg#Vlt-icon-happy"/>';

    if (this.state.uploadingFeedbackSentiment) {
      return(
        <div>
          { (this.state.sentiment == 'negative' ?
            <div className="Vlt-spinner Vlt-spinner--small"></div>
            :
            <span className="Vlt-btn Vlt-btn--large Vlt-btn--tertiary Vlt-btn--icon Vlt-btn_disabled"><svg dangerouslySetInnerHTML={{__html: unhappyIcon }} /></span>
          ) }
          { (this.state.sentiment == 'positive' ?
            <div className="Vlt-spinner Vlt-spinner--small"></div>
           :
            <span className="Vlt-btn Vlt-btn--large Vlt-btn--tertiary Vlt-btn--icon Vlt-btn_disabled"><svg dangerouslySetInnerHTML={{__html: happyIcon }} /></span>
          )}
        </div>
      )
    } else {
      return(
        <div>
          <span onClick={ () => this.setSentiment('positive') } className={ "Vlt-btn Vlt-btn--large Vlt-btn--tertiary Vlt-btn--icon" + (this.state.sentiment == 'positive' ? ' Vlt-btn_active' : '') }><svg className="Vlt-green" dangerouslySetInnerHTML={{__html: happyIcon }} /></span>
          <span onClick={ () => this.setSentiment('negative') } className={ "Vlt-btn Vlt-btn--large Vlt-btn--tertiary Vlt-btn--icon" + (this.state.sentiment == 'negative' ? ' Vlt-btn_active' : '') }><svg className="Vlt-red" dangerouslySetInnerHTML={{__html: unhappyIcon }} /></span>
        </div>
      )
    }
  }

  renderFeedbackComplete() {
    if (!this.state.feedbackComplete) { return }

    return (
      <div>
        <hr/>
        <p>Thank you for your feedback</p>
      </div>
    )
  }

  render() {
    return (
      <div className="Vlt-box Vlt-box--left feedback">
        <div className="Vlt-grid">
          <div className="Vlt-col Vlt-col--3of4">
            <h5>Was this documentation helpful?</h5>
            <div className="sentiments">
              { this.renderSentiments() }
            </div>
          </div>
          <div className="Vlt-col Vlt-col--right Vlt-col--1of4">
            { this.renderFeedbackImproveThisPage() }
          </div>
        </div>

        { this.renderError() }
        { this.renderInlineMessage() }
        { this.renderExtendedFields() }
        { this.renderFeedbackComplete() }
        { this.renderUserDetails() }
      </div>
    )
  }
}

export default Feedback
