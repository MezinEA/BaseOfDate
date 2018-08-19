SELECT _regions.title_ru AS Region, _cities.area_ru AS Area, _cities.title_ru AS City FROM _regions
	LEFT JOIN _cities
		ON _regions.region_id = _cities.region_id
			WHERE _regions.title_ru = 'Московская область'
				order by City;