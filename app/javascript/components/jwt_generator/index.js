import React, { Component } from 'react';
import { KJUR, KEYUTIL} from 'jsrsasign';

class JWTGenerator extends Component {

    constructor(args) {
        super(args)
        var tNow = KJUR.jws.IntDate.get('now');
        var tEnd = tNow + (3600*6)
        this.state ={
            sub: '',
            acl: '',
            iat: tNow,
            exp: tEnd,
            jti: this.generateJti(12),
            nbf: tNow,
            application_id: "",
            invalidPrivateKey: false
        };
    }

    generateJti(jtiLength) {
        var text = "";
        var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

        for (var i = 0; i < jtiLength; i++) {
            text += possible.charAt(Math.floor(Math.random() * possible.length));
        }

        return text;
    }

    generateJwt(privateKeyString) {
        this.setState({
            invalidPrivateKey: false
        });

        if (!privateKeyString || !this.state.application_id) {
            this.jwtOutput.value = '';
            return;
        }

        // Header
        var oHeader = {typ: 'JWT', alg: 'RS256'};

        // Payload
        var oPayload = {};
        oPayload.iat = this.state.iat;
        oPayload.exp = this.state.exp;
        oPayload.jti = this.state.jti;
        oPayload.nbf = this.state.nbf;
        oPayload.application_id = this.state.application_id;
        if (this.state.sub) {
            oPayload.sub = this.state.sub;
        }
        if (this.state.acl) {
          oPayload.acl = JSON.parse(this.state.acl);
        }

        var sHeader = JSON.stringify(oHeader);
        var sPayload = JSON.stringify(oPayload);
        try {
            var prvKey = KEYUTIL.getKey(privateKeyString);
        } catch (e) {
            this.setState({
                invalidPrivateKey: true
            });
            return;
        }
        var sJWT = KJUR.jws.JWS.sign("RS256", sHeader, sPayload, prvKey);
        this.jwtOutput.value = sJWT;
    }

    handlePrivateKeyChange() {
        this.generateJwt(this.privateKeyInput.value)
    }

    handleApplicationIdChange() {
        this.setState({
            "application_id": this.applicationIdInput.value
        }, () => {
            this.generateJwt(this.privateKeyInput.value)
        });
    }

    handleValidForChange() {
        // Calculate exp as iat + valid for
        let validFor = this.validForInput.value;
        if (!validFor) {
            validFor = 6;
        }
        let exp = this.state.iat + (validFor * this.validForDropdown.value);
        this.setState({
            "exp": exp,
        }, () => {
            this.generateJwt(this.privateKeyInput.value)
        });
    }

    handleSubChange() {
        this.setState({
            "sub": this.subInput.value
        }, () => {
            this.generateJwt(this.privateKeyInput.value)
        });
    }

    handleAclChange() {
        this.setState({
            "acl": this.aclInput.value
        }, () => {
            this.generateJwt(this.privateKeyInput.value)
        });
    }

    renderCallout() {

        let message = `<h4>Use your <code>private key</code> and <code>application_id</code> to create a JWT for your Nexmo Application</h4>The JWT is generated on the client-side so your private key <strong>never leaves your browser</strong>.`;
        let calloutType = 'tip';

        // If they've provided an invalid private key, tell them that
        if (this.state.invalidPrivateKey) {
            return this.generateCallout('critical', 'Invalid private key provided');
        }

        if (!this.privateKeyInput) {
            return this.generateCallout('tip', message);
        }

        if (this.state.acl) {
            try {
                JSON.parse(this.state.acl);
            } catch (e) {
                return this.generateCallout('critical', 'Invalid ACL provided. Must be JSON');
            }
        }

        if (this.privateKeyInput.value && this.applicationIdInput.value) {
            return '';
        }

        if (!this.privateKeyInput.value && !this.applicationIdInput.value) {
            return this.generateCallout('tip', message);
        }

        if (!this.privateKeyInput.value) {
            return this.generateCallout('warning', 'Next, provide a Private Key');
        }

        if (!this.applicationIdInput.value) {
            return this.generateCallout('warning', 'Next, provide an Application ID');
        }

        return callout;

    }

