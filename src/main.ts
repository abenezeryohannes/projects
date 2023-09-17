import { createApp } from "vue";
import "./assets/styles/styles.scss";
import "./assets/styles/index.css";
import App from "./App.vue";
import { store, key } from "./store";
import route from "./route";
import i18n from "./i18n";
import lazy from "vue3-lazyload";
import Toast, { PluginOptions } from "vue-toastification";

import "vue-toastification/dist/index.css";

const app = createApp(App);

const options: PluginOptions = {
  // You can set your default options here
};
app
  .use(store, key)
  .use(i18n)
  .use(route)
  .use(lazy, {})
  .use(Toast, options)
  .mount("#app");
