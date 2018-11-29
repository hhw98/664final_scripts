import logging
import os
import pandas as pd
import sys as sys


def main(argv=None):
	"""
	Utilize Pandas library to read in movie_data .csv file (tab delimited).
	Extract regions, sub-regions, intermediate regions, country and areas, and
	other column data.  Filter out duplicate values and NaN values and sort the
	series in alphabetical order. Write out each series to a .csv file for inspection.
	"""
	if argv is None:
		argv = sys.argv

	msg = [
		'Source file read {0}',
		'color written to file {0}',
		'director name written to file {0}',
		'genres written to file {0}',
		'movie_title written to file {0}',
		'plot keywords written to file {0}',
		'language written to file {0}',
		'country written to file {0}',
		'UNESCO heritage site regions written to file {0}'
	]

	# Setting logging format and default level
	logging.basicConfig(format='%(levelname)s: %(message)s', level=logging.DEBUG)

	# Read in movie data set (tabbed separator)
	data_csv = './input/csv/movie_metadata.csv'
	data_frame = read_csv(data_csv, ',')
	logging.info(msg[0].format(os.path.abspath(data_csv)))

	# Write color to a .csv file.
	color = extract_filtered_series(data_frame, 'color')
	color_csv = './output/color.csv'
	write_series_to_csv(color, color_csv, '\t', False)
	logging.info(msg[1].format(os.path.abspath(color_csv)))

	# Write director name to a .csv file.
	director_name = extract_filtered_series(data_frame, 'director_name')
	director_name_csv = './output/director_name.csv'
	write_series_to_csv(director_name, director_name_csv, '\t', False)
	logging.info(msg[2].format(os.path.abspath(director_name_csv)))

	# Write genres to a .csv file.
	genres = extract_filtered_series(data_frame, 'genres')
	genres_csv = './output/genres.csv'
	write_series_to_csv(genres, genres_csv, '\t', False)
	logging.info(msg[3].format(os.path.abspath(genres_csv)))

	# Write movie_title to a .csv file.
	movie_title = extract_filtered_series(data_frame, 'movie_title')
	movie_title_csv = './output/movie_title.csv'
	write_series_to_csv(movie_title, movie_title_csv, '\t', False)
	logging.info(msg[4].format(os.path.abspath(movie_title_csv)))

	# Write plot keywords to a .csv file.
	plot_keywords = extract_filtered_series(data_frame, 'plot_keywords')
	plot_keywords_csv = './output/plot_keywords.csv'
	write_series_to_csv(plot_keywords, plot_keywords_csv, '\t', False)
	logging.info(msg[5].format(os.path.abspath(plot_keywords_csv)))

	# Write language a .csv file
	language = extract_filtered_series(data_frame, 'language')
	language_csv = './output/language.csv'
	write_series_to_csv(language, language_csv, '\t', False)
	logging.info(msg[6].format(os.path.abspath(language_csv)))

	# Write country to a .csv file
	country = extract_filtered_series(data_frame, 'country')
	country_csv = './output/country.csv'
	write_series_to_csv(country, country_csv, '\t', False)
	logging.info(msg[7].format(os.path.abspath(country_csv)))

	# Write content_rating to a .csv file
	content_rating  = extract_filtered_series(data_frame, 'content_rating')
	content_rating_csv = './output/content_rating .csv'
	write_series_to_csv(content_rating , content_rating_csv, '\t', False)
	logging.info(msg[8].format(os.path.abspath(content_rating_csv)))



def extract_filtered_series(data_frame, column_name):
	"""
	Returns a filtered Panda Series one-dimensional ndarray from a targeted column.
	Duplicate values and NaN or blank values are dropped from the result set which is
	returned sorted (ascending).
	:param data_frame: Pandas DataFrame
	:param column_name: column name string
	:return: Panda Series one-dimensional ndarray
	"""
	return data_frame[column_name].drop_duplicates().dropna().sort_values()
def extract_filtered_series_2(data_frame, column_name1, column_name2):
	"""
	Returns a filtered Panda Series one-dimensional ndarray from a targeted column.
	Duplicate values and NaN or blank values are dropped from the result set which is
	returned sorted (ascending).
	:param data_frame: Pandas DataFrame
	:param column_name: column name string
	:return: Panda Series one-dimensional ndarray
	"""
	return data_frame[column_name1, column_name2].drop_duplicates().dropna().sort_values()

def read_csv(path, delimiter=','):
	"""
	Utilize Pandas to read in *.csv file.
	:param path: file path
	:param delimiter: field delimiter
	:return: Pandas DataFrame
	"""
	return pd.read_csv(path, sep=delimiter, encoding='utf-8', engine='python')


def write_series_to_csv(series, path, delimiter=',', row_name=True):
	"""
	Write Pandas DataFrame to a *.csv file.
	:param series: Pandas one dimensional ndarray
	:param path: file path
	:param delimiter: field delimiter
	:param row_name: include row name boolean
	"""
	series.to_csv(path, sep=delimiter, index=row_name)


if __name__ == '__main__':
	sys.exit(main())
