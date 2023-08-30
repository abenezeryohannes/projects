import axios from "axios";

export function fM(
  amount: string,
  decimalCount = 2,
  decimal = ".",
  thousands = ","
) {
  try {
    //
    decimalCount = Math.abs(decimalCount);
    decimalCount = isNaN(decimalCount) ? 2 : decimalCount;

    const negativeSign = Number(amount) < 0 ? "-" : "";

    let i = parseInt(
      (amount = Math.abs(Number(amount) || 0).toFixed(decimalCount))
    ).toString();
    let j = i.length > 3 ? i.length % 3 : 0;

    return (
      negativeSign +
      (j ? i.substring(0, j) + thousands : "") +
      i.substring(j).replace(/(\d{3})(?=\d)/g, "KD 1" + thousands) +
      (decimalCount
        ? decimal +
          Math.abs(Number(amount) - Number(i))
            .toFixed(decimalCount)
            .slice(2)
        : "") +
      " KD"
    );
  } catch (e) {
    console.log(e);
  }
}

export function dd(dateString: Date | string, size: string) {
  var date = prepareDate(dateString, size);
  if (size == "t") return date;
  var ddd: string[] = date.replace(",", "").split(" ");
  var cd: string[] = [];
  ddd.forEach((d) => {
    isNaN(Number(d)) ? cd.push(d.toLowerCase()) : cd.push(d);
  });
  return capitalizeFirstLatter(cd.join().replace(",", " "));
}

function prepareDate(dateString: Date | string, size: string) {
  var string = null;
  if (dateString instanceof Date) {
    string = dateString.toLocaleDateString();
  } else if (typeof dateString === "string") {
    string = dateString;
  } else return showDate(new Date().toISOString(), size);

  if (string === "Invalid Date") string = new Date();

  return showDate(string, size);
}

function showDate(dateString: Date | string, size: string) {
  var date = new Date(dateString);
  if (size === null || size === "s") return date.toDateString();
  else if (size == "t") {
    let hours = date.getHours();
    let minutes = date.getMinutes();
    var ampm = hours >= 12 ? "pm" : "am";
    hours = hours % 12;
    hours = hours ? hours : 12; // the hour '0' should be '12'
    return `${hours > 9 ? hours : `0${hours}`} : ${
      minutes > 9 ? minutes : `0${minutes}`
    } ${ampm}`;
  } else return date.toDateString();
}

function capitalizeFirstLatter(str: string) {
  const arr = str.split(" ");
  for (var i = 0; i < arr.length; i++) {
    arr[i] = arr[i].charAt(0).toUpperCase() + arr[i].slice(1);
  }
  const str2 = arr.join(" ");
  return str2;
}

export async function loadJsonFileToList<T>(filePath: string): Promise<T[]> {
  const response = await axios.get(filePath);
  const json = response.data;
  const list = json.map((obj: any) => Object.assign(new Object(), obj));
  return list;
}
