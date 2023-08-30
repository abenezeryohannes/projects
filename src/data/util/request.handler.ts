// const axios = require('axios')
import axios from "axios";
import debug from "./debug.util.ts";

export default class RequestHandler {
  base_url = "http://localhost:3000/api/v1";

  async get(path: string, params: any): Promise<any> {
    const url = this.base_url + "/" + path;
    // GET request using axios with set headers
    const token: string | null = localStorage.getItem("token") as string;
    const headers = {
      "Content-Type": "application/json",
      Authorization: /*"Bearer " + */ token,
    };

    var response = null;
    try {
      response = await axios.get(url, { params: params, headers: headers });
      return response;
    } catch (e) {
      response = e;
      throw e;
    }
  }

  async post(path: string, request: any): Promise<any> {
    const token = localStorage.getItem("token");
    const header = {
      Authorization: /*"Bearer " + */ token,
      "Content-Type": "application/json",
    };

    const url = this.base_url + "/" + path;
    debug(url, request);

    try {
      var response = await axios.post(url, request, { headers: header });
    } catch (e: any) {
      debug(e.message);
      throw e;
    }

    if (response == null) {
      return null;
    }
    return response;
  }

  async postForm(path: string, request: any, files: any[]): Promise<any> {
    const token = localStorage.getItem("token");

    const header = {
      Authorization: "Bearer " + token,
      "Content-Type": "multipart/form-data",
    };

    const filenames = files.map((x: any) => {
      return x.name;
    });

    let formData = new FormData();

    for (const [key, value] of Object.entries(request)) {
      if (!filenames.includes(key)) {
        if (typeof value === "string") formData.append(key, value);
        else formData.append(key, JSON.stringify(value));
      }
    }

    if (files != null)
      files.forEach((file: any) => {
        if (file != null && file.file != null) {
          if (Array.isArray(file.file)) {
            for (var i = 0; i < file.file.length; i++) {
              formData.append(file.name, file.file[i]);
            }
          } else formData.append(file.name, file.file);
        }
      });

    const url = this.base_url + "/" + path;
    debug(url as any);

    try {
      var response = await axios.post(url, formData, { headers: header });
    } catch (e: any) {
      debug(e.message);
      debug(e.response.data);
      throw e;
    }

    if (response == null) {
      return null;
    } else if (response.status == 206) {
      console.log("success: false");
      return response.data.message;
    }
    return response;
  }

  mapToFormData(formData: any, request: any) {
    for (const [key, value] of Object.entries(request)) {
      formData[key] = value;
    }
    return formData;
  }
}
