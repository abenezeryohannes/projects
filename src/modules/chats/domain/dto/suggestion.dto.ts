export class SuggestionDTO {
  title: string;
  text: string;
  arabicTitle: string;
  arabicText: string;
  isActive: boolean;
  constructor(data: any) {
    if (data.title != undefined && data.title != null) {
      this.title = data.title;
    }
    if (data.arabicTitle != undefined && data.arabicTitle != null) {
      this.arabicTitle = data.arabicTitle;
    }
    if (data.text != undefined && data.text != null) {
      this.text = data.text;
    }
    if (data.arabicText != undefined && data.arabicText != null) {
      this.arabicText = data.arabicText;
    }
    if (data.isActive != undefined && data.isActive != null) {
      this.isActive = data.isActive;
    }
  }
}
