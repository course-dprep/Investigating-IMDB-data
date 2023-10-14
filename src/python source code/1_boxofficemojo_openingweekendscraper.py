#!/usr/bin/env python
# coding: utf-8

# In[2]:


from bs4 import BeautifulSoup
import requests
import pandas as pd

# Define the base URL with a placeholder for the offset
base_url = 'https://www.boxofficemojo.com/chart/top_opening_weekend/?offset={}'

appended_data = []

num_pages = 5  # Number of pages to scrape

# Loop through the specified number of pages
for offset in range(0, num_pages * 200, 200):
    url = base_url.format(offset)
    request = requests.get(url)
    content = request.text
    soup = BeautifulSoup(content, 'html.parser')
    
    # Find all table rows in the HTML
    rows = soup.findAll('tr')

    for row in rows:
        data_row = {}
        data = row.findAll('td')
        
        # Check if there is data in the row
        if len(data) == 0:
            continue
        else:
            # Extract data from columns
            data_row['occasion'] = ""  # Empty string for "occasion"
            data_row['rank'] = data[0].text
            data_row['name'] = data[1].text
            data_row['openinggross'] = data[2].text
            data_row['totalgross'] = data[3].text
            data_row['percentage'] = data[4].text
            data_row['theaters'] = data[5].text
            data_row['average'] = data[6].text
            data_row['date'] = data[7].text
            appended_data.append(data_row)

# Create a DataFrame from the appended data
weekend_data = pd.DataFrame(appended_data, columns=['occasion', 'rank', 'name', 'openinggross', 'totalgross', 'percentage', 'theaters', 'average', 'date'])

# Define the CSV filename
csv_filename = "weekend_data.csv"

# Save the DataFrame to a CSV file
weekend_data.to_csv(csv_filename, index=False)

# Print the DataFrame and the saved filename
print(weekend_data)
print(f"Data is saved in: {csv_filename}.")



# In[ ]:




