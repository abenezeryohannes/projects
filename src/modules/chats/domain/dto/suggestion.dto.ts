export class SuggestionDTO {
  title: string;
  text: string;
  isActive: boolean;
  constructor(data: any) {
    if (data.title != undefined && data.title != null) {
      this.title = data.title;
    }
    if (data.text != undefined && data.text != null) {
      this.text = data.text;
    }
    if (data.isActive != undefined && data.isActive != null) {
      this.isActive = data.isActive;
    }
  }
}
