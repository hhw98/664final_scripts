'''
import pandas as pd
import csv
def read_csv(filename)
	list = []
	with open(filename ,encoding='utf-8') as f:
		reader = csv.reader(f)
		for row in reader:
			string = ''.join(row)
			if string not in list:
				list.append(string)
		return list
color = read_csv('color.csv')
content_rating = read_csv('content_rating .csv')
country = read_csv('country.csv')			
director_name = read_csv('director_name.csv')	
genres = read_csv('genres_unique.csv')
keywords = read_csv('keywords_unique.csv')
language = read_csv('language.csv')			
movie_title = read_csv('title_unique.csv')
data = {'genre':genre}
list = pd.DataFrame(data)
list.to_csv('final_movie_data.csv',index = True)
'''
import pandas as pd
import csv
with open('D:/664/project/input/csv/movie_metadata.csv', encoding = 'utf8') as f:
	reader = csv.reader(f)
	row1 = next(reader)
	#print(row1)
colnames = row1
data = pd.read_csv('D:/664/project/input/csv/movie_metadata.csv', names=colnames)
#print(data)
movie_title = data.movie_title.tolist()
title = []
for row in movie_title:
	if row not in title:
		title.append(row.strip())
title.remove(title[0])
duration = data.duration.tolist()
duration.remove(duration[0])
title_year = data.title_year.tolist()
title_year.remove(title_year[0])
imdb_score = data.imdb_score.tolist()
imdb_score.remove(imdb_score[0])
movie_imdb_link = data.movie_imdb_link.tolist()
movie_imdb_link.remove(movie_imdb_link[0])

color = data.color.tolist()
color.remove(color[0])
director_name = data.director_name.tolist()
director_name.remove(director_name[0])
language = data.language.tolist()
language.remove(language[0])
country = data.country.tolist()
country.remove(country[0])

plot_keywords = data.plot_keywords.tolist()
plot_keywords.remove(plot_keywords[0])
genres = data.genres.tolist()
genres.remove(genres[0])
content_rating = data.content_rating.tolist()
content_rating.remove(content_rating[0])

data_final = {'color':color, 'director':director_name, 'duration':duration, 'movie_title':title,'movie_imdb_link':movie_imdb_link, 'language':language, 'country':country, 'content_rating':content_rating, 'title_year':title_year, 'genres':genres,'keywords':plot_keywords, 'imdb_score':imdb_score}
list = pd.DataFrame(data_final)
list.to_csv('combine.csv',index = False)
#print(duration)