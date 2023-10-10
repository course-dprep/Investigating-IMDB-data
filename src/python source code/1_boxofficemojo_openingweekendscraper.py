#!/usr/bin/env python
# coding: utf-8

# In[2]:


from bs4 import BeautifulSoup
import requests
import pandas as pd


base_url = 'https://www.boxofficemojo.com/chart/top_opening_weekend/?offset={}'

appended_data = []

num_pages = 5

for offset in range(0, num_pages * 200, 200):
    url = base_url.format(offset)
    request = requests.get(url)
    content = request.text
    soup = BeautifulSoup(content, 'html.parser')
    rows = soup.findAll('tr')

    for row in rows:
        data_row = {}
        data = row.findAll('td')
        if len(data) == 0:
            continue
        else:
            # Normaal weekend
            data_row['occasion'] = ""
            data_row['rank'] = data[0].text
        data_row['name'] = data[1].text
        data_row['openinggross'] = data[2].text
        data_row['totalgross'] = data[3].text
        data_row['percentage'] = data[4].text
        data_row['theathers'] = data[5].text
        data_row['average'] = data[6].text
        data_row['date'] = data[7].text
        appended_data.append(data_row)

weekend_data = pd.DataFrame(appended_data, columns=['name', 'openinggross', 'theathers'])


# Bestandsnaam voor het CSV-bestand
csv_filename = "weekend_data.csv"

weekend_data.to_csv(csv_filename, index=False)

print(weekend_data)

print(f"data is saved in: {csv_filename}.")


# In[ ]:




