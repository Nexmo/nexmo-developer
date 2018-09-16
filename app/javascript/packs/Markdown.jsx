import 'whatwg-fetch'
import React from 'react'
import throttle from 'lodash/throttle'
import brace from 'brace'
import AceEditor from 'react-ace'

import 'brace/mode/markdown'
import 'brace/theme/monokai'

class Markdown extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      markdown: `
# Welcome to our Markdown Preview Editor

Here you can test Makdown with all the extra functionality that we've added in Nexmo Developer.

## Examples

**Labels**

You can have [labels].

They auto-magically color when you use verbs like [POST] or [DELETE]

**Tooltips (custom plugin)**

Find out ^[more](Tooltips are useful for when you have more information to convey, but don't want to break context.).

**Code**

\`\`\`ruby
def print_hi(name)
  puts "Hi #{name}"
end

print_hi('Adam')
#=> prints 'Hi Adam' to STDOUT.
\`\`\`

## Need Help?

Enjoy and checkout the [markdown guide](/contribute/guides/markdown-guide) to find out more.
      `.trim()
    }

    this.onMarkdownChange = this.onMarkdownChange.bind(this)
    this.getHTML = throttle(this.getHTML.bind(this), 500)

    this.getHTML()
  }

  onMarkdownChange(markdown) {
    this.setState({
      markdown: markdown
    })

    this.getHTML(markdown)
  }

  getHTML(markdown = this.state.markdown) {
    const request = new Request('/markdown', {
      method: 'POST',
      body: JSON.stringify({ markdown: this.state.markdown }),
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
        this.setState({ html: payload.html })
      })
  }

  render() {
    const options = {
      selectOnLineNumbers: true
    }

    return (
      <div className="flex flex--auto" style={{ minHeight: '80vh' }}>
        <div className="flex">
          <AceEditor
            mode="markdown"
            theme="monokai"
            value={ this.state.markdown }
            onChange={ this.onMarkdownChange }
            width="100%"
            height="auto"
            wrapEnabled={ true }
            editorProps={{ $blockScrolling: true }}
            scrollMargin={ [20, 0, 20, 0] }
          />
        </div>
        <div>
          <div dangerouslySetInnerHTML={{ __html: this.state.html }} id="primary-content"></div>
        </div>
      </div>
    )
  }
}

export default Markdown
