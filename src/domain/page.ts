export interface IPage {
  id: number;
  name: string;
  path: string;
  description: string;
}

export default class Page implements IPage {
  id: number;
  name: string;
  path: string;
  description: string;
  constructor(data: any) {
    this.id = data?.id;
    this.name = data?.name;
    this.path = data?.path;
    this.description = data?.description;
  }
}
