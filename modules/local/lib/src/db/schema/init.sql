ALTER TABLE "place" ADD FOREIGN KEY (region_code) REFERENCES region (code) ON DELETE SET NULL;

ALTER TABLE "address" ADD FOREIGN KEY (country_id) REFERENCES country(country_id) ON DELETE SET NULL;
ALTER TABLE "address" ADD FOREIGN KEY (place_id) REFERENCES place(place_id) ON DELETE SET NULL;
ALTER TABLE "address" ADD FOREIGN KEY (region_id) REFERENCES region(code) ON DELETE SET NULL;