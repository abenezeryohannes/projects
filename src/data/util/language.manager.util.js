class LanguageManager{

  loadLanguage(language, user){
    if(user == null) this.setLanguage(language, 'en');
    else this.setLanguage(language, user.lang);
  }

  setLanguage(language, locale){
      if(locale == null || locale.toLowerCase().startsWith('en')){
        language.locale = 'en';
      }else if(locale.toLowerCase().startsWith('am')){
        language.locale = 'am';
      }else if(locale.toLowerCase().startsWith('or')){
        language.locale = 'or';
      }else language.locale = 'en';
  }


}

export default new LanguageManager();