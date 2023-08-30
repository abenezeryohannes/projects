export class Location {
  id: number;
  latitude: number;
  longitude: number;
  address: string;
  constructor(data: any ) {
    this.id = data?.id;
    this.latitude = data?.latitude;
    this.longitude = data?.longitude;
    this.address = data?.address;
  }
}
