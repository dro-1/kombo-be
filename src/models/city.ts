import db from "../utils/db";
import { escape, RowDataPacket } from "mysql2";

type CityName = {
  fr: string;
  it: string;
  es: string;
  en: string;
  de: string;
  nl: string;
  pt: string;
};

interface City extends RowDataPacket {
  id: string;
  name_fr: string;
  name_it: string;
  name_es: string;
  name_en: string;
  name_de: string;
  name_nl: string;
  name_pt: string;
  location_lat: number;
  location_lng: number;
}

export class CityController {
  city: City;

  constructor(city: City) {
    this.city = city;
  }

  static fetchAll = () => {
    return db.execute("SELECT * FROM city");
  };

  static findByInput = (input: string, language: string) => {
    language = escape(`name_${language}`).substring(1, 8);
    input = escape(input + "%");

    return db.execute<City[]>(
      `SELECT * FROM city WHERE ${language} LIKE ${input} LIMIT 20`
    );
  };
}
