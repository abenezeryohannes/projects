import { createI18n, useI18n as defaultUseI18n } from "vue-i18n";
import enUS from "./locales/en-US.json";
import amET from "./locales/en-US.json";

// Type-define 'en-US' as the master schema for the resource
type MessageSchema = typeof enUS;

export default createI18n<[MessageSchema], "en-US" | "ar-KW">({
  legacy: false,
  locale: /*process.env.VUE_APP_I18N_LOCALE ||*/ "en-US",
  fallbackLocale: /*process.env.VUE_APP_I18N_FALLBACK_LOCALE ||*/ "en-US",
  messages: {
    "en-US": enUS,
    "ar-KW": amET,
  },
  silentTranslationWarn: true,
  missingWarn: false,
  fallbackWarn: false,
});

export function useI18n() {
  return defaultUseI18n<{ message: MessageSchema }>({
    useScope: "global",
  });
}
