export class WrapperDto<Type> {
  statusCode?: number;
  success?: boolean;
  data?: Type;
  datas?: Type[];
  message?: string;
  count?: number;
  page?: number;
  current_page?: number;
  total_pages?: number;
  limit?: number;
  sort_by?: string;
  sort?: string;

  constructor(data: any) {
    this.statusCode = data?.statusCode;
    this.success = data?.success;
    this.datas = data?.datas;
    this.data = data?.data;
    this.message = data?.message;
    this.count = data?.count;
    this.page = data?.page;
    this.total_pages = data?.total_pages;
    this.limit = data?.limit;
    this.sort = data?.sort;
    this.sort_by = data?.sort_by;
    this.current_page = data?.page;
  }
}