    generateCallout(type, text) {
       return ( <div className={'Vlt-callout Vlt-callout--' + type}>
                <i></i>
                <div className="Vlt-callout__content" dangerouslySetInnerHTML={{__html: text}}>
                </div>
            </div>
        );
    }

    render() {
        return (
            <div>
                <h1>JWT Generator</h1>
                {this.renderCallout()}
                <div className="Vlt-grid">

                    <div className="Vlt-col">
                        <h2>Parameters</h2>
                        <div className="Vlt-form__element">
                            <label className="Vlt-label">Private Key</label>
                            <div className="Vlt-textarea">
                                <textarea rows="8" cols="50" ref={(e) => this.privateKeyInput = e} onChange={this.handlePrivateKeyChange.bind(this)}></textarea>
                            </div>
                        </div>
                        <div className="Vlt-form__element">
                            <label className="Vlt-label">Application ID</label>
                            <div className="Vlt-input">
                                <input ref={(e) => this.applicationIdInput = e} onChange={this.handleApplicationIdChange.bind(this)} />
                            </div>
                        </div>
                        <div className="Vlt-form__element">
                            <label htmlFor="example-input-icon-button" className="Vlt-label">Valid For</label>
                            <div className="Vlt-composite">
                                <div className="Vlt-input">
                                    <input type="number" ref={(e) => this.validForInput = e} onChange={this.handleValidForChange.bind(this)} placeholder="6" />
                                </div>

                                <div className="Vlt-composite__append">
                                    <div className="Vlt-native-dropdown">
                                        <select ref={(e) => this.validForDropdown = e} onChange={this.handleValidForChange.bind(this)} defaultValue="3600">
                                            <option value="1">Seconds</option>
                                            <option value="60">Minutes</option>
                                            <option value="3600">Hours</option>
                                            <option value="86400">Days</option>
                                        </select>
                                    </div>
                                </div>

                            </div>
                        </div>
                         <div className="Vlt-form__element">
                            <label className="Vlt-label">Sub (optional)</label>
                            <div className="Vlt-input">
                                <input ref={(e) => this.subInput = e} onChange={this.handleSubChange.bind(this)} />
                            </div>
                        </div>
                        <div className="Vlt-form__element">
                            <label className="Vlt-label">ACL (optional)</label>
                            <div className="Vlt-textarea">
                                <textarea rows="4" cols="50" ref={(e) => this.aclInput = e} onChange={this.handleAclChange.bind(this)}></textarea>
                            </div>
                        </div>
                    </div>
                   <div className="Vlt-col">
                        <h2>Encoded</h2>
                        <div className="Vlt-form__element">
                            <label className="Vlt-label">Your JWT</label>
                            <div className="Vlt-textarea">
                                <textarea rows="29" cols="50" ref={(e) => this.jwtOutput = e}></textarea>
                            </div>
                        </div>
                    </div>
                </div>
                <div className="Vlt-grid">
                    <div className="Vlt-col">
                        <h2>Decoded</h2>
                        <div className="Vlt-table Vlt-table--data">
                            <table>
                                <thead>
                                <tr>
                                    <th>Name</th>
                                    <th>Value</th>
                                    <th>Meaning</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr><td><code>application_id</code></td><td>{this.state.application_id}</td><td>The application ID this JWT uses for authentication</td></tr>
                                <tr><td><code>iat</code></td><td>{this.state.iat}</td><td>The time at which the token was issued</td></tr>
                                <tr><td><code>nbf</code></td><td>{this.state.nbf}</td><td>The time at which the token should become valid</td></tr>
                                <tr><td><code>exp</code></td><td>{this.state.exp}</td><td>The time at which the token should expire</td></tr>
                                <tr><td><code>sub</code></td><td>{this.state.sub}</td><td>The subject identified by the JWT (only used for the Client SDKs)</td></tr>
                                <tr><td><code>acl</code></td><td>{this.state.acl}</td><td>A list of permissions that this token will have</td></tr>
                                <tr><td><code>jti</code></td><td>{this.state.jti}</td><td>A unique identifier for the JWT</td></tr>
                                </tbody>
                            </table>
                        </div>
                    </div>

                </div>
            </div>
        );
    }
}

export default JWTGenerator;
