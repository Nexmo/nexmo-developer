<template>
  <div class="Vlt-card">
    <h1>JWT Generator</h1>
    <div v-show="!jwt" :class="[computedClass, 'Vlt-callout']">
      <i></i>
      <div v-if="invalidAcl" class="Vlt-callout__content">
        Invalid ACL provided. Must be JSON
      </div>
      <div v-else-if="invalidPrivateKey" class="Vlt-callout__content">
        Invalid private key provided
      </div>
      <div v-if="!invalidPrivateKey && !invalidAcl" v-html="callout" class="Vlt-callout__content"/>
    </div>
    <div class="Vlt-grid">

      <div class="Vlt-col">
        <h2>Parameters</h2>
        <div class="Vlt-form__element">
          <label class="Vlt-label">Private Key</label>
          <div class="Vlt-textarea">
            <textarea rows="8" cols="50" v-model="privateKey" id="private-key"></textarea>
          </div>
        </div>
        <div class="Vlt-form__element">
          <label class="Vlt-label">Application ID</label>
          <div class="Vlt-input">
            <input v-model="applicationId" id="application-id"/>
          </div>
        </div>
        <div class="Vlt-form__element">
          <label htmlFor="example-input-icon-button" class="Vlt-label">Valid For</label>
          <div class="Vlt-composite">
            <div class="Vlt-input">
              <input type="number" v-model.number="validFor" placeholder="6" />
            </div>

            <div class="Vlt-composite__append">
              <div class="Vlt-native-dropdown">
                <select v-model.number='validForTimeUnit' defaultValue="3600">
                  <option value="1">Seconds</option>
                  <option value="60">Minutes</option>
                  <option value="3600">Hours</option>
                  <option value="86400">Days</option>
                </select>
              </div>
            </div>

          </div>
        </div>
        <div class="Vlt-form__element">
          <label class="Vlt-label">Sub (optional)</label>
          <div class="Vlt-input">
            <input v-model="sub"/>
          </div>
        </div>
        <div class="Vlt-form__element">
          <label class="Vlt-label">ACL (optional)</label>
          <div class="Vlt-textarea">
            <textarea rows="4" cols="50" v-model="acl" id="acl"></textarea>
          </div>
        </div>
      </div>
      <div class="Vlt-col">
        <h2>Encoded</h2>
        <div class="Vlt-form__element">
          <label class="Vlt-label">Your JWT</label>
          <div class="Vlt-textarea">
            <textarea rows="29" cols="50" v-model="jwt" id="jwt"></textarea>
          </div>
        </div>
      </div>
    </div>
    <div class="Vlt-grid">
      <div class="Vlt-col">
        <h2>Decoded</h2>
        <div class="Vlt-table Vlt-table--data">
          <table>
            <thead>
              <tr>
                <th>Name</th>
                <th>Value</th>
                <th>Meaning</th>
              </tr>
            </thead>
            <tbody>
              <tr><td><code>application_id</code></td><td>{{applicationId}}</td><td>The application ID this JWT uses for authentication</td></tr>
              <tr><td><code>iat</code></td><td>{{iat}}</td><td>The time at which the token was issued</td></tr>
              <tr><td><code>nbf</code></td><td>{{nbf}}</td><td>The time at which the token should become valid</td></tr>
              <tr><td><code>exp</code></td><td>{{exp}}</td><td>The time at which the token should expire</td></tr>
              <tr><td><code>sub</code></td><td>{{sub}}</td><td>The subject identified by the JWT (only used for the Client SDKs)</td></tr>
              <tr><td><code>acl</code></td><td>{{acl}}</td><td>A list of permissions that this token will have</td></tr>
              <tr><td><code>jti</code></td><td>{{jti}}</td><td>A unique identifier for the JWT</td></tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { KJUR, KEYUTIL} from 'jsrsasign';

export default {
  data: function() {
    return {
      sub: '',
      acl: '',
      iat: '',
      jti: '',
      nbf: '',
      applicationId: '',
      validFor: '',
      validForTimeUnit:  3600,
      privateKey: '',
    }
  },
  created: function() {
    let tNow = KJUR.jws.IntDate.get('now');
    let tEnd = tNow + (3600*6);

    this.iat = tNow;
    this.nbf = tNow;
    this.jti = this.generateJti();
  },
  computed: {
    invalidAcl: function() {
      let invalid = false;

      if (this.acl) {
        try {
          JSON.parse(this.acl);
        } catch (e) {
          invalid = true;
        }
      }
      return invalid;
    },
    callout: function() {
      let message;

      if (this.privateKey) {
        if (!this.applicationId) {
          message = 'Next, provide an Application ID';
        }
      } else if (this.applicationId) {
        message = 'Next, provide a Private Key';
      } else {
        message = '<h4>Use your <code>private key</code> and <code>application_id</code> to create a JWT for your Nexmo Application</h4>The JWT is generated on the client-side so your private key <strong>never leaves your browser</strong>.';
      }
      return message;
    },
    exp: function() {
      let validFor = this.validFor || 6;
      return this.iat + (validFor * this.validForTimeUnit);
    },
    jwt: function() {
      let result = '';
      if (this.privateKey && this.applicationId) {
        try {
          result = this.generateJwt();
        } catch (e) {
          result = '';
        }
      }
      return result;
    },
    invalidPrivateKey: function() {
      let invalid = false;
      if (this.privateKey && this.applicationId) {
        try {
          this.generateJwt();
        } catch (e) {
          invalid = true;
        }
      }
      return invalid;
    },
    computedClass: function() {
      if (this.invalidPrivateKey || this.invalidAcl)
        return 'Vlt-callout--critical';
      if (this.applicationId && this.privateKey)
        return '';
      if (this.applicationId || this.privateKey)
        return 'Vlt-callout--warning';
      if (!this.applicationId && !this.privateKey)
        return 'Vlt-callout--tip';
    }
  },
  methods: {
    generateJti: function() {
      let text = "";
      let possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

      for (let i = 0; i < 12; i++) {
        text += possible.charAt(Math.floor(Math.random() * possible.length));
      }

      return text;
    },
    buildHeader: function() {
      return JSON.stringify({ typ: 'JWT', alg: 'RS256' });
    },
    buildPayload: function() {
      let payload = {};
      payload.iat = this.iat;
      payload.exp = this.exp;
      payload.jti = this.jti;
      payload.nbf = this.nbf;
      payload.applicationId = this.applicationId;
      if (this.sub) { payload.sub = this.sub; }
      if (this.acl) { payload.acl = JSON.parse(this.acl); }
      return JSON.stringify(payload);
    },
    generateJwt: function() {
      let prvKey = KEYUTIL.getKey(this.privateKey);
      return KJUR.jws.JWS.sign("RS256", this.buildHeader(), this.buildPayload(), prvKey);
    }
  }
}
</script>
