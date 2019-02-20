---
title: Java
navigation_weight: 1
---

``` Java
void loginToSdk(String token) {
    NexmoClient.get().login(token, new NexmoRequestListener<NexmoUser>() {

        @Override
        public void onError(NexmoApiError nexmoApiError) {}

        @Override
        public void onSuccess(NexmoUser user) {
            NexmoHelper.user = user;

            Intent intent = new Intent(getBaseContext(), CreateCallActivity.class);
            startActivity(intent);
            finish();
        }
    });
}
```