import csv
import pandas as pd
filename = 'plot_keywords.csv'
genre = []
with open(filename ,encoding='utf-8') as f:
    reader = csv.reader(f)
    for row in reader:
        string = ''.join(row)
        word = string.split('|')
        for ele in word:
            if ele not in genre:
                genre.append(ele)
            else:
                pass
        #print(word)
data = {'genre':genre}
list = pd.DataFrame(data)
list.to_csv('keywords_unique.csv',index = False)
