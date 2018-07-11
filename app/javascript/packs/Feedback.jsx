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

    return (
      <div className="columns small-4 right" id="feedback__improve">
        <p>
          <i className="icon icon-github"></i>
          <a href={ this.props.github_url } target="_blank">Improve this page</a>
        </p>
      </div>
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
      <span>Great! <a onClick={ () => this.setState({ showExtendedFields: true }) }>Give us some feedback</a>.</span>
    )
  }

  renderEmailField() {
    if (this.props.current_user) { return }

    return (
      <div>
        <label>Email (optional)</label>
        <input type="email" className="input" value={ this.state.email } onChange={ (event) => this.setState({ email: event.target.value }) }/>
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
    if (this.state.email === '' && this.state.comment === '') { return true }
    return false
  }

  renderExtendedFields() {
    if (!this.state.showExtendedFields) { return }
    if (!this.state.id) { return }
    if (this.state.feedbackComplete) { return }

    return (
      <div>
        <hr className="spacious"/>

        { this.renderEmailField() }

        <label>How could we improve it? (optional)</label>
        <textarea className="input" onChange={ (event) => this.setState({ comment: event.target.value }) }></textarea>
        <input type="submit" className="button" value="Send Feedback" onClick={ () => { this.sendFeedback() } } disabled={ this.sendFeedbackButtonDisabled() }/>

        <p><br />Your data will be treated in accordance with our <a href="https://www.nexmo.com/privacy-policy">Privacy Policy</a>, which sets out the rights you have in respect of your data.</p>
        
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
    if (this.state.uploadingFeedbackSentiment) {
      return(
        <div className="clearfix">
          <span className={ 'sentiment ' + (this.state.sentiment == 'negative' ? 'sentiment--loading' : 'sentiment--disabled') }>
            <div>
              <i className={ 'icon ' + ( this.state.sentiment == 'negative' ? 'icon-spinner' : 'icon-thumbs-o-down' )}></i>
            </div>
          </span>
          <span className={ 'sentiment ' + (this.state.sentiment == 'positive' ? 'sentiment--loading' : 'sentiment--disabled') }>
            <div>
              <i className={ 'icon ' + ( this.state.sentiment == 'positive' ? 'icon-spinner' : 'icon-thumbs-o-up' )}></i>
            </div>
          </span>
        </div>
      )
    } else {
      return(
        <div className="clearfix">
          <span onClick={ () => this.setSentiment('negative') } className={ "sentiment sentiment--negative " + (this.state.sentiment == 'negative' ? 'sentiment--active' : '') }><i className="icon icon-thumbs-o-down"></i></span>
          <span onClick={ () => this.setSentiment('positive') } className={ "sentiment sentiment--positive " + (this.state.sentiment == 'positive' ? 'sentiment--active' : '') }><i className="icon icon-thumbs-o-up"></i></span>
        </div>
      )
    }
  }

  renderFeedbackComplete() {
    if (!this.state.feedbackComplete) { return }

    return (
      <div>
        <hr className="spacious"/>

        <p>Thank you for your feedback.</p>
      </div>
    )
  }

  render() {
    return (
      <div className="feedback">
        <div className="row">
          <div className="columns small-8">
            <h2>Was this documentation helpful?</h2>
          </div>
          { this.renderFeedbackImproveThisPage() }
        </div>

        <div className="sentiments">
          { this.renderSentiments() }
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
