import { User } from "../../domain/models/user";

class ThemeMangerUtil{

    async loadTheme(user: User): Promise<string>{
        if(user == null) return this.setTheme('light');
        else return this.setTheme(user.theme);
        
    }

    setTheme(theme: string): string{
        if(theme == null || theme?.toLowerCase().startsWith('light')){
            document.documentElement.classList.remove('dark')
        }else{
            document.documentElement.classList.add('dark')
        }
        return theme;
    }

    getTheme(user: User){
        if(user == null) return 'light';
        else return user.theme;
    }

}

export default new ThemeMangerUtil();