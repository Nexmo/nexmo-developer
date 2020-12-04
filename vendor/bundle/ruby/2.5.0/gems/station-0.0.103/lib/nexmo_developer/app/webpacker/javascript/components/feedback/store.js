export default {
  state: {
    path: null,
    sentiment: null,
    source: null,
    configId: null,
    steps: [],
    feedbackId: null,
    email: null
  },
  setPath: function(path) {
    this.state.path = path;
  },
  setSentiment: function(sentiment) {
    this.state.sentiment = sentiment;
  },
  setSource: function(source) {
    this.state.source = source;
  },
  setConfigId: function(id) {
    this.state.configId = id;
  },
  setFeedbackId: function(id) {
    this.state.feedbackId = id;
  },
  setEmail: function(email) {
    this.state.email = email;
  },
  addStep: function(step) {
    this.state.steps.push(step);
  },
  toParam: function() {
    return {
      feedback_config_id: this.state.configId,
      path: this.state.path,
      sentiment: this.state.sentiment,
      source: this.state.source,
      steps: this.state.steps,
      id: this.state.feedbackId,
      email: this.state.email
    }
  },
  clearState: function() {
    this.state.path = null;
    this.state.sentiment = null;
    this.state.steps = [];
    this.state.feedbackId = null;
    this.state.email = null;
  }
};
