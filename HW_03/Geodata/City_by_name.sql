SELECT _countries.title_ru AS COUNTRY, _regions.title_ru AS Region, _cities.area_ru AS Area, _cities.title_ru AS City FROM _countries
	LEFT JOIN _regions
		ON _countries.country_id = _regions.country_id
			LEFT JOIN _cities 
				ON _regions.region_id = _cities.region_id
					WHERE _cities.title_ru = 'Москва';