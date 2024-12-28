import pandas as pd

url = "https://appstore25042024.blob.core.windows.net/data/ActivityLog-01.csv"

response = pd.read_csv(url)
pd.set_option('display.max_columns', None) 
pd.set_option('display.max_rows', None)
print(response)
