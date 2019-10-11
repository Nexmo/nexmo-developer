import { shallowMount } from '@vue/test-utils';
import JwtGenerator from 'components/jwt_generator/JwtGenerator.vue';

describe('JwtGenerator', function() {
  const validPrivateKey = `
    -----BEGIN RSA PRIVATE KEY-----
    MIICWwIBAAKBgQCiLg5YUKLk+m/wOBZ57b5e5wdd30lo/y5fGrN3tYp+6jb0ipYt
    rPfykwZvrqYvUkwnXlOrjFuUtRq19wG61mpfj0nyZVT4v+C0opOjQ2woaVV6MNSY
    ug49y2D7C+km30aOfrr6r35CMGd6JspgABmouleOPhtemPNj3cuiNnMxYwIDAQAB
    AoGAR8Tt4DM/Aum446tOdwK4vjKq1eXcDLTwhnHAffc+pM9tJma18tyalSRvMrkt
    Hb/jp4BcsovYc0R535DBmTcNtyjJxEGHk5dTKXMnc1iXP+VkXQDV2JWRVX1D9RGz
    7p8R5DkoNpEI1X0ZBA0H7swRZJdVu/Td02LY03qt6Kg3CKECQQD0qSJAr04s8bAp
    72pmdk6+SofeO1MoEuvL2SjJ83l4VzTIrNhUvBl8LyV2cpQ8LORTSczvRcWQS+7a
    9pGJYo1rAkEAqbJMhX+KoUeZIeZQacNWh2WqsKJDQ0Nx7csP8Y4CrfPJrlGlNlf3
    QYAMd1IhbBzHtw7/RJ1ZnWeMADmTMM0x6QJAC5wzGeq3xP47I+JOpEoc9n7G787U
    5WPweJ33h43cR8+rm5JIOc0rUG9UUciiLDDdLO6loP0ooO5ZiV6GDYT1vQJARzzK
    UuCP2dSsvEZrS3rtQDm1xiDYC8ysbx7nuofbKBtHdx5fNMkIyz5t/UlFLpWGYZqy
    HqPPkvx9ETsaR0pcwQJAQ2T6yTkW72gxdbAGXxDW0tjIA8NUZl2ViwB/XU8cMGev
    idcJKn+/vJij1MpyXLZGkgHXrZo1UxNQ9Fd1o/wpYw==
    -----END RSA PRIVATE KEY-----
  `;

  describe('callout', function() {
    describe('when inputs are empty', function() {
      it('renders a hint explaining how to the JWT is generated', function() {
        const wrapper = shallowMount(JwtGenerator);

        expect(wrapper.find('.Vlt-callout--tip').exists()).toBeTruthy();
        expect(wrapper.find('.Vlt-callout__content').text()).toEqual(
          'Use your private key and application_id to create a JWT for your Nexmo ApplicationThe JWT is generated on the client-side so your private key never leaves your browser.'
        );
      });
    })

    describe('when private key is provided', function() {
      describe('when it is invalid', function() {
        it('renders an error message once the application id is provided', function() {
          const wrapper = shallowMount(JwtGenerator);

          wrapper.find('#private-key').setValue('invalid key');

          expect(wrapper.find('.Vlt-callout--warning').exists()).toBeTruthy();
          expect(wrapper.find('.Vlt-callout__content').text()).toEqual(
            'Next, provide an Application ID'
          );

          wrapper.find('#application-id').setValue('applicationID');

          expect(wrapper.find('.Vlt-callout--critical').exists()).toBeTruthy();
          expect(wrapper.find('.Vlt-callout__content').text()).toEqual(
            'Invalid private key provided'
          );
        });
      });

      describe('when it is valid', function() {
        it('updates the jwt field', function() {
          const wrapper = shallowMount(JwtGenerator);

          wrapper.find('#private-key').setValue(validPrivateKey);

          expect(wrapper.find('.Vlt-callout--warning').exists()).toBeTruthy();
          expect(wrapper.find('.Vlt-callout__content').text()).toEqual(
            'Next, provide an Application ID'
          );

          wrapper.find('#application-id').setValue('applicationID');

          expect(wrapper.find('.Vlt-callout').isVisible()).toBeFalsy();
          expect(wrapper.find('#jwt').element.value).not.toEqual('');
        });
      });
    });

    describe('when application id is provided', function() {
      it('renders the corresponding hints', function() {
        const wrapper = shallowMount(JwtGenerator);

        wrapper.find('#application-id').setValue('applicationID');

        expect(wrapper.find('.Vlt-callout--warning').exists()).toBeTruthy();
        expect(wrapper.find('.Vlt-callout__content').text()).toEqual(
          'Next, provide a Private Key'
        );

        wrapper.find('#private-key').setValue('invalid key');
        expect(wrapper.find('.Vlt-callout--critical').exists()).toBeTruthy();
        expect(wrapper.find('.Vlt-callout__content').text()).toEqual(
          'Invalid private key provided'
        );

        wrapper.find('#private-key').setValue(validPrivateKey);

        expect(wrapper.find('.Vlt-callout').isVisible()).toBeFalsy();
        expect(wrapper.find('#jwt').element.value).not.toEqual('');
      });
    });

    describe('when acl is provided', function() {
      describe('when it is invalid', function() {
        it('renders an error message', function() {
          const wrapper = shallowMount(JwtGenerator);

          wrapper.find('#acl').setValue('invalid json');

          expect(wrapper.find('.Vlt-callout--critical').exists()).toBeTruthy();
          expect(wrapper.find('.Vlt-callout__content').text()).toEqual(
            'Invalid ACL provided. Must be JSON'
          );
        });
      });
    });
  });
});
