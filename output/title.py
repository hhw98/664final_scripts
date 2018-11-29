import csv
import pandas as pd
filename = 'movie_title.csv'
genre = []
with open(filename ,encoding='utf-8') as f:
    reader = csv.reader(f)
    for row in reader:
	    string = ''.join(row)
	    #print(string)
	    if string not in genre:
		    genre.append(string.strip())	
		    #print(string.strip())
data = {'genre':genre}
list = pd.DataFrame(data)
list.to_csv('title_unique.csv',index = False)
