export default () => {
    let hasTriggeredCopyStat = {};
    let hasTriggeredLinkStat = {};

    // Track copy to clipboard usage
    var clipboard = new Clipboard('.copy-button',{
        text: function(trigger) {
            return $(trigger).next().text();
        }
    });

    clipboard.on('success', function(e) {
        let trigger = $(e.trigger);

        let params = {
            "language": trigger.attr("data-lang"),
            "block": trigger.attr("data-block"),
            "section": trigger.attr("data-section"),
            "event": "copy"
        };

        let key = params['language'] + params['section'] + params['block'];

        // We only want to track each copy once per page load
        if (hasTriggeredCopyStat[key]) { return true; }

        trigger.find('span').text('Copied');

        fetch(createRequest(params))
            .then((response) => {
                if (response.ok) { return response.json() }
                return Promise.reject({ message: 'Bad response from server', response })
            })
            .then((payload) => {
                hasTriggeredCopyStat[key] = true;
            })

        // Can we point them to the dependencies too?
        if (trigger.parent().hasClass("main-code")) {
            trigger.parent().parent().find(".configure-dependencies").prepend("<span class='label label--small'>Don't forget me!</span>");
        }

    });


    clipboard.on('error', function(e) {
        console.error('Action:', e.action);
        console.error('Trigger:', e.trigger);
    });

    // Track source link usage
    $(document).on('mousedown', '.source-link', function(e){
        if (e.which === 3) { return; }
        let trigger = $(this);

        let section = trigger.attr("data-section");

        let params = {
            "language": trigger.attr("data-lang"),
            "block": trigger.attr("data-block"),
            "section": section,
            "event": "source"
        };

        let key = params['language'] + params['section'];

        if (hasTriggeredLinkStat[key]) { return true; }

        fetch(createRequest(params))
            .then((response) => {
                if (response.ok) { return response.json() }
                return Promise.reject({ message: 'Bad response from server', response })
            })
            .then((payload) => {
                hasTriggeredLinkStat[key] = true;
            })
    });
};

function createRequest(params) {
    return new Request('/usage/building_block', {
        method: 'POST',
        credentials: 'same-origin',
        body: JSON.stringify(params),
        headers: {
            'Content-Type': 'application/json'
        }
    });
}
