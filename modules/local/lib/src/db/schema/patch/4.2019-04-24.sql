delete from  "quantity_unit" where unit = 'yr' OR unit = 'd' OR unit = 'm' OR unit = 'sqm' OR unit = 'mo';
update quantity_unit set intl = '{"1": "мл", "2": "ml"}' where unit = 'ml';